class UserQuestionAnswer {
  String uid;
  String qid;
  DateTime ansTime;
  bool isCorrect;

  UserQuestionAnswer(
      {required this.uid,
      required this.qid,
      required this.ansTime,
      required this.isCorrect});
}
