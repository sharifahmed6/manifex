import 'dart:math';
import 'package:get/get.dart';

enum DropState { empty, correct, wrong }

class TaskThreeController extends GetxController {
  final words = <WordItem>[].obs;
  final slots = <PictureSlot>[].obs;

  // ✅ strongly typed RxMap/RxSet
  final RxMap<String, String> placedBySlotId = <String, String>{}.obs;
  final RxMap<String, DropState> stateBySlotId = <String, DropState>{}.obs;
  final RxSet<String> usedWordKeys = <String>{}.obs;

  void loadFromApi(List<ApiPair> pairs) {
    final rnd = Random();

    final w = pairs
        .map((p) => WordItem(key: p.answerKey, text: p.word))
        .toList()
      ..shuffle(rnd);

    final s = pairs
        .map((p) => PictureSlot(
      slotId: _uid(),
      imageUrlOrAsset: p.image,
      correctWordKey: p.answerKey,
    ))
        .toList()
      ..shuffle(rnd);

    words.assignAll(w);
    slots.assignAll(s);

    placedBySlotId.clear();
    usedWordKeys.clear();
    stateBySlotId.clear();

    for (final sl in s) {
      stateBySlotId[sl.slotId] = DropState.empty;
    }

    // ✅ force notify after bulk set
    placedBySlotId.refresh();
    usedWordKeys.refresh();
    stateBySlotId.refresh();
  }

  bool isWordUsed(String wordKey) => usedWordKeys.contains(wordKey);
  bool isSlotFilled(String slotId) => placedBySlotId.containsKey(slotId);

  String wordTextByKey(String key) => words.firstWhere((w) => w.key == key).text;
  DropState slotState(String slotId) => stateBySlotId[slotId] ?? DropState.empty;

  bool canAccept({required String slotId, required String wordKey}) {
    if (isSlotFilled(slotId)) return false; // slot one-time
    if (isWordUsed(wordKey)) return false;  // word one-time
    return true;
  }

  DropState drop({required String slotId, required String wordKey}) {
    if (!canAccept(slotId: slotId, wordKey: wordKey)) {
      return slotState(slotId);
    }

    final slot = slots.firstWhere((s) => s.slotId == slotId);
    final ok = slot.correctWordKey == wordKey;

    placedBySlotId[slotId] = wordKey;
    usedWordKeys.add(wordKey);

    final state = ok ? DropState.correct : DropState.wrong;
    stateBySlotId[slotId] = state;

    // ✅ VERY IMPORTANT: refresh all reactive collections
    placedBySlotId.refresh();
    usedWordKeys.refresh();
    stateBySlotId.refresh();

    return state;
  }

  bool get allCorrect =>
      slots.isNotEmpty &&
          slots.every((s) => stateBySlotId[s.slotId] == DropState.correct);

  bool get allFilled =>
      slots.isNotEmpty && slots.every((s) => placedBySlotId.containsKey(s.slotId));

  void resetAll() {
    placedBySlotId.clear();
    usedWordKeys.clear();
    stateBySlotId.clear();

    for (final sl in slots) {
      stateBySlotId[sl.slotId] = DropState.empty;
    }

    placedBySlotId.refresh();
    usedWordKeys.refresh();
    stateBySlotId.refresh();
  }

  String _uid() => DateTime.now().microsecondsSinceEpoch.toString();
}

class ApiPair {
  final String word;
  final String image;
  final String answerKey;
  const ApiPair({required this.word, required this.image, required this.answerKey});
}

class WordItem {
  final String key;
  final String text;
  const WordItem({required this.key, required this.text});
}

class PictureSlot {
  final String slotId;
  final String imageUrlOrAsset;
  final String correctWordKey;
  const PictureSlot({
    required this.slotId,
    required this.imageUrlOrAsset,
    required this.correctWordKey,
  });
}
