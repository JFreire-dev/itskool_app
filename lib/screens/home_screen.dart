import 'package:flutter/material.dart';
import '../firebase/firebase_curso_service.dart';
import '../models/usuario.dart';
import '../models/profesor.dart';
import '../widgets/cursos_widget.dart';
import '../widgets/crear_curso_widget.dart';

class HomeScreen extends StatefulWidget {
  final Usuario usuario;

  const HomeScreen({super.key, required this.usuario});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _cursos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cargarCursos();
  }

  Future<void> _cargarCursos() async {
    if (widget.usuario is Profesor) {
      final profesor = widget.usuario as Profesor;
      setState(() => _isLoading = true);
      final cursos =
          await FirebaseCursoService().obtenerCursosProfesor(profesor.id);
      setState(() {
        _cursos = cursos;
        _isLoading = false;
      });
    }
  }

  // Callback después de crear un curso
  void _onCursoCreado() {
    _cargarCursos(); // Refresca los cursos desde Firebase
  }

  @override
  Widget build(BuildContext context) {
    final usuario = widget.usuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout, color: Colors.black),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (usuario is Profesor) ...[
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CrearCursoWidget(
                            onCursoCreado: _onCursoCreado,
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Crear Curso'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey[300]),
                  CursosWidget(
                    cursos: _cursos,
                    cursoAdmin: usuario.cursoAdmin,
                    tipoUsuario: usuario.tipoUsuario, // Añadir tipoUsuario aquí
                  ),
                ],
              ],
            ),
    );
  }
}
