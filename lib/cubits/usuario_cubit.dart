import 'package:bloc/bloc.dart';
import '../firebase/firebase_auth_service.dart';
import '../models/usuario.dart';
import '../models/profesor.dart';
import '../models/estudiante.dart';
import '../models/apoderado.dart';
import 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  UsuarioCubit() : super(UsuarioInitial());

  /// Iniciar sesión usando FirebaseAuthService
  void iniciarSesion(String email, String password) async {
    try {
      emit(UsuarioCargando());
      print("Iniciando sesión...");

      final String? error = await FirebaseAuthService().iniciarSesion(
        email: email,
        password: password,
      );

      if (error == null) {
        final user = FirebaseAuthService().usuarioActual;

        if (user != null) {
          print("Usuario autenticado correctamente: UID ${user.uid}");
          final datosUsuario =
              await FirebaseAuthService().obtenerDatosUsuario(user.uid);

          if (datosUsuario != null) {
            final usuario =
                _mapearUsuarioDesdeDatos(user.uid, datosUsuario, user.email);
            emit(UsuarioAutenticado(usuario));
            print("Estado emitido: UsuarioAutenticado - ${usuario.toString()}");
          } else {
            emit(UsuarioError('Error: No se encontraron datos del usuario.'));
          }
        } else {
          emit(UsuarioError('Error: No se pudo obtener el usuario.'));
        }
      } else {
        emit(UsuarioError(error));
      }
    } catch (e) {
      emit(UsuarioError('Error al iniciar sesión: $e'));
    }
  }

  /// Helper: Mapea los datos del usuario desde Firestore a la clase correspondiente
  Usuario _mapearUsuarioDesdeDatos(
      String uid, Map<String, dynamic> datos, String? email) {
    final tipoUsuario = datos['tipoUsuario'] ?? 'Desconocido';
    final nombre = datos['nombre'] ?? 'Nombre no disponible';

    switch (tipoUsuario) {
      case 'Estudiante':
        return Estudiante(
          id: uid,
          nombre: nombre,
          email: email ?? 'Correo no disponible',
          curso: datos['curso'] ?? '',
        );
      case 'Profesor':
        return Profesor(
          id: uid,
          nombre: nombre,
          email: email ?? 'Correo no disponible',
          cursos:
              datos['cursos'] != null ? List<String>.from(datos['cursos']) : [],
          asignaturasPorCurso: datos['asignaturasPorCurso'] != null
              ? Map<String, List<String>>.from(datos['asignaturasPorCurso'])
              : {},
          cursoAdmin: datos['cursoAdmin'],
        );
      case 'Apoderado':
        return Apoderado(
          id: uid,
          nombre: nombre,
          email: email ?? 'Correo no disponible',
          pupilos: const [], // Puedes agregar lógica para cargar pupilos si es necesario
        );
      default:
        return Usuario(
          id: uid,
          nombre: nombre,
          email: email ?? 'Correo no disponible',
          tipoUsuario: tipoUsuario,
        );
    }
  }

  /// Cerrar sesión
  void cerrarSesion() async {
    try {
      emit(UsuarioCargando());
      await FirebaseAuthService().cerrarSesion();
      emit(UsuarioInitial());
    } catch (e) {
      emit(UsuarioError('Error al cerrar sesión: $e'));
    }
  }
}
