import 'package:flutter/material.dart';
import '../firebase/firebase_auth_service.dart';

class UserFormWidget extends StatefulWidget {
  final String tipoUsuario;

  const UserFormWidget({Key? key, required this.tipoUsuario}) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoPaternoController =
      TextEditingController();
  final TextEditingController _apellidoMaternoController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  // Función para registrar el usuario
  void _register() async {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _errorMessage = "Las contraseñas no coinciden";
        });
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        // Combina nombres y apellidos
        String nombreCompleto =
            "${_nombreController.text} ${_apellidoPaternoController.text} ${_apellidoMaternoController.text}";

        await FirebaseAuthService().registrarUsuario(
          email: _emailController.text,
          password: _passwordController.text,
          nombre: nombreCompleto,
          tipoUsuario: widget.tipoUsuario,
        );

        // Navegar a la pantalla de éxito
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/success',
              arguments: _nombreController.text);
        }
      } catch (e) {
        setState(() {
          _errorMessage = "Error al registrar: $e";
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombres'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obligatorio' : null,
            ),
            TextFormField(
              controller: _apellidoPaternoController,
              decoration: const InputDecoration(labelText: 'Apellido Paterno'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obligatorio' : null,
            ),
            TextFormField(
              controller: _apellidoMaternoController,
              decoration: const InputDecoration(labelText: 'Apellido Materno'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obligatorio' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || !value.contains('@')
                  ? 'Correo inválido'
                  : null,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'La contraseña es obligatoria'
                  : null,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration:
                  const InputDecoration(labelText: 'Confirmar contraseña'),
              obscureText: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Confirme la contraseña'
                  : null,
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
