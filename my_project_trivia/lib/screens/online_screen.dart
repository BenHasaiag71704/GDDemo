//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project_trivia/widgets/chat/messages.dart';
import 'package:my_project_trivia/widgets/chat/new_message.dart';

class OnlineScreen extends StatefulWidget {
  @override
  State<OnlineScreen> createState() => _OnlineScreenState();
}

class _OnlineScreenState extends State<OnlineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ברוך הבא לצאט!"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
// floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           FirebaseFirestore.instance.collection('chat').add(
//             {'text': "this was added!"},
//           );
//         },
//       ),