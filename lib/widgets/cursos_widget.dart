// Archivo: /lib/widgets/cursos_widget.dart
import 'package:flutter/material.dart';

class CursosWidget extends StatelessWidget {
  final List<String> cursos;
  final String? cursoAdmin;

  const CursosWidget({
    super.key,
    required this.cursos,
    this.cursoAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cursos Asignados',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        for (var curso in cursos)
          ListTile(
            title: Text(curso),
            subtitle: cursoAdmin == curso
                ? const Text('Administrador del curso',
                    style: TextStyle(color: Colors.blue))
                : null,
            leading: const Icon(Icons.school),
          ),
      ],
    );
  }
}
