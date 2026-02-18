class SentenceModel {
  final String phrase;
  final List<String> phraseOptions;

  SentenceModel({required this.phrase, required this.phraseOptions});

  factory SentenceModel.fromJson(Map<String, dynamic> json) {
    return SentenceModel(
      phrase: json['phrase'] as String,
      phraseOptions: List<String>.from(json['phrase_options']),
    );
  }
}