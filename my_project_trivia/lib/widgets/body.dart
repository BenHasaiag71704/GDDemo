import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/widgets/progress_bar.dart';
import 'package:my_project_trivia/widgets/question_card.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:provider/provider.dart';
import 'dart:io';

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
    var temp = Provider.of<Questions>(context).getQnNum;
    var lng = Provider.of<Questions>(context).getTheList.length;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue.shade400, Colors.green.shade200],
          )),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ProgressBar(),
                ),
                Text.rich(
                  TextSpan(
                    text: "Question ${temp}",
                    style: TextStyle(fontSize: 40, color: Colors.black),
                    children: [
                      TextSpan(
                        text: "/${lng}",
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
        )
      ],
    );
  }
}