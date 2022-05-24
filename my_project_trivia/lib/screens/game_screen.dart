import 'package:flutter/material.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:my_project_trivia/providers/user.dart';
import 'package:my_project_trivia/providers/user_answers.dart';
import 'package:provider/provider.dart';
import '../widgets/body.dart';

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
    final end = ModalRoute.of(context)!.settings.arguments.toString();
    var userDataCollect = Provider.of<AppUser>(context);
    // Prefs pre = Prefs.values.firstWhere(
    //     (keyword) => keyword.toString().toUpperCase() == temp.toUpperCase());
    int end2 = int.parse(end);
    bool wantMath;
    bool wantEnglish;
    bool wantHberew;

    // wantMath = checkmath(pre);
    // wantEnglish = checkenglish(pre);
    // wantHberew = checkhebrew(pre);
    // int lng = Provider.of<Questions>(context).getTheList.length;

    // int anslng = Provider.of<UserAnswers>(context)
    //     .getSingleUserQnAnswerd(Provider.of<AppUser>(context).uid);

    // int end = lng - anslng;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [],
      ),
      body: Body(totalQnNum: end2),
    );
  }
}
