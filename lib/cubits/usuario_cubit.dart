import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/usuario.dart';
import 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  UsuarioCubit() : super(UsuarioInitial());

  void iniciarSesion(String email, String password) async {
    emit(UsuarioCargando());
    await Future.delayed(const Duration(seconds: 1)); // Simulación de carga

    if (email == 'prueba@example.com' && password == '123456') {
      emit(UsuarioAutenticado(
          Usuario(id: '1', nombre: 'Prueba Usuario', email: email)));
    } else {
      emit(const UsuarioError('Credenciales incorrectas'));
    }
  }

  void cerrarSesion() {
    emit(UsuarioInitial());
  }
}
