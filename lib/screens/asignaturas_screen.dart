import 'package:flutter/material.dart';

class AsignaturasScreen extends StatelessWidget {
  const AsignaturasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignaturas'),
      ),
      body: const Center(
        child: Text('Esta es la pantalla de asignaturas'),
      ),
    );
  }
}
