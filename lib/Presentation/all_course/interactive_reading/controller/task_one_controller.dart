import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';
import '../../../../App/network_caller.dart';
import '../model/flashcards_model.dart';
import 'interactive_reading_controller.dart';

class TaskOneController extends GetxController {
  final interactiveController = Get.find<InteractiveReadingController>();
  final homeController = Get.find<HomeController>();
  final FlutterTts tts = FlutterTts();
  final NetworkCaller _network = NetworkCaller();

  // API state
  final isLoading = false.obs;
  final error = ''.obs;
  final totalMarks = ''.obs;
  // API model
  final data = Rxn<FlashCardModel>();

  // Letters
  final originalLetters = <String>[].obs;
  final shuffledLetters = <String>[].obs;

  // Selection
  final selected = <bool>[].obs;
  final selectedOrder = <int>[].obs;
  final typed = ''.obs;

  // Result
  final isSubmitted = false.obs;
  final isPerfect = false.obs;
  final resultLabel = ''.obs;

  bool _ttsReady = false;

  String get correctWord => data.value?.word ?? '';
  bool get canSubmit => !isSubmitted.value && typed.value.isNotEmpty;
  bool get canReset => !isSubmitted.value;

  @override
  void onInit() {
    super.onInit();
    _setup();
  }

  Future<void> _setup() async {
    await _initTts();
    await fetchWord();
  }

  Future<void> fetchWord() async {
    isLoading.value = true;
    error.value = '';

    try {
      final res = await _network.getRequest(
        url: urls.phonemeFlashcard(
          homeController.apiAge.toString(),
          homeController.userId,
        ),
        removeAuthorization: true,
        extraHeaders: const {"authtoken": "1"},
      );

      if (!res.isSuccess) {
        error.value = res.errorMessage;
        return;
      }

      final model = FlashCardModel.fromJson(res.responseData);

      if (!model.isValid) {
        error.value = "Invalid data from API".tr;
        return;
      }

      data.value = model;

      _loadFromModel(model);

      // new word => reset result
      isSubmitted.value = false;
      isPerfect.value = false;
      resultLabel.value = '';
    } catch (_) {
      error.value = "Something went wrong".tr;
    } finally {
      isLoading.value = false;
    }
  }

  void _loadFromModel(FlashCardModel model) {
    final correctChars = model.characters.isNotEmpty
        ? model.characters
        : model.word.split('');

    originalLetters.value = List<String>.from(correctChars);

    // shuffled copy for UI
    final temp = List<String>.from(correctChars);
    temp.shuffle();

    // avoid same order (best effort)
    if (_listEquals(temp, correctChars) && temp.length > 1) {
      temp.shuffle();
    }

    shuffledLetters.value = temp;

    // reset selection based on shuffled length
    selected.value = List<bool>.filled(shuffledLetters.length, false);
    selectedOrder.clear();
    typed.value = '';
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Future<void> _initTts() async {
    try {
      await tts.awaitSpeakCompletion(true);
      await tts.setLanguage('en-US');
      await tts.setSpeechRate(0.45);
      await tts.setPitch(1.0);
      await tts.setVolume(1.0);

      tts.setErrorHandler((msg) {
        // ignore: avoid_print
        print("TTS error: $msg");
      });

      _ttsReady = true;
    } catch (e) {
      _ttsReady = false;
      // ignore: avoid_print
      print("TTS init failed: $e");
    }
  }

  Future<void> toggleLetter(int index) async {
    if (index < 0 || index >= shuffledLetters.length) return;
    if (isSubmitted.value) return;
    if (selected[index]) return;

    selected[index] = true;
    selected.refresh();

    selectedOrder.add(index);
    typed.value = selectedOrder.map((i) => shuffledLetters[i]).join();

    if (_ttsReady) {
      await tts.stop();
      await tts.speak(shuffledLetters[index]);
    }
  }

  void resetSelection() {
    if (!canReset) return;

    selected.value = List<bool>.filled(shuffledLetters.length, false);
    selectedOrder.clear();
    typed.value = '';

    // result not submitted yet => clear label
    isPerfect.value = false;
    resultLabel.value = '';
  }

  void submit() {
    if (!canSubmit) return;

    final answer = typed.value.trim().toUpperCase();
    final correct = correctWord.trim().toUpperCase();

    isSubmitted.value = true;

    if (answer == correct && correct.isNotEmpty) {
      isPerfect.value = true;
      interactiveController.task1.value = 100;
      resultLabel.value =
          "Perfect! Go to Next Challenge (".tr +
          "${interactiveController.task1.value}/100)";
    } else {
      isPerfect.value = false;
      interactiveController.task1.value = 0;
      resultLabel.value =
          "The correct word was: ".tr +
          "$correct (${interactiveController.task1.value}/100)";
    }
  }

  @override
  void onClose() {
    tts.stop();
    super.onClose();
  }
}
