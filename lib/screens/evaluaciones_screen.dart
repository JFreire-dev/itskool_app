import 'package:flutter/material.dart';

class EvaluacionesScreen extends StatelessWidget {
  const EvaluacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluaciones'),
      ),
      body: const Center(
        child: Text('Esta es la pantalla de evaluaciones'),
      ),
    );
  }
}
