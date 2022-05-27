import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project_trivia/OLD/room.dart';

class AllRooms with ChangeNotifier {
  void creatNewRoom(String uid1) async {
    final r = await FirebaseFirestore.instance.collection('AllRooms').add({
      "uid1": uid1,
      "uid2": "",
      "isWaiting": true,
      "score1": 0,
      "score2": 0,
    });
  }

  void joinNewRoom(String uid2, String roomid) {
    FirebaseFirestore.instance
        .collection('AllRooms')
        .doc(roomid)
        .update({'uid2': uid2});
  }
}
