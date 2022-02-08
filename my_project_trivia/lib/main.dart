import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/user.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AppUser(),
        )
      ],
      child: FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'Psyco-trivia',
            theme: ThemeData(
              colorScheme: const ColorScheme(
                primary: Colors.white,
                onPrimary: Colors.black,
                primaryVariant: Colors.black26,
                background: Colors.white,
                onBackground: Colors.white,
                secondary: Colors.black26,
                onSecondary: Colors.white,
                secondaryVariant: Colors.teal,
                error: Colors.orange,
                onError: Colors.orange,
                surface: Colors.black26,
                onSurface: Colors.white,
                brightness: Brightness.dark,
              ),
            ),
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return HomeScreen();
                  }
                  return AuthScreen();
                }),
          );
        },
      ),
    );
  }
}
