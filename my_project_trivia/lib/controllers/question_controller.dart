//import 'dart:html';

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_project_trivia/models/samples.dart';
import 'package:my_project_trivia/screens/score/score_screen.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  Animation get animation => this._animation;
  late PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => this._pageController;

  // List<Question> _questions = sample_data
  //     .map(
  //       (question) => Question(
  //         id: question['id'],
  //         question: question['question'],
  //         options: question['options'],
  //         type: "",
  //         answer: question['answer_index'],
  //       ),
  //     )
  //     .toList();

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
          id: question['id'],
          question: question['question'],
          options: question['options'],
          type: "",
          answer: question['answer_index'],
        ),
      )
      .toList();

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  late int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  List<Question> get questions => this._questions;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextQuestion);

    _pageController = PageController();
    super.onInit();
  }

  @override
  void OnClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  Future<bool> checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    }
    _animationController.stop();
    update();

    return Future.delayed(
      Duration(seconds: 1),
      () {
        String? temp = nextQuestion();
        if (temp == "Done") {
          return true;
        } else {
          return false;
        }
      },
    );
  }

  String? nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
      _animationController.reset();

      _animationController.forward().whenComplete(nextQuestion);
    } else {
      return "Done";
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  void endGame() {
    //_questionNumber.value = 0;
    _questionNumber = 1.obs;
    _animationController.reset();
    _selectedAns = 0;
    _isAnswered = false;
    _numOfCorrectAns = 0;
  }

  // void clearScore() {
  //   _numOfCorrectAns = 0;
  // }
}
