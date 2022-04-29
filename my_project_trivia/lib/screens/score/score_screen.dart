import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/controllers/question_controller.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
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
                "${_qnController.correctAns}/${_qnController.questions.length}",
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
