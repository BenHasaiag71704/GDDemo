import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/controllers/question_controller.dart';
import 'package:my_project_trivia/models/progress_bar.dart';
import 'package:my_project_trivia/models/question_card.dart';
import 'package:my_project_trivia/models/samples.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController =
        Get.put(QuestionController(context));
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ProgressBar(),
              ),
              Obx(
                () => Text.rich(
                  TextSpan(
                    text:
                        "Question ${_questionController.questionNumber.value}",
                    style: TextStyle(fontSize: 40),
                    children: [
                      TextSpan(
                        text: "/${_questionController.questions.length}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 1.5),
              SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    question: _questionController.questions[index],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
