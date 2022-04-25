import 'package:flutter/material.dart';

enum Prefs {
  All,
  OnlyEnglish,
  OnlyHebrew,
  OnlyMath,
  MathAndHebrew,
  MatnAndEnglish,
  EnglishAndHebrew,
  None,
}

class GameScreen extends StatefulWidget {
  static const routeName = '/game_screen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static bool checkmath(Prefs temp) {
    if (temp == Prefs.All ||
        temp == Prefs.MathAndHebrew ||
        temp == Prefs.MatnAndEnglish ||
        temp == Prefs.OnlyMath) {
      return true;
    }
    return false;
  }

  static bool checkhebrew(Prefs temp) {
    if (temp == Prefs.All ||
        temp == Prefs.EnglishAndHebrew ||
        temp == Prefs.MathAndHebrew ||
        temp == Prefs.OnlyHebrew) {
      return true;
    }
    return false;
  }

  static bool checkenglish(Prefs temp) {
    if (temp == Prefs.All ||
        temp == Prefs.EnglishAndHebrew ||
        temp == Prefs.MatnAndEnglish ||
        temp == Prefs.OnlyEnglish) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final temp = ModalRoute.of(context)!.settings.arguments.toString();

    Prefs pre = Prefs.values.firstWhere(
        (keyword) => keyword.toString().toUpperCase() == temp.toUpperCase());

    bool wantMath;
    bool wantEnglish;
    bool wantHberew;

    wantMath = checkmath(pre);
    wantEnglish = checkenglish(pre);
    wantHberew = checkhebrew(pre);

    return Scaffold(
      appBar: AppBar(
        title: Text("welcome to the game"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "math-" +
                  wantMath.toString() +
                  "" +
                  "\n"
                      "english-" +
                  wantEnglish.toString() +
                  "\n" +
                  "" +
                  "hebrew-" +
                  wantHberew.toString(),
            )
          ],
        ),
      ),
    );
  }
}
