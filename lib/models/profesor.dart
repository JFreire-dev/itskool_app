import 'usuario.dart';

class Profesor extends Usuario {
  final List<String> cursos;
  final String? cursoAdmin;
  final Map<String, List<String>> asignaturasPorCurso;

  Profesor({
    required super.id,
    required super.nombre,
    required super.email,
    this.cursoAdmin,
    this.cursos = const [],
    this.asignaturasPorCurso = const {},
  }) : super(tipoUsuario: 'Profesor');
}
