class SightWordItem {
  final String word;
  final String audioUrl;
  final List<String> definition;
  final String sentence;
  final List<String> quiz;
  final String answer;

  SightWordItem({
    required this.word,
    required this.audioUrl,
    required this.definition,
    required this.sentence,
    required this.quiz,
    required this.answer,
  });

  factory SightWordItem.fromJson(Map<String, dynamic> json) {
    return SightWordItem(
      word: (json['word'] ?? '').toString(),
      audioUrl: (json['audio_url'] ?? '').toString(),
      definition: List<String>.from(json['definition'] ?? const []),
      sentence: (json['sentence'] ?? '').toString(),
      quiz: List<String>.from(json['quiz'] ?? const []),
      answer: (json['answer'] ?? '').toString(),
    );
  }

  // ✅ quiz-এর মধ্যে answer exact match থাকলে
  int get correctIndex => quiz.indexOf(answer);

  // ✅ যদি quiz-এ "_____" থাকে আর answer এ word থাকে, তখনও match করাবে
  int correctIndexSafe() {
    final direct = correctIndex;
    if (direct != -1) return direct;

    // normalize: underscore/extra spaces ignore
    String norm(String s) => s
        .replaceAll(RegExp(r'_{2,}'), ' ') // _____ -> space
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toLowerCase();

    final ans = norm(answer);
    for (int i = 0; i < quiz.length; i++) {
      final q = norm(quiz[i]);
      // quiz-এর blank জায়গায় word বসিয়ে compare করার চেষ্টা (simple heuristic)
      final filled = norm(quiz[i].replaceAll(RegExp(r'_{2,}'), word));
      if (q == ans || filled == ans) return i;
    }
    return -1;
  }
}
