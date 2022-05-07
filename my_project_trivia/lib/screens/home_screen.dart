import 'package:flutter/material.dart';
//--
//import 'package:my_project_trivia/providers/questions.dart';
//import '../models/question.dart';
//--
import 'package:my_project_trivia/providers/questions.dart';

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
  void didChangeDependencies() async {
    setState(() {
      _isLoading = true;
    });
    // await Provider.of<AppUser>(context).getUid();

    await Provider.of<Questions>(context, listen: false).fetchQuestions();
    super.didChangeDependencies();
    setState(() {
      _isLoading = false;
    });
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
                    "ברוכים הבאים למסך הראשי",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  // Text(questionList[0].question),
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
                              setState(() {
                                isMath = value;
                                print(isMath);
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
                              setState(() {
                                isEnglish = value;
                                print(isEnglish);
                                wantedGame =
                                    updateEnum(isHebrew, isEnglish, isMath);
                                print(wantedGame);
                              });
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
                          print("hello");
                        } else {
                          Navigator.of(context).pushNamed(GameScreen.routeName,
                              arguments: wantedGame);
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
