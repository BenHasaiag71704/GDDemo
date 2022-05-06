// ignore_for_file: prefer_const_constructors

import 'dart:io';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
              return Container(
                width: constraint.maxWidth * 0.5,
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
                  Text("${(60 - (0.5 * 60).round())}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
