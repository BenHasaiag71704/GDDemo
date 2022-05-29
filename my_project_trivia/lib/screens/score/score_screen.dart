import 'package:flutter/material.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:provider/provider.dart';
//import 'package:my_project_trivia/providers/user.dart';
//import 'package:provider/provider.dart';

class ScoreScreen extends StatefulWidget {
  static const routeName = '/score_screen';
  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    int temp = Provider.of<Questions>(context).getTotalScore;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 178, 255, 77),
              Color.fromARGB(255, 83, 233, 101),
              Color.fromARGB(255, 0, 186, 155),
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Spacer(flex: 3),
                Text(
                  "!כל הכבוד",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                Spacer(),
                Text(
                  "!ענית על כל השאלות במאגר",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                Spacer(flex: 3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
