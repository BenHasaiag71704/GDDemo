import 'package:flutter/material.dart';
import '../providers/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './user_info_screen.dart';
import './leaderboard_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userDataCollect = Provider.of<AppUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("welcome" + " " + userDataCollect.username.toString())),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("ברוכים הבאים למסך הראשי"),
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
