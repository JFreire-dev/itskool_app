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

  /// Crear un nuevo curso y actualizar la información del profesor
  Future<void> crearCurso({
    required String idAdministrador,
    required String nombreCurso,
    required String colegio,
    String? paralelo,
  }) async {
    try {
      // Generar el nombre completo del curso
      final nombreCompletoCurso =
          '$nombreCurso - $colegio${paralelo != null ? " $paralelo" : ""}';

      // Generar un ID único para el curso
      final cursoId = _firestore.collection('cursos').doc().id;

      final nuevoCurso = Curso(
        id: cursoId,
        nombreCurso: nombreCompletoCurso,
        colegio: colegio,
        paralelo: paralelo,
        idAdministrador: idAdministrador,
        fechaCreacion: DateTime.now(),
      );

      // Crear el curso en la colección "cursos"
      await _firestore
          .collection('cursos')
          .doc(cursoId)
          .set(nuevoCurso.toMap());

      // Actualizar el documento del profesor
      final docRef = _firestore.collection('usuarios').doc(idAdministrador);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          throw Exception("El usuario no existe.");
        }

        // Obtener la lista de cursos actual
        final List<dynamic> cursosActuales = snapshot.data()?['cursos'] ?? [];

        // Actualizar cursoAdmin y añadir el nuevo curso a la lista
        transaction.update(docRef, {
          'cursoAdmin': nombreCompletoCurso,
          'cursos': [...cursosActuales, nombreCompletoCurso],
        });
      });

      print("Curso creado y datos del profesor actualizados correctamente.");
    } catch (e) {
      print("Error al crear curso: $e");
      throw Exception("Error al crear el curso: $e");
    }
  }

  /// Validar si un curso con el mismo nombre, colegio y paralelo ya existe
  Future<bool> existeCursoDuplicado({
    required String nombreCurso,
    required String colegio,
    String? paralelo,
  }) async {
    final querySnapshot = await _firestore
        .collection('cursos')
        .where('nombreCurso', isEqualTo: nombreCurso)
        .where('colegio', isEqualTo: colegio)
        .where('paralelo', isEqualTo: paralelo ?? '')
        .get();

    return querySnapshot
        .docs.isNotEmpty; // Devuelve true si ya existe un curso duplicado
  }

  /// Obtener los cursos asociados a un profesor
  Future<List<Map<String, dynamic>>> obtenerCursosProfesor(
      String idProfesor) async {
    try {
      final querySnapshot = await _firestore
          .collection('cursos')
          .where('idAdministrador',
              isEqualTo: idProfesor) // Filtra por id del administrador
          .get();

      // Mapear los resultados de la consulta
      final cursos = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'nombreCurso': doc.data()['nombreCurso'] ?? 'Sin nombre',
          'colegio': doc.data()['colegio'] ?? 'Sin colegio',
          'paralelo': doc.data()['paralelo'] ?? '',
        };
      }).toList();

      print("Cursos obtenidos correctamente: $cursos");
      return cursos;
    } catch (e) {
      print("Error al obtener cursos: $e");
      throw Exception("Error al obtener los cursos: $e");
    }
  }
}
