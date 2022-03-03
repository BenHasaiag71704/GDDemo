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
  bool IsNickNameOpen = true;
  @override
  Widget build(BuildContext context) {
    var userDataCollect = Provider.of<AppUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("userinfo"),
      ),
      body: Column(
        children: [
          Text("welcome"),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                TextField(
                  focusNode: UserFocus,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: "please enter a nickname",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  autocorrect: false,
                  enableSuggestions: false,
                ),
                ElevatedButton(
                    onPressed: () =>
                        userDataCollect.setUserName(_controller.text),
                    child: Text("Submit")),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        "ניקוד כולל" + userDataCollect.getTotalPoint.toString())
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text("אחוז הצלחה" +
                        ((userDataCollect.getTotalPoint) *
                                (userDataCollect.getLostPoint))
                            .toString()),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [Text("b")],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [Text("c")],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
