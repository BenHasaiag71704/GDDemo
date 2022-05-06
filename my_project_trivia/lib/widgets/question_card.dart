import 'package:flutter/material.dart';
import 'package:my_project_trivia/widgets/option.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:my_project_trivia/screens/score/score_screen.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    bool didPress = false;
    var questionList = Provider.of<Questions>(context).getTheList;
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
            widget.question.question,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ...List.generate(
            widget.question.options.length,
            (index) => Option(
              optionNum: index,
              //text: question.options[index],
              // press: () async {
              //   if (didPress == false) {
              //     didPress = true;
              //     bool? isEnd = true;
              //     // if (isEnd == true) {
              //     //   Navigator.pushReplacement(context,
              //     //       MaterialPageRoute(builder: (context) => ScoreScreen()));
              //     // }
              //   }
              // },
            ),
          ),
        ],
      ),
    );
  }
}
