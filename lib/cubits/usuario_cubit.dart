import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/usuario.dart';
import 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  UsuarioCubit() : super(UsuarioInitial());

  void cargarUsuario() async {
    try {
      emit(UsuarioCargando());
      await Future.delayed(const Duration(seconds: 2)); // Simulación de carga
      final usuario = Usuario(
        id: '1',
        nombre: 'Prueba Usuario',
        email: 'prueba@example.com',
      );
      emit(UsuarioAutenticado(usuario));
    } catch (e) {
      emit(UsuarioError('Error al cargar usuario'));
    }
  }

  void iniciarSesion(String email, String password) async {
    try {
      emit(UsuarioCargando());
      await Future.delayed(
          const Duration(seconds: 2)); // Simulación de autenticación
      if (email == 'prueba@example.com' && password == '1234') {
        final usuario = Usuario(
          id: '1',
          nombre: 'Prueba Usuario',
          email: email,
        );
        emit(UsuarioAutenticado(usuario));
      } else {
        emit(UsuarioError('Credenciales incorrectas'));
      }
    } catch (e) {
      emit(UsuarioError('Error al iniciar sesión'));
    }
  }
}
