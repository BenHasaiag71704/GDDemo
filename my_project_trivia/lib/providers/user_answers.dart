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

  void cleanAnsQn() {
    _userAnswerList = [];
    notifyListeners();
  }

  List<UserQuestionAnswer> get getTheAnswers {
    return [..._userAnswerList];
  }

  int getSingleUserQnAnswerd(String? userid) {
    int count = 0;
    _userAnswerList.forEach((element) {
      if (element.uid == userid) {
        count = count + 1;
      }
    });
    return count;
  }

  void addToListGetUserAnswers(String uid, String qid, bool b1) async {
    _userAnswerList.add(UserQuestionAnswer(
        uid: uid, qid: qid, ansTime: DateTime.now(), isCorrect: true));
    await FirebaseFirestore.instance.collection('UserAnswer').add(
        {"uid": uid, "qid": qid, "ansTime": DateTime.now(), "isCorrect": b1});
    notifyListeners();
  }

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
