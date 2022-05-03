import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/controllers/question_controller.dart';
import 'package:my_project_trivia/providers/user.dart';
import 'package:provider/provider.dart';
import '/models/body.dart';

// import 'package:websafe_svg/websafe_svg.dart';

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
    QuestionController _controller = Get.put(QuestionController());
    final temp = ModalRoute.of(context)!.settings.arguments.toString();
    var userDataCollect = Provider.of<AppUser>(context);

    Prefs pre = Prefs.values.firstWhere(
        (keyword) => keyword.toString().toUpperCase() == temp.toUpperCase());

    bool wantMath;
    bool wantEnglish;
    bool wantHberew;

    wantMath = checkmath(pre);
    wantEnglish = checkenglish(pre);
    wantHberew = checkhebrew(pre);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [],
      ),
      body: Body(),
    );
  }
}

// body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(
//               "math-" +
//                   wantMath.toString() +
//                   "" +
//                   "\n"
//                       "english-" +
//                   wantEnglish.toString() +
//                   "\n" +
//                   "" +
//                   "hebrew-" +
//                   wantHberew.toString(),
//             )
//           ],
//         ),
//       ),
