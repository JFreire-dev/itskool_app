import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../models/profesor.dart';
import '../models/estudiante.dart';
import '../models/apoderado.dart';
import '../widgets/cursos_widget.dart';
import '../widgets/asignaturas_widget.dart';
import '../widgets/alumnos_widget.dart';
import '../widgets/crear_curso_widget.dart';

class HomeScreen extends StatelessWidget {
  final Usuario usuario;

  const HomeScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    Widget contenidoDinamico;

    // Determinamos el contenido dinámico según el tipo de usuario
    if (usuario is Profesor) {
      final profesor = usuario as Profesor;
      contenidoDinamico = Column(
        children: [
          // Widget para mostrar cursos del profesor
          CursosWidget(
            cursos: profesor.cursos,
            cursoAdmin: profesor.cursoAdmin,
          ),
          const SizedBox(height: 16),
          // Botón para "Crear Curso" (visible sólo si no tiene cursoAdmin)
          if (profesor.cursoAdmin == null)
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const CrearCursoWidget(),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Crear Curso'),
            ),
        ],
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
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            color: Colors.black, // Botón negro
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: contenidoDinamico,
      ),
    );
  }
}
