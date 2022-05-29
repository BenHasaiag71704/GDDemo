import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/providers/user.dart';
import 'package:my_project_trivia/providers/user_answers.dart';
import 'package:my_project_trivia/widgets/progress_bar.dart';
import 'package:my_project_trivia/widgets/question_card.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class Body extends StatefulWidget {
  Body({
    Key? key,
    @required this.totalQnNum,
  }) : super(key: key);
  int? totalQnNum;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var temp = Provider.of<Questions>(context).getQnNum;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 178, 255, 77),
              Color.fromARGB(255, 83, 233, 101),
              Color.fromARGB(255, 0, 186, 155),
            ],
          )),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ProgressBar(totalTime: widget.totalQnNum),
                ),
                Text.rich(
                  TextSpan(
                    text: "Question ${temp}",
                    style: TextStyle(fontSize: 40, color: Colors.black),
                    children: [
                      TextSpan(
                        text: "/${widget.totalQnNum}",
                        style: TextStyle(fontSize: 20, color: Colors.black),
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
          ),
        ),
      ],
    );
  }
}
