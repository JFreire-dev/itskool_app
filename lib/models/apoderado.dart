import 'usuario.dart';
import 'estudiante.dart';

class Apoderado extends Usuario {
  final List<Estudiante> pupilos;

  Apoderado({
    required super.id,
    required super.nombre,
    required super.email,
    this.pupilos = const [],
  }) : super(tipoUsuario: 'Apoderado');
}
