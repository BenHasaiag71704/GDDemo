import 'dart:io';
//
//import 'dart:js';

import 'package:flutter/foundation.dart';
//אimport 'package:get/get.dart';
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
  int _currentQuestionNum = 1;
  bool _isClicked = false;
  int _totlScore = 0;
  bool timerResert = false;
  String? _currentQuestionId = "";

  //String? _currentQuestionId = "0Z8QH7x5eHWz0fgocpeh";
  // bool _isAnswered = false;
  // late int _correctAns;
  // late int _selectedAns;
  // int _numOfCorrectAns = 0;
  // int _questionNumber = 0;
  //String? _currentQuestionId = "";

  // טענת כניסה - אין
  // טענת יציאה - אין
  // מטרת הפעולה - לשאוב את מאגר השאלות ממסד הנתונים
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

  // טענת כניסה - אין
  // טענת יציאה - החזרת משתנה מסוג מחרוזת
  // מטרת הפעולה - פעולה המחזירה את סוג השאלה
  String getType() {
    Question q = _finalQuestionList
        .firstWhere((element) => (element.id == _currentQuestionId));
    return q.type;
  }

  // טענת כניסה -  אין
  // טענת יציאה - אין
  // מטרת הפעולה - מילוי שלושת הרשימות המכילות שאלות מסוג משתנה אחד בעת פתיחת האפליקציה
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

  void getBackQn(String str) {
    if (_questionList.isEmpty == false) {
      _finalQuestionList.forEach((element) {
        if (element.type == str) {
          _questionList.add(element);
        }
      });
    } else {
      if (str == "math") {
        _questionList = _onlyMathList;
      }
      if (str == "hebrew") {
        _questionList = _onlyHberewList;
      }
      if (str == "english") {
        _questionList = _onlyEnglishList;
      }
    }
    notifyListeners();
    print(_questionList.length);
  }

  // // טענת כניסה - אין
  // // טענת יציאה - אין
  // // מטרת הפעולה - להחזיר את שאלות האנגלית לרשימה הראשית עליה אנו עובדים
  // void getBackEnglish() {
  //   if (_questionList.isEmpty == false) {
  //     _finalQuestionList.forEach((element) {
  //       if (element.type == "english") {
  //         _questionList.add(element);
  //       }
  //     });
  //   } else {
  //     _questionList = _onlyEnglishList;
  //   }

  //   notifyListeners();
  //   print(_questionList.length);
  // }

  // // טענת כניסה - אין
  // // טענת יציאה - אין
  // // מטרת הפעולה - להחזיר את שאלות העברית לרשימה הראשית עליה אנו עובדים
  // void getBackHebrew() {
  //   if (_questionList.isEmpty == false) {
  //     _finalQuestionList.forEach((element) {
  //       if (element.type == "hebrew") {
  //         _questionList.add(element);
  //       }
  //     });
  //   } else {
  //     _questionList = _onlyHberewList;
  //   }

  //   notifyListeners();
  //   print(_questionList.length);
  // }

  // // טענת כניסה - אין
  // // טענת יציאה - אין
  // // מטרת הפעולה - להחזיר את שאלות מתמטיקה לרשימה הראשית עליה אנו עובדים
  // void getBackMath() {
  //   if (_questionList.isEmpty == false) {
  //     _finalQuestionList.forEach((element) {
  //       if (element.type == "math") {
  //         _questionList.add(element);
  //       }
  //     });
  //   } else {
  //     _questionList = _onlyMathList;
  //   }

  //   notifyListeners();
  //   print(_questionList.length);
  // }

  // טענת כניסה - אין
  // טענת יציאה - אין
  // מטרת הפעולה - להוציא את שאלות המתמטיקה מהרשימה הראשית עליה אנו עובדים

  void cleanAllTypeQn(String str) {
    List<Question> temp = [];
    _questionList.forEach((element) {
      if (element.type != str) {
        temp.add(element);
      }
    });
    _questionList = temp;
    notifyListeners();
    print(_questionList.length);
  }

  // void cleanMath() {
  //   List<Question> temp = [];
  //   _questionList.forEach((element) {
  //     if (element.type != "math") {
  //       temp.add(element);
  //     }
  //   });
  //   _questionList = temp;
  //   notifyListeners();
  //   print(_questionList.length);
  // }

  // // טענת כניסה - אין
  // // טענת יציאה - אין
  // // מטרת הפעולה - להוציא את שאלות העברית מהרשימה הראשית עליה אנו עובדים
  // void cleanHebrew() {
  //   List<Question> temp = [];
  //   _questionList.forEach((element) {
  //     if (element.type != "hebrew") {
  //       temp.add(element);
  //     }
  //   });
  //   _questionList = temp;
  //   notifyListeners();
  //   print(_questionList.length);
  // }

  // // טענת כניסה - אין
  // // טענת יציאה - אין
  // // מטרת הפעולה - להוציא את שאלות האנגלית מהרשימה הראשית עליה אנו עובדים
  // void cleanEnglish() {
  //   List<Question> temp = [];
  //   _questionList.forEach((element) {
  //     if (element.type != "english") {
  //       temp.add(element);
  //     }
  //   });
  //   _questionList = temp;
  //   notifyListeners();
  //   print(_questionList.length);
  // }

  // טענת כניסה - אין
  // טענת יציאה - אין
  // מטרת הפעולה - לאפס את המשתנה השומר את מספר השאלה הנוכחי
  void resetQnNum() {
    _currentQuestionNum = 1;
    notifyListeners();
  }

  // טענת כניסה - משתנה מסוג buildContext
  // טענת יציאה - אין
  // מטרת הפעולה - להחזיר את מחרוזת הזיהוי של השאלה
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

  // טענת כניסה - אין
  // טענת יציאה - אין
  // מטרת הפעולה - ניקוי הרשימה
  void cleanQn() {
    _questionList = [];
    notifyListeners();
  }

  // טענת כניסה - אין
  // טענת יציאה - אין
  // מטרת הפעולה - עדכון המשתנה השומר את התוצאה
  void updateScore() {
    _totlScore = _totlScore + 1;
  }

  // טענת כניסה - אין
  // טענת יציאה - משתנה מסוג מספר
  // מטרת הפעולה - החזרת הניקוד הכולל
  int get getTotalScore {
    return _totlScore;
  }

  // טענת כניסה - אין
  // טענת יציאה - הפעולה מחזירה רשימה של שאלות
  // מטרת הפעולה - להחזיר עותק של רשימת השאלות
  List<Question> get getTheList {
    return [..._questionList];
  }

  //  לכל ה4 הבאים :
  // טענת כניסה - אין
  // טענת יציאה - הפעולה מחזירה משתנה מסוג מספר שלם
  // מטרת הפעולה - להחזיר את אורך המערכים
  int get getTheListLng {
    return _finalQuestionList.length;
  }

  int get getTheMathLng {
    return _onlyMathList.length;
  }

  int get getTheHebrewLng {
    return _onlyHberewList.length;
  }

  int get getTheEnglishLng {
    return _onlyEnglishList.length;
  }
