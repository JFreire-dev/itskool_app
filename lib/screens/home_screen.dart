import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cursos_screen.dart';
import './asignaturas_screen.dart';
import './evaluaciones_screen.dart';
import './perfil_screen.dart';
import '../cubits/usuario_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const CursosScreen(),
    const AsignaturasScreen(),
    const EvaluacionesScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final usuarioCubit = context.read<UsuarioCubit>();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UsuarioCubit, UsuarioState>(
          builder: (context, state) {
            if (state is UsuarioAutenticado) {
              return Text('Bienvenido, ${state.usuario.nombre}');
            }
            return const Text('Home');
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              usuarioCubit.cerrarSesion();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'Cursos'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Asignaturas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Evaluaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
