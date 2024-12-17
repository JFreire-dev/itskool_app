import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/curso.dart';

class FirebaseCursoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Validar si el profesor ya es administrador de un curso en el mismo colegio
  Future<bool> existeCursoEnColegio({
    required String idAdministrador,
    required String colegio,
  }) async {
    final querySnapshot = await _firestore
        .collection('cursos')
        .where('idAdministrador', isEqualTo: idAdministrador)
        .where('colegio', isEqualTo: colegio)
        .get();

    return querySnapshot.docs.isNotEmpty; // Devuelve true si ya existe un curso
  }

  /// Crear un nuevo curso
  Future<void> crearCurso({
    required String idAdministrador,
    required String nombreCurso,
    required String colegio,
    String? paralelo,
  }) async {
    final cursoId = _firestore.collection('cursos').doc().id; // Genera ID único
    final nuevoCurso = Curso(
      id: cursoId,
      nombreCurso: nombreCurso,
      colegio: colegio,
      paralelo: paralelo,
      idAdministrador: idAdministrador,
      fechaCreacion: DateTime.now(),
    );

    await _firestore.collection('cursos').doc(cursoId).set(nuevoCurso.toMap());
  }
}
