class ExerciseModel {
  final String word;
  final String wordUrl;
  final List<String> options;

  ExerciseModel({
    required this.word,
    required this.wordUrl,
    required this.options,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      word: json['word'],
      wordUrl: json['word_url'],
      options: List<String>.from(json['options']),
    );
  }
}
