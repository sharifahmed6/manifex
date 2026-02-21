class PhraseModel {
  final String phrase;
  final List<String> phraseOptions;

  PhraseModel({
    required this.phrase,
    required this.phraseOptions,
  });

  factory PhraseModel.fromJson(Map<String, dynamic> json) {
    return PhraseModel(
      phrase: json['phrase'] ?? '',
      phraseOptions: List<String>.from(json['phrase_options'] ?? []),
    );
  }
}
