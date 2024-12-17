import 'package:flutter/material.dart';

class CursosScreen extends StatelessWidget {
  const CursosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
      body: const Center(
        child: Text('Esta es la pantalla de cursos'),
      ),
    );
  }
}
