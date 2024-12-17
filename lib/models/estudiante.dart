// Archivo: /lib/models/estudiante.dart
import 'usuario.dart';

class Estudiante extends Usuario {
  final String matricula;
  final String curso;

  Estudiante({
    required super.id,
    required super.nombre,
    required super.email,
    required this.matricula,
    required this.curso,
  });
}
