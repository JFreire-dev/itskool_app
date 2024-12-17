// Archivo: /lib/models/apoderado.dart
import 'usuario.dart';
import 'estudiante.dart';

class Apoderado extends Usuario {
  final List<Estudiante>
      pupilos; // Lista de estudiantes bajo la tutela del apoderado

  Apoderado({
    required super.id,
    required super.nombre,
    required super.email,
    required this.pupilos,
  });
}
