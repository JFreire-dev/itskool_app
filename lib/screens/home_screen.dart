// Archivo: /lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../models/profesor.dart';
import '../models/estudiante.dart';
import '../models/apoderado.dart';
import '../widgets/cursos_widget.dart';
import '../widgets/asignaturas_widget.dart';
import '../widgets/alumnos_widget.dart';

class HomeScreen extends StatelessWidget {
  final Usuario usuario;

  const HomeScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    Widget contenidoDinamico;

    // Determinamos el contenido dinámico según el tipo de usuario
    if (usuario is Profesor) {
      final profesor = usuario as Profesor;
      contenidoDinamico = CursosWidget(
        cursos: profesor.cursos,
        cursoAdmin: profesor.cursoAdmin,
      );
    } else if (usuario is Estudiante) {
      final estudiante = usuario as Estudiante;
      contenidoDinamico = AsignaturasWidget(
        curso: estudiante.curso,
        asignaturas: const ['Matemáticas', 'Lenguaje', 'Historia'], // Ejemplo
      );
    } else if (usuario is Apoderado) {
      final apoderado = usuario as Apoderado;
      contenidoDinamico = PupilosWidget(
        pupilos: apoderado.pupilos,
      );
    } else {
      contenidoDinamico = const Center(
        child: Text('Tipo de usuario no identificado'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Fondo blanco
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black), // Título en negro
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/'); // Cerrar sesión
            },
            icon: const Icon(
              Icons.logout, // Ícono de cerrar sesión (flecha con puerta)
              size: 28, // Ajusta el tamaño del ícono si lo necesitas
              color: Colors.black, // Ícono en color negro
            ),
            tooltip: 'Cerrar sesión', // Muestra el tooltip al pasar el mouse
          ),
        ],
        iconTheme:
            const IconThemeData(color: Colors.black), // Otros íconos en negro
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: contenidoDinamico,
      ),
    );
  }
}
