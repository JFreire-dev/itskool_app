import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/app_router.dart';
import 'cubits/usuario_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAiAXAkXkqudLNHiQO6ySzQmv8y_Mb6cwQ",
      authDomain: "itskool-526ed.firebaseapp.com",
      projectId: "itskool-526ed",
      storageBucket: "itskool-526ed.appspot.com",
      messagingSenderId: "765424169022",
      appId: "1:765424169022:web:8fc8c15a58d3c373b4216f",
      measurementId: "G-T4WEGSCW6T",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsuarioCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Itskool',
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
