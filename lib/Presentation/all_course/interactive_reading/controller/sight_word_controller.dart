
import 'package:get/get.dart';

import '../model/sight_word_model.dart';

class SightWordController extends GetxController {
  final words = <SentenceWord>[].obs;
  final targets = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFromApi();
  }

  void loadFromApi() {
    final sentence =
        "The cat sits on the mat. You can see it here in the room";
    final apiTargets = ["the", "on", "you", "it", "room"];

    targets.value = apiTargets.map((e) => e.toLowerCase()).toList();
    words.value = _tokenize(sentence);
  }

  List<SentenceWord> _tokenize(String sentence) {
    final parts = sentence.split(" ");
    int id = 0;
    return parts.map((p) {
      final clean = p.replaceAll(RegExp(r'[^a-zA-Z]'), '').toLowerCase();
      return SentenceWord(id: id++, text: p, clean: clean);
    }).toList();
  }

  // ✅ total target occurrences in the sentence
  int get totalTargetOccurrences {
    final set = targets.toSet();
    return words.where((w) => set.contains(w.clean)).length;
  }

  int get selectedCount =>
      words.where((w) => w.state != WordState.normal).length;

  int get foundOccurrences =>
      words.where((w) => w.state == WordState.correct).length;

  void onTapWord(SentenceWord w) {
    if (w.state != WordState.normal) return;
    if (selectedCount >= totalTargetOccurrences) return;

    if (targets.contains(w.clean)) {
      w.state = WordState.correct;
    } else {
      w.state = WordState.wrong;
    }

    words.refresh();
  }
}