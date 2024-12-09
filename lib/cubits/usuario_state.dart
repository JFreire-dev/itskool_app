part of 'usuario_cubit.dart';

abstract class UsuarioState extends Equatable {
  const UsuarioState();

  @override
  List<Object?> get props => [];
}

class UsuarioInicial extends UsuarioState {}

class UsuarioCargando extends UsuarioState {}

class UsuarioAutenticado extends UsuarioState {
  final Usuario usuario;

  const UsuarioAutenticado({required this.usuario});

  @override
  List<Object?> get props => [usuario];
}

class UsuarioError extends UsuarioState {
  final String mensaje;

  const UsuarioError({required this.mensaje});

  @override
  List<Object?> get props => [mensaje];
}
