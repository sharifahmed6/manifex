import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'native_speaking_skill_controller.dart';

class NativeTaskFourController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  final homeController = Get.find<HomeController>();
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speechToText = stt.SpeechToText();

  // UI states
  final isLoading = false.obs;
  final isListening = false.obs;

  // All fetched words
  final allWords = <String>[].obs;

  // Current 4 displayed words (indices into allWords)
  final displayedWords = <String>[].obs;

  // Per-word check state: index -> true/false (matched or not)
  final wordCheckState = <int, bool>{}.obs;

  // Is main mic actively listening
  final isSpeaking = false.obs; // TTS playing indicator

  // Words target score (out of 100, split into 4 slots = 25 each)
  final wordsTarget = 0.obs; // e.g. 20 out of 100
  final maxTarget = 100;

  // Speech recognition
  final speechAvailable = false.obs;

  // Auto-stop timer — fires after 4 s of silence
  Timer? _silenceTimer;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
    fetchVocabulary();
    initTts();
  }

  @override
  void onClose() {
    _silenceTimer?.cancel();
    flutterTts.stop();
    speechToText.stop();
    super.onClose();
  }

  /// Initialize TTS
  Future<void> initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  /// Initialize Speech Recognition
  Future<void> initSpeech() async {
    try {
      speechAvailable.value = await speechToText.initialize(
        onError: (error) {
          print('Speech recognition error: $error');
          _silenceTimer?.cancel();
          isListening.value = false;

          final errorMsg = error.errorMsg;

          if (errorMsg.contains('error_no_match') ||
              errorMsg.contains('no_match')) {
            Get.snackbar(
              "Couldn't hear you".tr,
              "No word matched. Please try again clearly.".tr,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.orange.withAlpha(220),
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );
          } else if (errorMsg.contains('error_speech_timeout') ||
              errorMsg.contains('speech_timeout')) {
            // Silence timeout — no snackbar needed, mic just turned off
          } else if (error.permanent) {
            Get.snackbar(
              'Mic Error'.tr,
              'Speech recognition failed. Please try again.'.tr,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.withAlpha(200),
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );
          }
        },
        onStatus: (status) {
          print('Speech recognition status: $status');
          // Fallback: engine finished on its own
          if (status == 'done' || status == 'notListening') {
            _silenceTimer?.cancel();
            isListening.value = false;
          }
        },
      );

      if (!speechAvailable.value) {
        Get.snackbar(
          'Not Available'.tr,
          'Speech recognition is not available on this device'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange.withAlpha(200),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Speech init error: $e');
      speechAvailable.value = false;
    }
  }

  /// Fetch vocabulary words from API
  Future<void> fetchVocabulary() async {
    try {
      isLoading.value = true;

      final response = await networkCaller.getRequest(
        url: urls.getVocabularyChallenge(
          homeController.userId,
          homeController.apiAge.toString(),
        ),
        removeAuthorization: true,
        extraHeaders: {"authtoken": "1"},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!;
        List<dynamic>? wordsList;

        if (data.containsKey('words')) {
          wordsList = data['words'];
        } else if (data.containsKey('vocabulary')) {
          wordsList = data['vocabulary'];
        } else if (data.containsKey('data')) {
          final dataField = data['data'];
          if (dataField is List) {
            wordsList = dataField;
          } else if (dataField is Map && dataField.containsKey('words')) {
            wordsList = dataField['words'];
          }
        } else if (data is List) {
          wordsList = data as List<dynamic>;
        }

        if (wordsList != null && wordsList.isNotEmpty) {
          allWords.assignAll(
            wordsList.map((e) {
              if (e is Map) {
                return (e['word'] ?? e['name'] ?? e.values.first).toString();
              }
              return e.toString();
            }).toList(),
          );
          _pickFourWords();
        } else {
          Get.snackbar(
            'No Words'.tr,
            'No vocabulary data found'.tr,
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        Get.snackbar(
          'Error'.tr,
          response.errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withAlpha(200),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error fetching vocabulary: $e');
      Get.snackbar(
        'Error'.tr,
        'Failed to load vocabulary'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Pick 4 words from allWords randomly and reset check states
  void _pickFourWords() {
    if (allWords.isEmpty) return;
    final shuffled = List<String>.from(allWords)..shuffle(Random());
    displayedWords.assignAll(shuffled.take(4).toList());
    wordCheckState.clear();
  }

  /// Shuffle / reset: pick new 4 words
  void shuffleWords() {
    if (allWords.isEmpty) return;
    _stopListening();
    _pickFourWords();
  }

  /// Play a word via TTS when user taps the word card
  Future<void> playWord(int wordIndex) async {
    if (wordIndex >= displayedWords.length) return;
    try {
      isSpeaking.value = true;
      await flutterTts.speak(displayedWords[wordIndex]);
      isSpeaking.value = false;
    } catch (e) {
      isSpeaking.value = false;
      print('TTS error: $e');
    }
  }

  /// Main mic button — listens and checks which of the 4 words
  /// the user said, then marks that word with a check icon.
  Future<void> toggleListeningAll() async {
    if (isListening.value) {
      _stopListening();
      return;
    }

    if (!speechAvailable.value) {
      Get.snackbar(
        'Not Available'.tr,
        'Speech recognition is not available'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.withAlpha(200),
        colorText: Colors.white,
      );
      return;
    }

    try {
      isListening.value = true;

      // Start the 4-second silence timer
      _resetSilenceTimer();

      await speechToText.listen(
        onResult: (result) {
          if (result.recognizedWords.isNotEmpty) {
            // User is speaking — reset the silence countdown
            _resetSilenceTimer();
          }
          if (result.finalResult) {
            final recognized = result.recognizedWords.trim().toLowerCase();
            _matchAgainstAllWords(recognized);
            _stopListening();
          }
        },
        listenFor: const Duration(minutes: 5),
        pauseFor: const Duration(seconds: 4),
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
        ),
      );
    } catch (e) {
      print('Listening error: $e');
      _stopListening();
      Get.snackbar(
        'Error'.tr,
        'Failed to start speech recognition'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    }
  }

  /// Restart the 4-second silence auto-stop timer
  void _resetSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer(const Duration(seconds: 4), _stopListening);
  }

  /// Compare recognized text against all 4 displayed words;
  /// mark the best-matching one as checked.
  void _matchAgainstAllWords(String recognized) {
    if (displayedWords.isEmpty) return;

    int bestIndex = -1;
    // Try exact / contains match first
    for (int i = 0; i < displayedWords.length; i++) {
      final target = displayedWords[i].trim().toLowerCase();
      final words = recognized.split(' ');
      if (words.any((w) => w == target) ||
          recognized == target ||
          _isSimilar(recognized, target)) {
        bestIndex = i;
        break;
      }
    }

    if (bestIndex != -1) {
      wordCheckState[bestIndex] = true;
      wordCheckState.refresh();
      _updateScore();
    }
  }

  void _stopListening() {
    _silenceTimer?.cancel();
    speechToText.stop();
    isListening.value = false;
  }

  /// Loose match — covers slight mispronunciations
  bool _isSimilar(String recognized, String target) {
    if (recognized.contains(target)) return true;
    if (target.contains(recognized) && recognized.length >= 3) return true;

    // Levenshtein distance <= 1 for short words
    if (target.length <= 5) {
      return _levenshtein(recognized, target) <= 1;
    }
    return _levenshtein(recognized, target) <= 2;
  }

  int _levenshtein(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    List<int> prev = List.generate(b.length + 1, (i) => i);
    for (int i = 0; i < a.length; i++) {
      List<int> curr = [i + 1];
      for (int j = 0; j < b.length; j++) {
        int cost = a[i] == b[j] ? 0 : 1;
        curr.add([curr[j] + 1, prev[j + 1] + 1, prev[j] + cost].reduce(min));
      }
      prev = curr;
    }
    return prev[b.length];
  }

  /// Update score: each matched word contributes 25 points (4 words = 100)
  void _updateScore() {
    final matchedCount = wordCheckState.values.where((v) => v == true).length;
    final score = matchedCount * 25; // 25 points per word, max 100
    wordsTarget.value = score;

    try {
      final parentController = Get.find<NativeSpeakingSkillController>();
      parentController.taskFourScore.value = score;
      parentController.score.value = score;
    } catch (e) {
      print('Parent controller not found: $e');
    }
  }
}
