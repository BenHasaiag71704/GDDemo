import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/controllers/question_controller.dart';
import 'package:my_project_trivia/models/option.dart';
import 'package:my_project_trivia/models/samples.dart';
import 'package:my_project_trivia/screens/score/score_screen.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    bool didPress = false;
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () async {
                if (didPress == false) {
                  bool? isEnd = await _controller.checkAns(question, index);
                  // _controller.checkAns(question, index);
                  didPress = true;
                  if (isEnd == true) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ScoreScreen()));
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
