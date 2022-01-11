import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project_trivia/screens/auth_screen.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, appSnapshot) {
        return MaterialApp(
          title: 'Psyco-trivia',
          theme: ThemeData(
            colorScheme: const ColorScheme(
              primary: Colors.purple,
              onPrimary: Colors.white,
              primaryVariant: Colors.orange,
              background: Colors.white,
              onBackground: Colors.black,
              secondary: Colors.teal,
              onSecondary: Colors.blue,
              secondaryVariant: Colors.deepOrange,
              error: Colors.red,
              onError: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
              brightness: Brightness.light,
            ),
          ),
          home: AuthScreen(),
        );
      },
    );
  }
}
