import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AppUser with ChangeNotifier {
  String? uid;
  String? username;
  int totalPoint = 0;
  int mathpoint = 0;
  int hebrewpoint = 0;
  int englishpoint = 0;
  final _auth = FirebaseAuth.instance;

  void sumbitAuthForm(
    String email,
    String password,
    String username,
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
        String newname = await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .get()
            .then((snapshot) => snapshot.data()!['username']);
        userDataCollect.setUserName(newname);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        userDataCollect.setUid(authResult.user!.uid);
        userDataCollect.setUserName(username);
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'totalPoint': 0,
          'mathpoint': 0,
          'hebrewpoint': 0,
          'englishpoint': 0,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occured , please check your credentials!';

      if (err.message != null) {
        message = err.message.toString();
      }

      // ScaffoldMessenger.of(ctx).showSnackBar(
      //   SnackBar(
      //     content: Text(message),
      //     backgroundColor: Theme.of(ctx).errorColor,
      //   ),
      // );
    } catch (err) {
      print(err);
    }
  }

  void setUid(String userId) {
    uid = userId;
    notifyListeners();
  }

  void setUserName(String name) {
    username = name;
    notifyListeners();
  }
}
