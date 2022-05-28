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
        title: Center(
            child: Text(
          "leaderboard",
          style: TextStyle(color: Colors.black, fontSize: 30),
        )),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 178, 255, 77),
              Color.fromARGB(255, 83, 233, 101),
              Color.fromARGB(255, 0, 186, 155),
            ],
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
                          SizedBox(
                            height: 100,
                            width: index == 0
                                ? 280
                                : index == 1
                                    ? 240
                                    : index == 2
                                        ? 200
                                        : 150,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  playerSnapShot[index]['totalPoint']
                                          .toString() +
                                      " - " +
                                      playerSnapShot[index]['nickname']
                                          .toString(),
                                  style: TextStyle(
                                      color: index == 0
                                          ? Colors.yellow
                                          : index == 1
                                              ? Colors.grey
                                              : index == 2
                                                  ? Colors.amber
                                                  : Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            index < 3 ? Icons.emoji_events : null,
                            color: index == 0
                                ? Colors.yellow
                                : index == 1
                                    ? Colors.grey
                                    : index == 2
                                        ? Colors.amber
                                        : null,
                          ),
                          Divider(
                            thickness: 10,
                            color: Colors.black,
                          ),
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