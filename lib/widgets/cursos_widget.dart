import 'package:flutter/material.dart';
import '../screens/curso_screen.dart';

class CursosWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cursos;
  final String? cursoAdmin;
  final String tipoUsuario;

  const CursosWidget({
    super.key,
    required this.cursos,
    required this.cursoAdmin,
    required this.tipoUsuario,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Margen lateral
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mis cursos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildExplicacionRoles(), // Explicación de roles
          const SizedBox(height: 10),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2), // Colegio
              1: FlexColumnWidth(2), // Curso
              2: FlexColumnWidth(1), // Paralelo
              3: FlexColumnWidth(1), // Rol
            },
            border: TableBorder.all(color: Colors.grey[300]!),
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Colors.grey),
                children: [
                  Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Colegio'))),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0), child: Text('Curso'))),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Paralelo'))),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0), child: Text('Rol'))),
                ],
              ),
              // Filas dinámicas
              ...cursos.map((curso) {
                final esAdmin =
                    cursoAdmin == curso['id']; // Determina si es administrador
                return TableRow(
                  children: [
                    Center(child: Text(curso['colegio'])),
                    Center(
                      child: InkWell(
                        onTap: () {
                          // Navegar a la pantalla del curso
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CursoScreen(
                                cursoId: curso['id'],
                                nombreCurso: curso['nombreCurso'],
                                colegio: curso['colegio'],
                                paralelo: curso['paralelo'],
                                esAdministrador: esAdmin,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          curso['nombreCurso'],
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Center(child: Text(curso['paralelo'] ?? '')),
                    Center(
                      child: esAdmin
                          ? const Icon(Icons.star, color: Colors.amber)
                          : _getIconForRole(tipoUsuario),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  /// Widget de la explicación de roles
  Widget _buildExplicacionRoles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRolExplicacion(Icons.star, 'Profesor Jefe', Colors.amber),
        _buildRolExplicacion(Icons.school, 'Profesor', Colors.green),
        _buildRolExplicacion(Icons.menu_book, 'Estudiante', Colors.purple),
        _buildRolExplicacion(Icons.family_restroom, 'Apoderado', Colors.orange),
      ],
    );
  }

  /// Constructor individual para cada rol
  Widget _buildRolExplicacion(IconData icon, String texto, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 5),
        Text(
          texto,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// Determinar el ícono según el tipo de usuario
  Icon _getIconForRole(String tipoUsuario) {
    switch (tipoUsuario) {
      case 'Profesor':
        return const Icon(Icons.school, color: Colors.green);
      case 'Estudiante':
        return const Icon(Icons.menu_book, color: Colors.purple);
      case 'Apoderado':
        return const Icon(Icons.family_restroom, color: Colors.orange);
      default:
        return const Icon(Icons.person, color: Colors.grey);
    }
  }
}
