import 'package:flutter/material.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:provider/provider.dart';
//import 'package:my_project_trivia/providers/user.dart';
//import 'package:provider/provider.dart';

class ScoreScreen extends StatefulWidget {
  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    int temp = Provider.of<Questions>(context).getTotalScore;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: TextStyle(fontSize: 30),
              ),
              Spacer(),
              Text(
                "${temp}",
                style: TextStyle(fontSize: 30),
              ),
              Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }
}
