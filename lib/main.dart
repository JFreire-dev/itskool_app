import 'package:flutter/material.dart';
import 'config/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Itskool App',
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
