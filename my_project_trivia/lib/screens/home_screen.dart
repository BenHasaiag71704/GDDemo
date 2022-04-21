import 'package:flutter/material.dart';
import 'package:my_project_trivia/providers/questions.dart';
import '../providers/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './user_info_screen.dart';
import './leaderboard_screen.dart';
import '../models/question.dart';
import './game_screen.dart';

enum Prefs {
  All,
  OnlyEnglish,
  OnlyHebrew,
  OnlyMath,
  MathAndHebrew,
  MatnAndEnglish,
  EnglishAndHebrew,
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  Prefs wantedGame = Prefs.All;

  @override
  void didChangeDependencies() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Questions>(context, listen: false).getQuestions();
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

  @override
  Widget build(BuildContext context) {
    var userDataCollect = Provider.of<AppUser>(context);
    var questionList = Provider.of<Questions>(context).getTheList;
    bool IsZero = questionList.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("welcome"),
        ),
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
      body:
          //  _isLoading || IsZero
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          // :
          Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("ברוכים הבאים למסך הראשי"),
          // Text(questionList[0].Classification),
          // Text(questionList[1].Classification),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(GameScreen.routeName, arguments: wantedGame);
              },
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(55.0),
                ),
                primary: Colors.pink[500],
              ),
              child: Text("start play!"),
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
                    borderRadius: new BorderRadius.circular(55.0),
                  ),
                  primary: Colors.pink[500],
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
                    borderRadius: new BorderRadius.circular(55.0),
                  ),
                  primary: Colors.pink[500],
                ),
                child: Text("leaderboard"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
