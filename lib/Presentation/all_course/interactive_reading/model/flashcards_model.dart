class FlashCardModel {
  final String word;
  final List<String> characters;

  FlashCardModel({
    required this.word,
    required this.characters,
  });

  factory FlashCardModel.fromJson(Map<String, dynamic>? json) {
    return FlashCardModel(
      word: json?['word']?.toString() ?? '',
      characters: (json?['characters'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          <String>[],
    );
  }

  bool get isValid => word.isNotEmpty && characters.isNotEmpty;
}
