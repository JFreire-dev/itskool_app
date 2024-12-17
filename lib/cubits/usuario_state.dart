import 'package:equatable/equatable.dart';
import '../models/usuario.dart';

abstract class UsuarioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsuarioInitial extends UsuarioState {}

class UsuarioCargando extends UsuarioState {}

class UsuarioAutenticado extends UsuarioState {
  final Usuario usuario;

  UsuarioAutenticado(this.usuario);

  @override
  List<Object?> get props => [usuario];
}

class UsuarioError extends UsuarioState {
  final String mensaje; // Solo un mensaje de error

  UsuarioError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}
