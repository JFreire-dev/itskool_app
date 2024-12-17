import 'package:flutter/material.dart';
import '../widgets/user_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String?
      _tipoUsuario; // Variable para almacenar el tipo de usuario seleccionado
  final List<String> _tiposUsuarios = ['Profesor', 'Estudiante', 'Apoderado'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Registro de Usuario'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Dropdown para seleccionar el tipo de usuario
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tipo de Usuario',
              ),
              items: _tiposUsuarios.map((tipo) {
                return DropdownMenuItem(
                  value: tipo,
                  child: Text(tipo),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _tipoUsuario = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),

          // Botón para avanzar al formulario
          ElevatedButton(
            onPressed: () {
              if (_tipoUsuario != null) {
                // Navegar a la pantalla de formulario con el tipo de usuario seleccionado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserFormScreen(tipoUsuario: _tipoUsuario!),
                  ),
                );
              } else {
                // Mostrar un error si no se selecciona el tipo de usuario
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor selecciona un tipo de usuario'),
                  ),
                );
              }
            },
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}

// Pantalla que mostrará el formulario de registro según el tipo de usuario
class UserFormScreen extends StatelessWidget {
  final String tipoUsuario;

  const UserFormScreen({Key? key, required this.tipoUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrando $tipoUsuario'),
      ),
      // Aquí se pasa el tipo de usuario al widget del formulario
      body: UserFormWidget(tipoUsuario: tipoUsuario),
    );
  }
}
