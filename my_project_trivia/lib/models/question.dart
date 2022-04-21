import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Question {
  final String qid;
  final String Classification;
  final String type;
  final String thetext;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final int correctanswer;

  const Question(
    @required this.qid,
    @required this.Classification,
    @required this.type,
    @required this.thetext,
    @required this.answer1,
    @required this.answer2,
    @required this.answer3,
    @required this.answer4,
    @required this.correctanswer,
  );

  String get getQuestionId {
    return qid;
  }
}
