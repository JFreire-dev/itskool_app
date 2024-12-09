import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/usuario.dart';

part 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  UsuarioCubit() : super(UsuarioInicial());

  void iniciarSesion(String email, String password) {
    try {
      emit(UsuarioCargando());
      // Simulación de inicio de sesión
      final usuario = Usuario(
        id: '1',
        nombre: 'José Freire',
        email: email,
      );
      emit(UsuarioAutenticado(usuario: usuario));
    } catch (e) {
      emit(UsuarioError(mensaje: 'Error al iniciar sesión'));
    }
  }

  void cerrarSesion() {
    emit(UsuarioInicial());
  }
}
