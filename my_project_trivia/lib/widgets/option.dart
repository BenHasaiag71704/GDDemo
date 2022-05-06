import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_project_trivia/providers/questions.dart';
import 'package:provider/provider.dart';
import 'package:my_project_trivia/models/user_question_answer.dart';

class Option extends StatefulWidget {
  const Option({
    Key? key,
    this.optionNum,
  }) : super(key: key);

  final int? optionNum;
  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  int? selectedOption;

  Color getTheRightColor() {
    if (selectedOption != null) {
      if (Provider.of<Questions>(context).getCurrentQuestion().answer ==
          selectedOption) {
        return Colors.green;
      } else if (Provider.of<Questions>(context).getCurrentQuestion().answer !=
          selectedOption) {
        return Colors.red;
      } else {
        return Colors.black;
      }
    } else {
      return Colors.black;
    }
  }

  IconData getTheRightIcon() {
    return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
  }

  @override
  Widget build(BuildContext context) {
    var questionList = Provider.of<Questions>(context).getTheList;
    return selectedOption == null
        ? GestureDetector(
            onTap: () {
              setState(() {
                selectedOption = widget.optionNum;
              });
            },
            child: optionContainer(context),
          )
        : optionContainer(context);
  }

  Container optionContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border.all(
          color: getTheRightColor(),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${widget.optionNum! + 1}. ${Provider.of<Questions>(context).getCurrentQuestion().options[widget.optionNum!]}",
            style: TextStyle(
              fontSize: 15,
              color: getTheRightColor(),
            ),
          ),
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: getTheRightColor() == Colors.black
                  ? Colors.transparent
                  : getTheRightColor(),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: getTheRightColor(),
              ),
            ),
            child: getTheRightColor() == Colors.black
                ? null
                : Icon(getTheRightIcon()),
          ),
        ],
      ),
    );
  }
}
