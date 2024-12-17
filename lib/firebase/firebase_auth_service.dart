import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Método para registrar un nuevo usuario
  Future<void> registrarUsuario({
    required String email,
    required String password,
    required String nombre,
    required String tipoUsuario,
  }) async {
    try {
      // Crear el usuario en Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User UID: ${userCredential.user?.uid}");

      // Guardar datos adicionales del usuario en Firestore
      await _firestore
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({
        'nombre': nombre,
        'email': email,
        'tipoUsuario': tipoUsuario,
        'uid': userCredential.user!.uid,
      });
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuth Error: ${e.message}");
      throw Exception(e.message ?? "Error desconocido");
    }
  }

  /// Método para iniciar sesión
  /// Método para iniciar sesión
  Future<String?> iniciarSesion({
    required String email,
    required String password,
  }) async {
    try {
      // Intentar iniciar sesión
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verificar si se obtuvo el usuario correctamente
      final user = userCredential.user;
      if (user != null) {
        print("Usuario autenticado exitosamente:");
        print("UID: ${user.uid}");
        print("Email: ${user.email}");
        return null; // Login exitoso
      } else {
        print("Error: No se pudo obtener el usuario.");
        return "Error: No se pudo obtener el usuario.";
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuth Error: ${e.message}");
      return e.message; // Retornar el mensaje de error
    } catch (e) {
      print("Error desconocido al iniciar sesión: $e");
      return "Error desconocido: $e";
    }
  }

  Future<Map<String, dynamic>?> obtenerDatosUsuario(String uid) async {
    try {
      final doc = await _firestore.collection('usuarios').doc(uid).get();
      if (doc.exists) {
        return doc.data();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error al obtener los datos del usuario: $e");
    }
  }

  /// Método para cerrar sesión
  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  /// Obtener el usuario actual autenticado
  User? get usuarioActual => _auth.currentUser;
}
