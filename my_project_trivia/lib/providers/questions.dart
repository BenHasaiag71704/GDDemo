import 'dart:io';
//
//import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:my_project_trivia/models/user_question_answer.dart';
import 'package:my_project_trivia/providers/user.dart';
import 'package:my_project_trivia/providers/user_answers.dart';

import 'package:my_project_trivia/models/user_question_answer.dart';
import 'package:my_project_trivia/screens/score/score_screen.dart';

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
  int _currentQuestionNum = 1;

  String? _currentQuestionId = "A8PSDd397UwSAw7AHAxd";

  Future<void> fetchQuestions() async {
    if (_questionList.isEmpty) {
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
    } else {}

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

  int get getQnNum {
    return _currentQuestionNum;
  }

  Question getCurrentQuestion() {
    Question q =
        _questionList.firstWhere((element) => element.id == _currentQuestionId);
    return q;
  }

  String? getCurrentId() {
    return _currentQuestionId;
  }

  // void didEnd(BuildContext ctx) {
  //   if (_currentQuestionId == _questionList.last) {
  //     Navigator.pushReplacement(
  //         ctx, MaterialPageRoute(builder: (context) => ScoreScreen()));
  //   }
  // }

  void endGame(BuildContext ctx) {
    if (_currentQuestionNum == 7) {
      Navigator.pushReplacement(
          ctx, MaterialPageRoute(builder: (context) => ScoreScreen()));
    }
  }

  void getNextQuestion(BuildContext ctx) {
    Question q = _questionList.firstWhere(
      (element) {
        return Provider.of<UserAnswers>(ctx, listen: false).isExistCheck(
                element.id, Provider.of<AppUser>(ctx, listen: false).uid!) ==
            false;
      },
    );
    _currentQuestionId = q.id;
    _currentQuestionNum = _currentQuestionNum + 1;
    notifyListeners();
  }
}



//   void getNextQuestion(BuildContext ctx) {
//     Question q = _questionList.firstWhere(
//       (element) {
//         return Provider.of<UserAnswers>(ctx, listen: false)
//                 .isExistCheck(_currentQuestionId!) ==
//             false;
//       },
//     );
//     _currentQuestionId = q.id;
//     notifyListeners();
//   }
// }



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
// void endGame() {
  //   _questionNumber = 1;
  //   _selectedAns = 0;
  //   _isAnswered = false;
  //   _numOfCorrectAns = 0;
  // }
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