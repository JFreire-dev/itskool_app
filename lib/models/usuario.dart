// Archivo: /lib/models/usuario.dart

class Usuario {
  final String id;
  final String nombre;
  final String email;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
  });

  @override
  String toString() => 'Usuario: $nombre ($email)';
}
