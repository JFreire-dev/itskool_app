import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/app_router.dart';
import 'cubits/usuario_cubit.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsuarioCubit>(
          create: (context) => UsuarioCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Itskool App',
        theme: ThemeData.light(),
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
        home: const LoginScreen(),
      ),
    );
  }
}
