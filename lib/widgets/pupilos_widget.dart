// Archivo: /lib/widgets/pupilos_widget.dart
import 'package:flutter/material.dart';
import '../models/estudiante.dart';

class PupilosWidget extends StatelessWidget {
  final List<Estudiante> pupilos;

  const PupilosWidget({
    super.key,
    required this.pupilos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pupilos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        for (var pupilo in pupilos)
          ListTile(
            title: Text(pupilo.nombre),
            subtitle: Text('Curso: ${pupilo.curso}'),
            leading: const Icon(Icons.person),
          ),
      ],
    );
  }
}
