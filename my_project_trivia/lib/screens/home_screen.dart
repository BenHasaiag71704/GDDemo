import 'package:flutter/material.dart';
//--
//import 'package:my_project_trivia/providers/questions.dart';
//import '../models/question.dart';
//--
import 'package:my_project_trivia/providers/questions.dart';
import 'package:my_project_trivia/providers/user_answers.dart';
import 'package:my_project_trivia/screens/score/score_screen.dart';

import '../providers/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './user_info_screen.dart';
import './leaderboard_screen.dart';
import './game_screen.dart';

enum Prefs {
  All,
  OnlyEnglish,
  OnlyHebrew,
  OnlyMath,
  MathAndHebrew,
  MatnAndEnglish,
  EnglishAndHebrew,
  None,
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  Prefs wantedGame = Prefs.All;
  bool isHebrew = true;
  bool isEnglish = true;
  bool isMath = true;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<UserAnswers>(context, listen: false)
        .fetchAnswerdQn()
        .then((value) {
      Provider.of<Questions>(context, listen: false)
          .fetchQuestions()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });

    super.didChangeDependencies();
  }

  // @override
  // Future<void> initState() async {
  //   await Provider.of<Questions>(context).getQuestions();
  //   super.initState();
  // }

  static Prefs updateEnum(isHebrew, isEnglish, isMath) {
    if (isHebrew == true && isEnglish == true && isMath == true) {
      return Prefs.All;
    }
    if (isHebrew == true && isEnglish == true && isMath == false) {
      return Prefs.EnglishAndHebrew;
    }
    if (isHebrew == true && isEnglish == false && isMath == true) {
      return Prefs.MathAndHebrew;
    }
    if (isHebrew == false && isEnglish == true && isMath == true) {
      return Prefs.MatnAndEnglish;
    }
    if (isHebrew == false && isEnglish == false && isMath == true) {
      return Prefs.OnlyMath;
    }
    if (isHebrew == false && isEnglish == true && isMath == false) {
      return Prefs.OnlyEnglish;
    }
    if (isHebrew == true && isEnglish == false && isMath == false) {
      return Prefs.OnlyHebrew;
    } else {
      return Prefs.None;
    }
  }

  @override
  Widget build(BuildContext context) {
    var userDataCollect = Provider.of<AppUser>(context);
    var questionList = Provider.of<Questions>(context).getTheList;
    var answerList = Provider.of<UserAnswers>(context).getTheAnswers;
    Provider.of<Questions>(context).setAlltheOneTypeLists();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          new DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(Icons.more_vert),
                items: [
                  DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(
                            width: 8,
                          ),
                          Text('LogOut'),
                        ],
                      ),
                    ),
                    value: 'logout',
                  ),
                ],
                onChanged: (itemIdentifier) {
                  if (itemIdentifier == 'logout') {
                    Provider.of<Questions>(context, listen: false).cleanQn();
                    Provider.of<UserAnswers>(context, listen: false)
                        .cleanAnsQn();
                    FirebaseAuth.instance.signOut();
                  }
                }),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue.shade400, Colors.green.shade200],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "welcome to home screen",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  //Text(answerList[1].ansTime.toString()),
                  // Text(questionList[1].question),
                  // Text(questionList[2].question),
                  // Text(questionList[3].question),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //math
                      Column(
                        children: [
                          Switch(
                            value: isMath,
                            onChanged: (value) {
                              // Provider.of<Questions>(context, listen: false)
                              //     .willBeDeletedSoon();
                              setState(() {
                                isMath = value;
                                print(isMath);
                                if (isMath == false) {
                                  Provider.of<Questions>(context, listen: false)
                                      .cleanMath();
                                }
                                if (isMath == true) {
                                  Provider.of<Questions>(context, listen: false)
                                      .getBackMath();
                                }
                                wantedGame =
                                    updateEnum(isHebrew, isEnglish, isMath);
                                print(wantedGame);
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                          Text("בחר מתמטיקה"),
                        ],
                      ),
                      // hebrew
                      SizedBox(width: 50),
                      Column(
                        children: [
                          Switch(
                            value: isHebrew,
                            onChanged: (value) {
                              setState(() {
                                isHebrew = value;
                                print(isHebrew);
                                if (isHebrew == false) {
                                  Provider.of<Questions>(context, listen: false)
                                      .cleanHebrew();
                                }
                                if (isHebrew == true) {
                                  Provider.of<Questions>(context, listen: false)
                                      .getBackHebrew();
                                }
                                wantedGame =
                                    updateEnum(isHebrew, isEnglish, isMath);
                                print(wantedGame);
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                          Text("בחר עברית"),
                        ],
                      ),
                      SizedBox(width: 50),
                      // english
                      Column(
                        children: [
                          Switch(
                            value: isEnglish,
                            onChanged: (value) {
                              setState(
                                () {
                                  isEnglish = value;
                                  print(isEnglish);
                                  if (isEnglish == false) {
                                    Provider.of<Questions>(context,
                                            listen: false)
                                        .cleanEnglish();
                                  }
                                  if (isEnglish == true) {
                                    Provider.of<Questions>(context,
                                            listen: false)
                                        .getBackEnglish();
                                    wantedGame =
                                        updateEnum(isHebrew, isEnglish, isMath);
                                    print(wantedGame);
                                  }
                                },
                              );
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                          Text("בחר אנגלית"),
                        ],
                      ),
                    ],
                  ),
                  // Text(questionList[0].Classification),
                  // Text(questionList[1].Classification),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        int anslng =
                            Provider.of<UserAnswers>(context, listen: false)
                                .getSingleUserQnAnswerd(
                                    Provider.of<AppUser>(context, listen: false)
                                        .uid);

                        int lng = Provider.of<Questions>(context, listen: false)
                            .getTheList
                            .length;
                        // int anslng =
                        //     Provider.of<UserAnswers>(context, listen: false)
                        //         .improvedgetSingleUserQnAnswerd(
                        //             Provider.of<AppUser>(context, listen: false)
                        //                 .uid,
                        //             isMath,
                        //             isHebrew,
                        //             isEnglish);
                        int end = lng - anslng;
                        if (wantedGame == Prefs.None) {
                          print("hello");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "אנא בחר לפחות מצב משחק אחד",
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        } else if (end <= 0) {
                          Navigator.of(context)
                              .pushNamed(ScoreScreen.routeName);
                        } else {
                          Provider.of<Questions>(context, listen: false)
                              .getFirstId(context);
                          Provider.of<Questions>(context, listen: false)
                              .resetQnNum();

                          // Future.delayed(Duration(milliseconds: 500), () {
                          //   Navigator.of(context).pushNamed(
                          //       GameScreen.routeName,
                          //       arguments: end);
                          // });
                          Navigator.of(context)
                              .pushNamed(GameScreen.routeName, arguments: end);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 100),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        primary: Colors.lightGreenAccent.shade100,
                      ),
                      child: Text(
                        "start play!",
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => UserInfoScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                          primary: Colors.lightGreenAccent.shade100,
                        ),
                        child: Text("User Page"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => LeaderBoardScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                          primary: Colors.lightGreenAccent.shade100,
                        ),
                        child: Text("leaderboard"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

// was at 276
                          //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text("ענית כבר על כל השאלות במשחק",
                          //         textAlign: TextAlign.center)));

                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ScoreScreen()));
