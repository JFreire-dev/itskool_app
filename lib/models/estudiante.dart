import 'usuario.dart';

class Estudiante extends Usuario {
  final String curso;

  Estudiante({
    required super.id,
    required super.nombre,
    required super.email,
    this.curso = '',
  }) : super(tipoUsuario: 'Estudiante');
}
