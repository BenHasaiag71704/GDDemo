class UserQuestionAnswer {
  String uid;
  String qid;
  String type;
  DateTime ansTime;
  bool isCorrect;

  UserQuestionAnswer(
      {required this.uid,
      required this.qid,
      required this.type,
      required this.ansTime,
      required this.isCorrect});
}
