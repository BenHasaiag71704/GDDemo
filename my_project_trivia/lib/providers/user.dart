import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AppUser with ChangeNotifier {
  String? uid;
  String? nickname;
  int totalPoint = 0;
  int mathpoint = 0;
  int hebrewpoint = 0;
  int englishpoint = 0;
  int lostpoint = 0;
  final _auth = FirebaseAuth.instance;

  //  טענת כניסה - 2 משתנים מסוג מחרוזת , משתנה בוליאני ומשתנה מסוג buildContext
  // טענת יציאה - אין
  // מטרת הפעולה - הרשמה של משתמשים לאפליקציה

  void sumbitAuthForm(
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      final userDataCollect = Provider.of<AppUser>(ctx, listen: false);
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        userDataCollect.setUid(authResult.user!.uid);
        final result = await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .get()
            .then((snapshot) {
          nickname = snapshot.data()!['nickname'];
          totalPoint = snapshot.data()!['totalPoint'];
          mathpoint = snapshot.data()!['mathpoint'];
          hebrewpoint = snapshot.data()!['hebrewpoint'];
          englishpoint = snapshot.data()!['englishpoint'];
          lostpoint = snapshot.data()!['lostpoint'];
        });
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        userDataCollect.setUid(authResult.user!.uid);
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'nickname': "",
          'email': email,
          'totalPoint': 0,
          'mathpoint': 0,
          'hebrewpoint': 0,
          'englishpoint': 0,
          'lostpoint': 0,
        });
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An error occured , please check your credentials!';

      if (err.message != null) {
        message = err.message.toString();
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            "המשתמש אינו קיים במערכת/שם משתמש וססמא אינם נכונים",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue,
        ),
      );
    } catch (err) {
      print(err);
    }
  }

//---
  // Future<void> getUid() async {
  //   if (uid == '') {
  //     try {
  //       uid = await FirebaseAuth.instance.currentUser!.uid;
  //       notifyListeners();
  //     } on FirebaseAuthException catch (error) {
  //       if (kDebugMode) {
  //         print(error.message);
  //       }
  //     }
  //   }
  // }
//---

////////
  //  נכון ל6 הפעולות הבאות
  // טענת כניסה - אין
  // טענת יציאה - משתנה מסוג מחרוזת או מספר שלם
  // מטרת הפעולה - החזרת פיסת מידע על המשתמש
  String? get getNickName {
    return nickname;
  }

  int get getLostPoint {
    return lostpoint;
  }

  int get getTotalPoint {
    return totalPoint;
  }

  int get getHebrewPoint {
    return hebrewpoint;
  }

  int get getMathPoint {
    return mathpoint;
  }

  int get getEnglishPoint {
    return englishpoint;
  }

////////

  // טענת כניסה - משתנה מסוג מחרוזת
  // טענת יציאה - אין
  // מטרת הפעולה - עדכון המחרוזת המזהה של המשתמש
  void setUid(String userId) {
    uid = userId;
    notifyListeners();
  }
/////

// עבור 6 הפעולות הבאות

  // טענת כניסה - משתנה מסוג מחרוזת או מספר שלם
  // טענת יציאה - אין
  // מטרת הפעולה - לעדכן במסד הנתונים את המידע אשר התקבל
  void setUserName(String username) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'nickname': username});
    this.nickname = username;
    notifyListeners();
  }

  void setHebrewScore(int hebrewScore) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'hebrewpoint': hebrewScore});
    this.hebrewpoint = hebrewScore;
  }

  void setMathScore(int mathScore) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'mathpoint': mathScore});
    this.mathpoint = mathScore;
  }

  void setEnglishScore(int englishscore) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'englishpoint': englishscore});
    this.englishpoint = englishscore;
  }

  void addTotalScore(int a, int b, int c) {
    int d = a + b + c;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'totalPoint': d});
    this.totalPoint = d;
    notifyListeners();
  }

  void setLostPoint(int correct, int lng) {
    int d = lng - correct;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'lostpoint': d});
    this.lostpoint = d;
    notifyListeners();
  }
/////

}
