import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:my_project_trivia/models/user_question_answer.dart';

class UserAnswers extends ChangeNotifier {
  late List<UserQuestionAnswer> _userAnswerList = [];

  //List<UserQuestionAnswer> getAnswers() => this.userAnswerList;

  // טענת כניסה - אין
  // טענת יציאה -   אין
  // מטרת הפעולה -  לשאוב את מאגר השאלות שנענו על ידי משתמשים ממס הנתונים
  Future<void> fetchAnswerdQn() async {
    if (_userAnswerList.isEmpty) {
      try {
        await FirebaseFirestore.instance.collection('UserAnswer').get().then(
          (snapshot) {
            snapshot.docs.forEach((document) {
              _userAnswerList.add(UserQuestionAnswer(
                ansTime: (document['ansTime'] as Timestamp).toDate(),
                isCorrect: document['isCorrect'],
                qid: document['qid'],
                uid: document['uid'],
                type: document['type'],
              ));
            });
          },
        );
      } catch (e) {
        print(e);
      }
    } else {}
    print(_userAnswerList);
  }

  //  נכון עבור שלושת הפעולות הבאות

  // טענת כניסה - המחרוזת המזהה של המשתמש
  // טענת יציאה - משתנה מסוג מספר שלם
  // מטרת הפעולה - להחזיר את   מספר השאלות שמשתמש ענה נכון מאותו סוג של שאלה

  int getStypeScore(String? userid, String str) {
    int temp = 0;
    _userAnswerList.forEach((element) {
      if (element.uid == userid &&
          element.type == str &&
          element.isCorrect == true) {
        temp = temp + 1;
      }
    });
    return temp;
  }

  // int getMathScore(String? userid) {
  //   int temp = 0;
  //   _userAnswerList.forEach((element) {
  //     if (element.uid == userid &&
  //         element.type == "math" &&
  //         element.isCorrect == true) {
  //       temp = temp + 1;
  //     }
  //   });
  //   return temp;
  // }

  // int getHebrewScore(String? userid) {
  //   int temp = 0;
  //   _userAnswerList.forEach((element) {
  //     if (element.uid == userid && element.type == "hebrew") {
  //       if (element.isCorrect == true) {
  //         temp++;
  //       }
  //     }
  //   });
  //   return temp;
  // }

  // int getEnglishScore(String? userid) {
  //   int temp = 0;
  //   _userAnswerList.forEach((element) {
  //     if (element.uid == userid &&
  //         element.type == "english" &&
  //         element.isCorrect == true) {
  //       temp = temp + 1;
  //     }
  //   });
  //   return temp;
  // }

  //  נכון עבור שלושת הפעולות הבאות

  // טענת כניסה - המחרוזת המזהה של המשתמש
  // טענת יציאה - משתנה מסוג מספר שלם
  // מטרת הפעולה - להחזיר את   מספר השאלות שמשתמש ענה (נכון או לא נכון) מאותו סוג של שאלה
  int getNumOfAnsweredHebrewQn(String? userid) {
    int temp = 0;
    _userAnswerList.forEach((element) {
      if (element.uid == userid && element.type == "hebrew") {
        temp = temp + 1;
      }
    });
    return temp;
  }

  int getNumOfAnsweredMathQn(String? userid) {
    int temp = 0;
    _userAnswerList.forEach((element) {
      if (element.uid == userid && element.type == "math") {
        temp = temp + 1;
      }
    });
    return temp;
  }

  int getNumOfAnsweredEnglishQn(String? userid) {
    int temp = 0;
    _userAnswerList.forEach((element) {
      if (element.uid == userid && element.type == "english") {
        temp = temp + 1;
      }
    });
    return temp;
  }

  // טענת כניסה - אין
  // טענת יציאה - אין
  // מטרת הפעולה - לאפס את רשימת השאלות שנענו
  void cleanAnsQn() {
    _userAnswerList = [];
    notifyListeners();
  }

  // טענת כניסה - אין
  // טענת יציאה - רשימה של שאלות שנענו
  // מטרת הפעולה - להחזיר את רשימת השאלות שנענו
  List<UserQuestionAnswer> get getTheAnswers {
    return [..._userAnswerList];
  }

  // טענת כניסה - משתנה מסוג מחרוזת
  // טענת יציאה - משתנה מסוג מספר שלם
  // מטרת הפעולה - להחזיר את מספר השאלות הכולל שמשתמש ענה עליהן
  int getSingleUserQnAnswerd(String? userid) {
    int count = 0;
    _userAnswerList.forEach((element) {
      if (element.uid == userid) {
        count = count + 1;
      }
    });
    return count;
  }

  // טענת כניסה - 3 משתנים מסוג מחרוזת ומשתנה אחד מסוג בוליאנלי
  // טענת יציאה - אין
  // מטרת הפעולה - הפעולה מוסיפה לרשימה המקומית ומסד הנתונים שאלה שמתשמ ענה עליה
  void addToListGetUserAnswers(
      String uid, String qid, String type, bool b1) async {
    _userAnswerList.add(UserQuestionAnswer(
        uid: uid,
        qid: qid,
        type: type,
        ansTime: DateTime.now(),
        isCorrect: b1));
    await FirebaseFirestore.instance.collection('UserAnswer').add({
      "uid": uid,
      "qid": qid,
      "type": type,
      "ansTime": DateTime.now(),
      "isCorrect": b1
    });
    notifyListeners();
  }

  // טענת כניסה - 2 משתנים מסוג מחרוזת
  // טענת יציאה - משתנה בוליאני
  // מטרת הפעולה - בדיקה האם השאלה הספציפית כבר נענתה על ידי המשתמש

  bool isExistCheck(String cuttrentId, String userid) {
    bool temp = false;
    if (_userAnswerList.isEmpty) {
      return false;
    }
    _userAnswerList.forEach((element) {
      {
        if (element.qid == cuttrentId && element.uid == userid) {
          temp = true;
        }
      }
    });
    return temp;
  }
}
