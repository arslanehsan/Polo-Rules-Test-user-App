class QuestionObject {
  String? id, question;
  String? correctAnswer;
  String? questionCategory;
  String? ansA, ansB, ansC, ansD;

  QuestionObject({
    this.id,
    required this.question,
    this.correctAnswer,
    this.questionCategory,
    this.ansA,
    this.ansB,
    this.ansC,
    this.ansD,
  });

  factory QuestionObject.fromJson(Map<dynamic, dynamic> json) {
    print('QuestionObject DATA GETTING $json');
    return QuestionObject(
      id: json['id'],
      question: json['question'] ?? '',
      correctAnswer: json['correctAnswer'] ?? '',
      questionCategory: json['questionCategory'] ?? '',
      ansA: json['ansA'] ?? '',
      ansB: json['ansB'] ?? '',
      ansC: json['ansC'] ?? '',
      ansD: json['ansD'] ?? '',
    );
  }

  Map<String, dynamic> toJson({required String questionId}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = questionId;
    data['question'] = question;
    data['correctAnswer'] = correctAnswer;
    data['questionCategory'] = questionCategory;
    data['ansA'] = ansA;
    data['ansB'] = ansB;
    data['ansC'] = ansC;
    data['ansD'] = ansD;

    return data;
  }
}
