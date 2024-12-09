import 'package:flutter/material.dart';
import 'cursos_screen.dart';
import 'asignaturas_screen.dart';
import 'evaluaciones_screen.dart';
import 'perfil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CursosScreen(),
    const AsignaturasScreen(),
    const EvaluacionesScreen(),
    const PerfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar navigation
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            selectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.primary,
            ),
            unselectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.secondary,
            ),
            labelType: NavigationRailLabelType.none,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.class_),
                selectedIcon: Icon(Icons.class_),
                label: Text('Cursos'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book),
                selectedIcon: Icon(Icons.book),
                label: Text('Asignaturas'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment),
                selectedIcon: Icon(Icons.assignment),
                label: Text('Evaluaciones'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person),
                label: Text('Perfil'),
              ),
            ],
          ),
          // Main content
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
