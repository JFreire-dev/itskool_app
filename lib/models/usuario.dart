class Usuario {
  final String id;
  final String nombre;
  final String email;
  final String tipoUsuario;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.tipoUsuario,
  });

  @override
  String toString() => '$tipoUsuario: $nombre ($email)';
}
