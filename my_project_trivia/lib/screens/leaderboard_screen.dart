import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatefulWidget {
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("leaderboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Text("hello")],
        ),
      ),
    );
  }
}
