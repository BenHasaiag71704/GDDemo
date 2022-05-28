// ignore_for_file: prefer_const_constructors

//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  int x = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Questions>(context, listen: false).timerResert == true) {
      x = 0;
      Provider.of<Questions>(context, listen: false).startTimerAgain();
    }
    while (x < 60) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          x = x + 1;
        });
      });
      return Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraint) {
                return Container(
                  width: constraint.maxWidth * x * (1 / 6) * 0.1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.red, Colors.green],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
              },
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text("${(60 - (x).round())}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
              return Container(
                width: constraint.maxWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.red, Colors.green],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              );
            },
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text("select an answer and keep going!"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
