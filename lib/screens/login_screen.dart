import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/usuario_cubit.dart';
import '../cubits/usuario_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: BlocListener<UsuarioCubit, UsuarioState>(
        listener: (context, state) {
          if (state is UsuarioAutenticado) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Bienvenido, ${state.usuario.nombre}')),
            );
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is UsuarioError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.mensaje)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              BlocBuilder<UsuarioCubit, UsuarioState>(
                builder: (context, state) {
                  if (state is UsuarioCargando) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      context
                          .read<UsuarioCubit>()
                          .iniciarSesion(email, password);
                    },
                    child: const Text('Iniciar Sesión'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
