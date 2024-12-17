import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/register_screen.dart';
import '../models/usuario.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        final usuario = settings.arguments as Usuario;
        return MaterialPageRoute(builder: (_) => HomeScreen(usuario: usuario));
      case '/register': // Nueva ruta para RegisterScreen
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
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
