class Curso {
  final String id; // ID único del curso (Firestore)
  final String nombreCurso; // Ejemplo: '4to Medio'
  final String colegio; // Colegio al que pertenece
  final String? paralelo; // Opcional, Ejemplo: 'A', 'B', etc.
  final String idAdministrador; // UID del Profesor Administrador
  final DateTime fechaCreacion; // Fecha en que se creó el curso

  Curso({
    required this.id,
    required this.nombreCurso,
    required this.colegio,
    this.paralelo,
    required this.idAdministrador,
    required this.fechaCreacion,
  });

  /// Convertir a Map para Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombreCurso': nombreCurso,
      'colegio': colegio,
      'paralelo': paralelo,
      'idAdministrador': idAdministrador,
      'fechaCreacion': fechaCreacion.toIso8601String(),
    };
  }

  /// Crear un Curso desde Firestore
  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      id: map['id'],
      nombreCurso: map['nombreCurso'],
      colegio: map['colegio'],
      paralelo: map['paralelo'],
      idAdministrador: map['idAdministrador'],
      fechaCreacion: DateTime.parse(map['fechaCreacion']),
    );
  }
}
