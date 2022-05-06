class Question {
  final int answer;
  final String question, type, id;
  final List<dynamic> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.type,
      required this.options});
}
