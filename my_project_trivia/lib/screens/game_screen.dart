import 'package:flutter/material.dart';

enum Prefs {
  All,
  OnlyEnglish,
  OnlyHebrew,
  OnlyMath,
  MathAndHebrew,
  MatnAndEnglish,
  EnglishAndHebrew,
}

class GameScreen extends StatefulWidget {
  static const routeName = '/game_screen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final temp = ModalRoute.of(context)!.settings.arguments.toString();

    Prefs pre = Prefs.values.firstWhere(
        (keyword) => keyword.toString().toUpperCase() == temp.toUpperCase());

    bool wantMath;
    bool wantEnglish;
    bool wantHberew;

    if (pre == Prefs.All) {
      wantMath = true;
      wantEnglish = true;
      wantHberew = true;
    } else {
      wantMath = false;
      wantEnglish = false;
      wantHberew = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("welcome to the game"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Text(wantHberew.toString())],
        ),
      ),
    );
  }
}
