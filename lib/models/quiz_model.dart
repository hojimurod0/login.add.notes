class Quiz {
  int qCorrectAnswer;
  int qId;
  List<String> qOptions;
  String qQuestion;

  Quiz({
    required this.qCorrectAnswer,
    required this.qId,
    required this.qOptions,
    required this.qQuestion,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      qCorrectAnswer: json['q-correctAnswer'],
      qId: json['q-id'],
      qOptions: List<String>.from(json['q-options']),
      qQuestion: json['q-question'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'q-correctAnswer': qCorrectAnswer,
      'q-id': qId,
      'q-options': qOptions,
      'q-question': qQuestion,
    };
  }
}
