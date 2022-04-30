import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/controllers/question_controller.dart';

class ScoreScreen extends StatefulWidget {
  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    int _temp = _qnController.numOfCorrectAns;
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
                "${_temp}/${_qnController.questions.length}",
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
