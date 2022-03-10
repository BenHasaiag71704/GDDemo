import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _controller = TextEditingController();
  FocusNode UserFocus = FocusNode();
  bool _IsNickNameOpen = true;
  bool _NoPoint = true;
  bool _IsOpen = true;
  @override
  Widget build(BuildContext context) {
    var userDataCollect = Provider.of<AppUser>(context);
    if (userDataCollect.getTotalPoint >= 1) {
      setState(() {
        _NoPoint = false;
      });
    }
    if (userDataCollect.getTotalPoint == 0) {
      setState(() {
        _NoPoint = true;
      });
    }
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("userinfo"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => setState(() {
              _IsOpen = !_IsOpen;
            }),
            child: Text("enter or change nickname"),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 170),
              child: Text(
                userDataCollect.getNickName.toString(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            color: Colors.green,
          ),
          _IsOpen
              ? Card(
                  color: Colors.pink[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      TextField(
                        textAlign: TextAlign.center,
                        focusNode: UserFocus,
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText:
                              "                                               הכנס שם משתמש",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        autocorrect: false,
                        enableSuggestions: false,
                      ),
                      ElevatedButton(
                          onPressed: () => setState(() {
                                userDataCollect.setUserName(_controller.text);
                              }),
                          child: Text("Submit")),
                    ],
                  ),
                )
              : Card(
                  child: Column(
                  children: [
                    Row(
                      children: [Text(userDataCollect.getNickName.toString())],
                    )
                  ],
                )),
          Card(
            color: Colors.pink[200],
            //color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "ניקוד כולל" +
                          " " +
                          userDataCollect.getTotalPoint.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _NoPoint
                          ? "אחוז הצלחה : אחוז ההצלחה עוד לא הוגדר"
                          : "אחוז ההצלחה שלך הוא : " +
                              (((userDataCollect.getTotalPoint -
                                              userDataCollect.getLostPoint) /
                                          (userDataCollect.getTotalPoint)) *
                                      100)
                                  .toStringAsFixed(2) +
                              "%",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "מספר השאלות בסיווג כמותי שענית עליהן נכון" +
                          " " +
                          userDataCollect.getMathPoint.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "מספר השאלות בסיווג מילולי שענית עליהן נכון" +
                          " " +
                          userDataCollect.getHebrewPoint.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "מספר השאלות בסיווג אנגלי שענית עליהן נכון" +
                          " " +
                          userDataCollect.getEnglishPoint.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
