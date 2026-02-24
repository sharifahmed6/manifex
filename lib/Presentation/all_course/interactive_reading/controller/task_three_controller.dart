import 'dart:math';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import '../../../../App/network_caller.dart';
import '../../../Features/home/controller/home_controller.dart';
import '../model/word_match_response.dart';
import 'interactive_reading_controller.dart';

enum DropState { empty, correct, wrong }

class TaskThreeController extends GetxController {
  final interactiveController = Get.find<InteractiveReadingController>();
  final NetworkCaller networkCaller = NetworkCaller();

  final isLoading = false.obs;
  final error = ''.obs;
  final sessionName = ''.obs;

  final words = <WordItemUI>[].obs;
  final slots = <PictureSlot>[].obs;

  final RxMap<String, String> placedBySlotId = <String, String>{}.obs;
  final RxMap<String, DropState> stateBySlotId = <String, DropState>{}.obs;
  final RxSet<String> usedWordKeys = <String>{}.obs;

  final correctCount = 0.obs;
  final percent = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    loadFromServer();
  }

  Future<void> loadFromServer() async {
    try {
      isLoading.value = true;
      error.value = '';

      final res = await networkCaller.getRequest(url: urls.match_word);

      if (!res.isSuccess || res.responseData == null) {
        error.value = res.errorMessage;
        return;
      }

      final parsed = WordMatchResponse.fromJson(res.responseData!);

      sessionName.value = parsed.data.sessionName;

      final pairs = parsed.data.words
          .map((w) {
            final img = parsed.data.imageUrlById(w.id) ?? "";
            return ApiPair(word: w.text, image: img, answerKey: w.id);
          })
          .where((p) => p.image.isNotEmpty)
          .toList();

      loadFromApi(pairs);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void loadFromApi(List<ApiPair> pairs) {
    final rnd = Random();

    final w =
        pairs.map((p) => WordItemUI(key: p.answerKey, text: p.word)).toList()
          ..shuffle(rnd);

    final s =
        pairs
            .map(
              (p) => PictureSlot(
                slotId: _uid(),
                imageUrlOrAsset: p.image,
                correctWordKey: p.answerKey,
              ),
            )
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

    correctCount.value = 0;
    percent.value = 0;

    placedBySlotId.refresh();
    usedWordKeys.refresh();
    stateBySlotId.refresh();
  }

  bool isWordUsed(String wordKey) => usedWordKeys.contains(wordKey);
  bool isSlotFilled(String slotId) => placedBySlotId.containsKey(slotId);
  DropState slotState(String slotId) =>
      stateBySlotId[slotId] ?? DropState.empty;

  bool canAccept({required String slotId, required String wordKey}) {
    if (isSlotFilled(slotId)) return false;
    if (isWordUsed(wordKey)) return false;
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

    placedBySlotId.refresh();
    usedWordKeys.refresh();
    stateBySlotId.refresh();

    _recalculateScore();
    return state;
  }

  void _recalculateScore() {
    int correct = 0;
    for (final sl in slots) {
      if (stateBySlotId[sl.slotId] == DropState.correct) correct++;
    }
    correctCount.value = correct;

    final total = slots.length;
    percent.value = total == 0 ? 0 : (correct / total) * 100;
  }

  bool get allFilled =>
      slots.isNotEmpty &&
      slots.every((s) => placedBySlotId.containsKey(s.slotId));

  bool get allCorrect =>
      slots.isNotEmpty &&
      slots.every((s) => stateBySlotId[s.slotId] == DropState.correct);

  int get totalSlots => slots.length;

  void finish() {
    if (!allFilled) return;
    interactiveController.task3.value = percent.value;
    Get.back();
  }

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

    _recalculateScore();
  }

  String _uid() => DateTime.now().microsecondsSinceEpoch.toString();
}

// ✅ UI helpers
class ApiPair {
  final String word;
  final String image;
  final String answerKey; // id
  const ApiPair({
    required this.word,
    required this.image,
    required this.answerKey,
  });
}

class WordItemUI {
  final String key; // id
  final String text;
  const WordItemUI({required this.key, required this.text});
}

class PictureSlot {
  final String slotId;
  final String imageUrlOrAsset;
  final String correctWordKey; // id
  const PictureSlot({
    required this.slotId,
    required this.imageUrlOrAsset,
    required this.correctWordKey,
  });
}