////

  // List<Question> get getTheFinalList {
  //   return [..._finalQuestionList];
  // }

  // טענת כניסה - אין
  // טענת יציאה - הפעולה מחזירה משתנה בוליאני
  // מטרת הפעולה - לבדוק האם הלחיצה התבצעה (בזמן המשחק)
  bool get isClicked {
    return _isClicked;
  }

  // טענת כניסה - אין
  // טענת יציאה - אין
  // מטרת הפעולה - להפוך את המשתנה בעת לחיצה (מנכון לשגוי ולהפך)
  Future<void> switchBack() async {
    Future.delayed(Duration(milliseconds: 500), () {
      _isClicked = !_isClicked;
    });
  }

  // טענת כניסה - משתנה מסוג BuildContext
  // טענת יציאה - אין
  // מטרת הפעולה - להפוך את המשתנה בעת לחיצה + להעביר לשאלה הבאה
  void switchClick(ctx) {
    _isClicked = !_isClicked;
    Future.delayed(Duration(milliseconds: 500), () {
      getNextQuestion(ctx);
    });
    notifyListeners();
  }

  // טענת כניסה - אין
  // טענת יציאה - משתנה מסוג מספר שלם
  // מטרת הפעולה - להחזיר את מספר השאלה הנוכחי
  int get getQnNum {
    return _currentQuestionNum;
  }

  // טענת כניסה - אין
  // טענת יציאה - משתנה מסוג שאלה
  // מטרת הפעולה - להחזיר את  השאלה הנוכחית
  Question getCurrentQuestion() {
    Question q =
        _questionList.firstWhere((element) => element.id == _currentQuestionId);
    return q;
  }

  // טענת כניסה - אין
  // טענת יציאה - משתנה מסוג מחרוזת
  // מטרת הפעולה - להחזיר את  המחרוזת המזהה של השאלה הנוכחית
  String? getCurrentId() {
    return _currentQuestionId;
  }

  // void didEnd(BuildContext ctx) {
  //   if (_currentQuestionId == _questionList.last) {
  //     Navigator.pushReplacement(
  //         ctx, MaterialPageRoute(builder: (context) => ScoreScreen()));
  //   }
  // }

  // טענת כניסה - משתנה מסוג מספר + buildContext
  // טענת יציאה - אין
  // מטרת הפעולה - לעבור למסך הסיום
  void endGame(BuildContext ctx, int Num) {
    if (Num == 0) {
      Navigator.pushReplacement(
          ctx, MaterialPageRoute(builder: (context) => ScoreScreen()));
    }
  }

  // טענת כניסה - אין
  // טענת יציאה - אין
  // מטרת הפעולה - לאפס את הטיימר לשגוי
  void startTimerAgain() {
    timerResert = false;
    //notifyListeners();
  }

  // טענת כניסה - משתנה מסוג buildContext
  // טענת יציאה - אין
  // מטרת הפעולה - לעבור אל השאלה הבאה
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
