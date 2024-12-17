// Archivo: /lib/models/docente.dart
import 'usuario.dart';

class Docente extends Usuario {
  final List<String> cursos; // Lista de cursos asignados al docente
  final String? cursoAdmin; // Curso en el que es administrador (si existe)
  final Map<String, List<String>>
      asignaturasPorCurso; // Ej: { '7mo Básico': ['Física', 'Matemáticas'] }

  Docente({
    required super.id,
    required super.nombre,
    required super.email,
    this.cursoAdmin,
    required this.cursos,
    required this.asignaturasPorCurso,
  });
}
