import 'package:flutter/foundation.dart';
import 'package:my_project_trivia/models/question.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Questions with ChangeNotifier {
  List<Question> _questionList = [];

  Future<void> getQuestions() async {
    try {
      FirebaseFirestore.instance.collection('questions').get().then(
        (snapshot) {
          snapshot.docs.forEach((document) {
            _questionList.add(Question(
                document.id,
                document['Classification'],
                document['type'],
                document['thetext'],
                document['answer1'],
                document['answer2'],
                document['answer3'],
                document['answer4'],
                document['correctanswer']));
          });
        },
      );
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Question? getItem(int position) {
    if (position > _questionList.length)
      return null;
    else
      return _questionList[position];
  }

  List<Question> get getTheList {
    return _questionList;
  }
}

// final String qid;
//   final String Classification;
//   final String type;
//   final String thetext;
//   final String answer1;
//   final String answer2;
//   final String answer3;
//   final String answer4;
//   final int correctanswer;

// userDataCollect.setUid(authResult.user!.uid);
//         final result = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(authResult.user!.uid)
//             .get()
//             .then((snapshot) {
//           nickname = snapshot.data()!['nickname'];
//           totalPoint = snapshot.data()!['totalPoint'];
//           mathpoint = snapshot.data()!['mathpoint'];
//           hebrewpoint = snapshot.data()!['hebrewpoint'];
//           englishpoint = snapshot.data()!['englishpoint'];
//           lostpoint = snapshot.data()!['lostpoint'];