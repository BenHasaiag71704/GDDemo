import 'package:flutter/foundation.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:my_project_trivia/models/user_question_answer.dart';

class UserAnswers extends ChangeNotifier {
  late List<UserQuestionAnswer> userAnswerList = [];

  List<UserQuestionAnswer> getAnswers() => this.userAnswerList;
}
