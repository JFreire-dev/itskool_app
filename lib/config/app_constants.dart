// Archivo: /lib/config/app_constants.dart

/// Clase que contiene constantes globales utilizadas en la aplicación.
/// Estas constantes son útiles para evitar duplicación de valores
/// y facilitar su actualización.
class AppConstants {
  /// Nombre de la aplicación.
  static const String appName = 'Itskool';

  /// URL base de la API con la que interactúa la aplicación.
  /// Cambia `example.com` por la dirección de tu servidor backend.
  /// - Ejemplo local: 'http://localhost:3000/api'
  /// - Ejemplo en producción: 'https://mi-backend.com/api'
  static const String apiBaseUrl =
      'https://example.com/api'; // Cambiar según sea necesario.
}
