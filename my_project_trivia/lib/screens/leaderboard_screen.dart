import 'dart:developer';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:my_project_trivia/widgets/toggle_bar.dart';
import 'package:provider/provider.dart';

class LeaderBoardScreen extends StatefulWidget {
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  int counter = 0;
  int lng = 20;
  String theFiltter = 'totalPoint';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
            ),
            ToggleBar(
              labels: ["all", "hebrew", "english", "math"],
              textColor: Colors.black,
              selectedTextColor: Colors.black,
              backgroundColor: Colors.lightGreenAccent,
              selectedTabColor: Colors.white,
              onSelectionUpdated: (index) {
                setState(() {
                  counter = index;
                });
                switch (counter) {
                  case 0:
                    setState(() {
                      theFiltter = 'totalPoint';
                      lng = Provider.of<Questions>(context, listen: false)
                          .getTheListLng;
                    });
                    break;
                  case 1:
                    setState(() {
                      theFiltter = 'hebrewpoint';
                      lng = Provider.of<Questions>(context, listen: false)
                          .getTheHebrewLng;
                    });
                    break;
                  case 2:
                    setState(() {
                      theFiltter = 'englishpoint';
                      lng = Provider.of<Questions>(context, listen: false)
                          .getTheEnglishLng;
                    });
                    break;
                  case 3:
                    setState(() {
                      theFiltter = 'mathpoint';
                      lng = Provider.of<Questions>(context, listen: false)
                          .getTheMathLng;
                    });
                    break;
                }
              },
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .orderBy('${theFiltter}', descending: true)
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
                            child: Card(
                              color: Colors.greenAccent.shade400,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 325,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              (playerSnapShot[index]['nickname']
                                                      .toString()) +
                                                  " - " +
                                                  ((playerSnapShot[index][
                                                                  '${theFiltter}'] /
                                                              lng) *
                                                          100)
                                                      .toStringAsFixed(2) +
                                                  "%",
                                              style: TextStyle(
                                                  color: index == 0
                                                      ? Colors.yellow
                                                      : index == 1
                                                          ? Colors.grey
                                                          : index == 2
                                                              ? Colors.amber
                                                              : Colors.black),
                                            ),
                                            Icon(
                                              index < 3
                                                  ? Icons.emoji_events
                                                  : null,
                                              color: index == 0
                                                  ? Colors.yellow
                                                  : index == 1
                                                      ? Colors.grey
                                                      : index == 2
                                                          ? Colors.amber
                                                          : null,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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