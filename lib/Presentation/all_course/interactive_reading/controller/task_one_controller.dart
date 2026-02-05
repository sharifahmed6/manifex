import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TaskOneController extends GetxController {
  final FlutterTts tts = FlutterTts();

  final words = <String>['CAT', 'DOG', 'SUN'].obs;
  final wordIndex = 0.obs;

  final letters = <String>[].obs;
  final selected = <bool>[].obs;
  final selectedOrder = <int>[].obs;
  final typed = ''.obs;

  bool _ttsReady = false;

  String get currentWord => words[wordIndex.value];

  @override
  void onInit() {
    super.onInit();
    _setup();
  }

  Future<void> _setup() async {
    await _initTts();
    _loadWord(currentWord);
  }

  Future<void> _initTts() async {
    try {
      await tts.awaitSpeakCompletion(true);
      await tts.setLanguage('en-US');
      await tts.setSpeechRate(0.45);
      await tts.setPitch(1.0);
      await tts.setVolume(1.0);

      tts.setErrorHandler((msg) {
        print("TTS error: $msg");
      });

      _ttsReady = true;
    } catch (e) {
      _ttsReady = false;
      // ignore: avoid_print
      print("TTS init failed: $e");
    }
  }

  void _loadWord(String word) {
    letters.value = word.split('');
    selected.value = List<bool>.filled(letters.length, false);
    selectedOrder.clear();
    _rebuildTyped();
  }

  Future<void> toggleLetter(int index) async {
    if (index < 0 || index >= letters.length) return;

    final wasSelected = selected[index];

    if (!wasSelected) {
      selected[index] = true;
      selected.refresh();

      selectedOrder.add(index);
      _rebuildTyped();

      if (_ttsReady) {
        await tts.stop();
        await tts.speak(letters[index]);
      }
    } else {
      selected[index] = false;
      selected.refresh();

      selectedOrder.remove(index);
      _rebuildTyped();
    }
  }

  void _rebuildTyped() {
    typed.value = selectedOrder.map((i) => letters[i]).join();
  }


  @override
  void onClose() {
    tts.stop();
    super.onClose();
  }
}
