import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para Clipboard

class CursoScreen extends StatefulWidget {
  final String cursoId;
  final String nombreCurso;
  final String colegio;
  final String? paralelo;
  final bool esAdministrador;

  const CursoScreen({
    super.key,
    required this.cursoId,
    required this.nombreCurso,
    required this.colegio,
    this.paralelo,
    this.esAdministrador = false,
  });

  @override
  State<CursoScreen> createState() => _CursoScreenState();
}

class _CursoScreenState extends State<CursoScreen> {
  String? _codigoInvitacion;
  DateTime? _codigoExpiracion;
  bool _loading = false;

  void _generarCodigoInvitacion() {
    setState(() {
      _loading = true;
    });

    // Generar código aleatorio
    final codigo = _generarCodigoAleatorio();
    _codigoExpiracion = DateTime.now().add(const Duration(minutes: 5));

    // Simula la generación de código (en Firebase podríamos almacenarlo)
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _codigoInvitacion = codigo;
        _loading = false;
      });
    });
  }

  String _generarCodigoAleatorio() {
    const caracteres =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(6, (index) {
      return caracteres[DateTime.now().microsecond % caracteres.length];
    }).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombreCurso),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Colegio: ${widget.colegio}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (widget.paralelo != null)
              Text(
                'Paralelo: ${widget.paralelo}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 20),

            // Mostrar botón solo si es administrador
            if (widget.esAdministrador)
              ElevatedButton.icon(
                onPressed: _generarCodigoInvitacion,
                icon: const Icon(Icons.person_add),
                label: const Text('Generar invitación'),
              ),

            // Mostrar código de invitación si existe
            if (_codigoInvitacion != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Código de invitación: $_codigoInvitacion',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Válido hasta: ${_codigoExpiracion!.toLocal()}',
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: _codigoInvitacion!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Código copiado al portapapeles')),
                        );
                      },
                      child: const Text('Copiar código'),
                    ),
                  ],
                ),
              ),
            if (_loading) const Center(child: CircularProgressIndicator()),

            const SizedBox(height: 30),
            const Divider(),
            const Text(
              'Lista de Alumnos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Aquí se listarán los alumnos más adelante
            const Center(child: Text('No hay alumnos registrados aún.')),
          ],
        ),
      ),
    );
  }
}
