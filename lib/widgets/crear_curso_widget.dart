import 'package:flutter/material.dart';
import '../firebase/firebase_curso_service.dart';
import '../firebase/firebase_auth_service.dart';

class CrearCursoWidget extends StatefulWidget {
  final VoidCallback onCursoCreado; // Callback para notificar al padre

  const CrearCursoWidget({super.key, required this.onCursoCreado});

  @override
  State<CrearCursoWidget> createState() => _CrearCursoModalState();
}

class _CrearCursoModalState extends State<CrearCursoWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _colegioController = TextEditingController();
  final TextEditingController _paraleloController = TextEditingController();
  String? _cursoSeleccionado;

  final List<String> _cursosDisponibles = [
    '1ro Básico',
    '2do Básico',
    '3ro Básico',
    '4to Básico',
    '5to Básico',
    '6to Básico',
    '7mo Básico',
    '8vo Básico',
    '1ro Medio',
    '2do Medio',
    '3ro Medio',
    '4to Medio',
  ];

  bool _isLoading = false;

  /// Función para crear el curso
  void _crearCurso() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final firebaseService = FirebaseCursoService();
    final profesorId = FirebaseAuthService().usuarioActual?.uid;

    if (profesorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Usuario no autenticado')),
      );
      setState(() => _isLoading = false);
      return;
    }

    final colegio = _colegioController.text;
    final paralelo = _paraleloController.text;

    // Validar si ya existe un curso duplicado
    final cursoDuplicado = await firebaseService.existeCursoDuplicado(
      nombreCurso: _cursoSeleccionado!,
      colegio: colegio,
      paralelo: paralelo.isNotEmpty ? paralelo : null,
    );

    if (cursoDuplicado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ya existe un curso con estos datos'),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    // Validar si ya es administrador de un curso en este colegio
    final existe = await firebaseService.existeCursoEnColegio(
      idAdministrador: profesorId,
      colegio: colegio,
    );

    if (existe) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ya eres administrador de un curso en este colegio'),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    // Crear el curso
    await firebaseService.crearCurso(
      idAdministrador: profesorId,
      nombreCurso: _cursoSeleccionado!,
      colegio: colegio,
      paralelo: paralelo.isNotEmpty ? paralelo : null,
    );

    // Notificar al padre que el curso fue creado
    widget.onCursoCreado();

    Navigator.of(context).pop(); // Cerrar modal
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Curso creado exitosamente')),
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Crear Curso',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Curso'),
                items: _cursosDisponibles.map((curso) {
                  return DropdownMenuItem(value: curso, child: Text(curso));
                }).toList(),
                onChanged: (value) =>
                    setState(() => _cursoSeleccionado = value),
                validator: (value) =>
                    value == null ? 'Selecciona un curso' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _colegioController,
                decoration: const InputDecoration(labelText: 'Colegio'),
                validator: (value) => value == null || value.isEmpty
                    ? 'El nombre del colegio es obligatorio'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _paraleloController,
                decoration:
                    const InputDecoration(labelText: 'Paralelo (opcional)'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _crearCurso,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Crear Curso'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
