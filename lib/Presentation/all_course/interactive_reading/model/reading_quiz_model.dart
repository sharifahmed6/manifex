class ReadingQuizData {
  final String passageName;
  final String text;
  final String image;
  final String age;
  final List<ReadingQuestion> questions;

  ReadingQuizData({
    required this.passageName,
    required this.text,
    required this.image,
    required this.age,
    required this.questions,
  });

  factory ReadingQuizData.fromJson(Map<String, dynamic> json) {
    return ReadingQuizData(
      passageName: (json["passage_name"] ?? "").toString(),
      text: (json["text"] ?? "").toString(),
      image: (json["image"] ?? "").toString(),
      age: (json["age"] ?? "").toString(),
      questions: (json["questions"] as List? ?? [])
          .map((e) => ReadingQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReadingQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;

  ReadingQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory ReadingQuestion.fromJson(Map<String, dynamic> json) {
    return ReadingQuestion(
      question: (json["question"] ?? "").toString(),
      options: List<String>.from(json["options"] ?? const []),
      correctAnswer: (json["correct_answer"] ?? "").toString(),
    );
  }

  int get correctIndex => options.indexOf(correctAnswer);
}
