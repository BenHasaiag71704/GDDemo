import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/widgets/progress_bar.dart';
import 'package:my_project_trivia/widgets/question_card.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var questionList = Provider.of<Questions>(context).getTheList;
    int lenght = questionList.length;
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ProgressBar(),
              ),
              Text.rich(
                TextSpan(
                  text: "Question 1",
                  style: TextStyle(fontSize: 40),
                  children: [
                    TextSpan(
                      text: "/${lenght}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.5),
              SizedBox(height: 20),
              Expanded(
                child: QuestionCard(
                  question:
                      Provider.of<Questions>(context).getCurrentQuestion(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
