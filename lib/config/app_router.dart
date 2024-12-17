import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/register_screen.dart';
import '../screens/registro_success_screen.dart'; // Importa la nueva pantalla de éxito
import '../models/usuario.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        final usuario = settings.arguments as Usuario;
        return MaterialPageRoute(builder: (_) => HomeScreen(usuario: usuario));
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/success':
        final nombre = settings.arguments as String? ??
            ''; // Obtén el nombre del argumento
        return MaterialPageRoute(
          builder: (_) => SuccessScreen(nombre: nombre),
        );
      default:
        return _errorRoute('Página no encontrada: ${settings.name}');
    }
  }

  static MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text(message)),
      ),
    );
  }
}
