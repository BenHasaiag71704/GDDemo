import 'dart:developer';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardScreen extends StatefulWidget {
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  Widget build(BuildContext context) {
    int plaerCount = 5;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(child: Text("leaderboard")),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue.shade400, Colors.green.shade200],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .orderBy('totalPoint', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot> leaderboardSnapShot) {
                  if (leaderboardSnapShot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final playerCount = leaderboardSnapShot.data!.docs.length;
                  final playerSnapShot = leaderboardSnapShot.data!.docs;
                  return ListView.builder(
                    itemCount: (playerCount),
                    itemBuilder: (context, index) => Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              playerSnapShot[index]['totalPoint'].toString() +
                                  " - " +
                                  playerSnapShot[index]['nickname'].toString(),
                              style: TextStyle(
                                  fontSize: index == 0
                                      ? 65
                                      : index == 1
                                          ? 55
                                          : index == 2
                                              ? 50
                                              : 40,
                                  color: index == 0
                                      ? Colors.yellow
                                      : index == 1
                                          ? Colors.grey
                                          : index == 2
                                              ? Colors.amber
                                              : Colors.black),
                            ),
                          ),
                          Icon(
                            index < 3 ? Icons.emoji_events : null,
                            size: index == 0
                                ? 65
                                : index == 1
                                    ? 55
                                    : index == 2
                                        ? 50
                                        : null,
                            color: index == 0
                                ? Colors.yellow
                                : index == 1
                                    ? Colors.grey
                                    : index == 2
                                        ? Colors.amber
                                        : null,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   Card SinglePlayerScore(AsyncSnapshot<QuerySnapshot<Object?>> leaderboardSnapShot) {
//     return Card(Text( leaderboardSnapShot.data!.docs['totalPoint'].toString()));
//   }
// }
//