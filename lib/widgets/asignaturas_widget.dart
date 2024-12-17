// Archivo: /lib/widgets/asignaturas_widget.dart
import 'package:flutter/material.dart';

class AsignaturasWidget extends StatelessWidget {
  final String curso;
  final List<String> asignaturas;

  const AsignaturasWidget({
    super.key,
    required this.curso,
    required this.asignaturas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Curso: $curso',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Asignaturas:', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        for (var asignatura in asignaturas)
          ListTile(
            title: Text(asignatura),
            leading: const Icon(Icons.book),
          ),
      ],
    );
  }
}
