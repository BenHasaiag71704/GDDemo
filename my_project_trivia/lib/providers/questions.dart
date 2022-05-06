import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:my_project_trivia/models/user_question_answer.dart';
import 'package:my_project_trivia/providers/user_answers.dart';

import 'package:my_project_trivia/models/user_question_answer.dart';

//import 'package:my_project_trivia/models/question.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Questions with ChangeNotifier {
  late List<Question> _questionList = [];
  // bool _isAnswered = false;
  // late int _correctAns;
  // late int _selectedAns;
  // int _numOfCorrectAns = 0;
  // int _questionNumber = 0;

  Questions() {}

  String? _currentQuestionId = "A8PSDd397UwSAw7AHAxd";

  Future<void> fetchQuestions() async {
    try {
      FirebaseFirestore.instance.collection('questions').get().then(
        (snapshot) {
          snapshot.docs.forEach((document) {
            _questionList.add(Question(
              id: document.id,
              answer: document['answer'],
              options: document['options'],
              question: document['question'],
              type: document['type'],
            ));
          });
        },
      );
    } catch (e) {
      print(e);
    }
    //notifyListeners();
  }

  // bool get isAnswered => this._isAnswered;

  // int get correctAns => this._correctAns;

  // int get selectedAns => this._selectedAns;

  // int get questionNumber => this._questionNumber;

  // int get numOfCorrectAns => this._numOfCorrectAns;

  // Question? getItem(int position) {
  //   if (position > _questionList.length)
  //     return null;
  //   else
  //     return _questionList[position];
  // }

  List<Question> get getTheList {
    return [..._questionList];
  }

  Question getCurrentQuestion() {
    Question q =
        _questionList.firstWhere((element) => element.id == _currentQuestionId);
    return q;
  }

  // void endGame() {
  //   _questionNumber = 1;
  //   _selectedAns = 0;
  //   _isAnswered = false;
  //   _numOfCorrectAns = 0;
  // }

  void getNextQuestion(BuildContext ctx) {
    // List<UserQuestionAnswer> temp =  Provider.of<UserAnswers>(ctx).getAnswers();

    // //to do
    // Question q =
    //     _questionList.firstWhere((element) {
    //       temp.forEach((element) {if (element.qid != _currentQuestionId){

    //       }});
    //     });
  }

  // String? nextQuestion() {
  //   if (_questionNumber != _questionList.length) {
  //     _isAnswered = false;
  //   } else {
  //     return "Done";
  //   }
  // }

  // Future<bool> checkAns(int selectedIndex) {
  //   Question q = _questionList.firstWhere((element) =>
  //       element.id == _currentQuestionId && element.answer == selectedIndex);

  //    if (q.answer == selectedIndex) {
  //      _numOfCorrectAns++;
  //    }

  //   return Future.delayed(
  //     Duration(seconds: 1),
  //     () {
  //       String? temp = nextQuestion();
  //       if (temp == "Done") {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     },
  //   );
  // }

}
