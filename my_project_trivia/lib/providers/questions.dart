import 'dart:io';
//
//import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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
  late List<Question> _finalQuestionList = [];

  late List<Question> _onlyMathList = [];
  late List<Question> _onlyHberewList = [];
  late List<Question> _onlyEnglishList = [];

  // bool _isAnswered = false;
  // late int _correctAns;
  // late int _selectedAns;
  // int _numOfCorrectAns = 0;
  // int _questionNumber = 0;
  int _currentQuestionNum = 1;
  bool _isClicked = false;
  int _totlScore = 0;

  bool timerResert = false;

  //String? _currentQuestionId = "0Z8QH7x5eHWz0fgocpeh";
  String? _currentQuestionId = "";

  Future<void> fetchQuestions() async {
    if (_questionList.isEmpty && _onlyMathList.isEmpty) {
      try {
        await FirebaseFirestore.instance.collection('questions').get().then(
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
        _finalQuestionList = _questionList;
      } catch (e) {
        print(e);
      }
    } else {}
  }

  String getType() {
    Question q = _finalQuestionList
        .firstWhere((element) => (element.id == _currentQuestionId));
    return q.type;
  }

  void setAlltheOneTypeLists() {
    if (_onlyMathList.isEmpty &&
        _onlyEnglishList.isEmpty &&
        _onlyHberewList.isEmpty) {
      _finalQuestionList.forEach((element) {
        if (element.type == "math") {
          _onlyMathList.add(element);
        }
        if (element.type == "hebrew") {
          _onlyHberewList.add(element);
        }
        if (element.type == "english") {
          _onlyEnglishList.add(element);
        }
      });
    }
  }

  void getBackEnglish() {
    if (_questionList.isEmpty == false) {
      _finalQuestionList.forEach((element) {
        if (element.type == "english") {
          _questionList.add(element);
        }
      });
    } else {
      _questionList = _onlyEnglishList;
    }

    notifyListeners();
    print(_questionList.length);
  }

  void getBackHebrew() {
    if (_questionList.isEmpty == false) {
      _finalQuestionList.forEach((element) {
        if (element.type == "hebrew") {
          _questionList.add(element);
        }
      });
    } else {
      _questionList = _onlyHberewList;
    }

    notifyListeners();
    print(_questionList.length);
  }

  void getBackMath() {
    if (_questionList.isEmpty == false) {
      _finalQuestionList.forEach((element) {
        if (element.type == "math") {
          _questionList.add(element);
        }
      });
    } else {
      _questionList = _onlyMathList;
    }

    notifyListeners();
    print(_questionList.length);
  }

  void cleanMath() {
    List<Question> temp = [];
    _questionList.forEach((element) {
      if (element.type != "math") {
        temp.add(element);
      }
    });
    _questionList = temp;
    notifyListeners();
    print(_questionList.length);
  }

  void cleanHebrew() {
    List<Question> temp = [];
    _questionList.forEach((element) {
      if (element.type != "hebrew") {
        temp.add(element);
      }
    });
    _questionList = temp;
    notifyListeners();
    print(_questionList.length);
  }

  void cleanEnglish() {
    List<Question> temp = [];
    _questionList.forEach((element) {
      if (element.type != "english") {
        temp.add(element);
      }
    });
    _questionList = temp;
    notifyListeners();
    print(_questionList.length);
  }

  void resetQnNum() {
    _currentQuestionNum = 1;
    notifyListeners();
  }

  void getFirstId(BuildContext ctx) {
    Question q = _questionList.firstWhere(
      (element) {
        return Provider.of<UserAnswers>(ctx, listen: false).isExistCheck(
                element.id, Provider.of<AppUser>(ctx, listen: false).uid!) ==
            false;
      },
    );
    _currentQuestionId = q.id;
  }

  void cleanQn() {
    _questionList = [];
    notifyListeners();
  }

  void updateScore() {
    _totlScore = _totlScore + 1;
  }

  int get getTotalScore {
    return _totlScore;
  }

  void willBeDeletedSoon() async {
    await FirebaseFirestore.instance.collection('questions').add({
      "answer": 1,
      "question": "str",
      "type": "str",
      "options": ["0", "1", "2", "3"]
    });
  }

  List<Question> get getTheList {
    return [..._questionList];
  }

  // List<Question> get getTheFinalList {
  //   return [..._finalQuestionList];
  // }

  bool get isClicked {
    return _isClicked;
  }

  Future<void> switchBack() async {
    Future.delayed(Duration(milliseconds: 500), () {
      _isClicked = !_isClicked;
    });
  }

  void switchClick(ctx) {
    _isClicked = !_isClicked;
    Future.delayed(Duration(milliseconds: 500), () {
      getNextQuestion(ctx);
    });
    notifyListeners();
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

  void endGame(BuildContext ctx, int Num) {
    if (Num == 0) {
      Navigator.pushReplacement(
          ctx, MaterialPageRoute(builder: (context) => ScoreScreen()));
    }
  }

  void startTimerAgain() {
    timerResert = false;
    //notifyListeners();
  }

  void getNextQuestion(BuildContext ctx) {
    timerResert = true;
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

    // int i = _finalQuestionList.length;
    // int x = 0;
    // while (x < i - 1) {
    //   if (_finalQuestionList[x].type == "math") {
    //     _questionList.add(_finalQuestionList[x]);
    //   }
    // }