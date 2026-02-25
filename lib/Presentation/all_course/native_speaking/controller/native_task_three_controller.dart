import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'native_speaking_skill_controller.dart';

class NativeTaskThreeController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  final homeController = Get.find<HomeController>();
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speechToText = stt.SpeechToText();

  // UI states
  final isLoading = false.obs;
  final isListening = false.obs;
  final showFeedback = false.obs;
  final isSuccess = false.obs;
  final isSpeaking = false.obs;

  // Data
  final sentences = <String>[].obs;
  final currentIndex = 0.obs;
  final currentSentence = ''.obs;
  final feedbackMessage = ''.obs;
  final fluencyScore = 0.0.obs; // 0.0 to 1.0

  // Speech recognition
  final speechAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
    fetchListenSpeak();
    initTts();
  }

  @override
  void onClose() {
    flutterTts.stop();
    speechToText.stop();
    super.onClose();
  }

  /// Initialize Text-to-Speech
  Future<void> initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    flutterTts.setStartHandler(() => isSpeaking.value = true);
    flutterTts.setCompletionHandler(() => isSpeaking.value = false);
    flutterTts.setCancelHandler(() => isSpeaking.value = false);
  }

  /// Initialize Speech Recognition
  Future<void> initSpeech() async {
    try {
      speechAvailable.value = await speechToText.initialize(
        onError: (error) {
          print('Speech recognition error: $error');
          isListening.value = false;
        },
        onStatus: (status) {
          print('Speech recognition status: $status');
          if (status == 'done' || status == 'notListening') {
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

  /// Fetch listen-speak sentences from API
  Future<void> fetchListenSpeak() async {
    try {
      isLoading.value = true;

      final response = await networkCaller.getRequest(
        url: urls.getListenSpeak(
          homeController.userId,
          homeController.apiAge.toString(),
        ),
        removeAuthorization: true,
        extraHeaders: {"authtoken": "1"},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!;

        List<dynamic>? list;

        if (data.containsKey('sentences')) {
          list = data['sentences'];
        } else if (data.containsKey('phrases')) {
          list = data['phrases'];
        } else if (data.containsKey('words')) {
          list = data['words'];
        } else if (data.containsKey('data')) {
          final dataField = data['data'];
          if (dataField is List) {
            list = dataField;
          } else if (dataField is Map && dataField.containsKey('sentences')) {
            list = dataField['sentences'];
          }
        } else if (data is List) {
          list = data as List<dynamic>;
        }

        if (list != null && list.isNotEmpty) {
          sentences.assignAll(list.map((e) => e.toString()).toList());
          currentIndex.value = 0;
          currentSentence.value = sentences[0];
        } else {
          Get.snackbar(
            'No Data'.tr,
            'No listen-speak data found'.tr,
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
      print('Error fetching listen-speak: $e');
      Get.snackbar(
        'Error'.tr,
        'Failed to load sentences'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Play sentence at normal speed (Listen button)
  Future<void> playSentence() async {
    if (currentSentence.value.isEmpty) return;
    try {
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(currentSentence.value);
    } catch (e) {
      print('TTS error: $e');
    }
  }

  /// Play sentence at slow speed (Slow button)
  Future<void> playSentenceSlow() async {
    if (currentSentence.value.isEmpty) return;
    try {
      await flutterTts.setSpeechRate(0.25);
      await flutterTts.speak(currentSentence.value);
    } catch (e) {
      print('TTS slow error: $e');
    }
  }

  /// Toggle microphone — start if off, stop if on
  Future<void> toggleListening() async {
    if (isListening.value) {
      await speechToText.stop();
      isListening.value = false;
      return;
    }
    await startListening();
  }

  /// Start listening to user speech
  Future<void> startListening() async {
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
      showFeedback.value = false;

      await speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            final recognized = result.recognizedWords.trim().toLowerCase();
            final target = currentSentence.value.trim().toLowerCase();
            final confidence = result.confidence > 0 ? result.confidence : 1.0;

            checkPronunciation(recognized, target, confidence);
            speechToText.stop();
            isListening.value = false;
          }
        },
        listenFor: const Duration(minutes: 3),
        pauseFor: const Duration(seconds: 4),
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
        ),
      );
    } catch (e) {
      print('Listening error: $e');
      isListening.value = false;
      Get.snackbar(
        'Error'.tr,
        'Failed to start speech recognition'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    }
  }

  /// Calculate word-overlap similarity (0.0 to 1.0)
  double _calculateSimilarity(String recognized, String target) {
    if (target.isEmpty) return 0.0;
    if (recognized.isEmpty) return 0.0;

    final targetWords = target.split(' ');
    final recognizedWords = recognized.split(' ');

    int matchCount = 0;
    final recognizedCopy = List<String>.from(recognizedWords);

    for (final word in targetWords) {
      final idx = recognizedCopy.indexOf(word);
      if (idx != -1) {
        matchCount++;
        recognizedCopy.removeAt(idx);
      }
    }

    return matchCount / targetWords.length;
  }

  /// Check pronunciation and compute fluency score
  void checkPronunciation(
    String recognized,
    String target, [
    double confidence = 1.0,
  ]) {
    final wordSimilarity = _calculateSimilarity(recognized, target);

    // Combined: 60% word accuracy + 40% speech clarity
    final combined = (wordSimilarity * 0.6) + (confidence * 0.4);
    final isMatch = combined >= 0.75;

    fluencyScore.value = combined.clamp(0.0, 1.0);

    try {
      final parentController = Get.find<NativeSpeakingSkillController>();
      parentController.score.value = (combined * 100).round();
    } catch (e) {
      print('Parent controller not found: $e');
    }

    isSuccess.value = isMatch;

    if (isMatch) {
      feedbackMessage.value = 'Perfect! Great Pronunciation!'.tr;
    } else {
      feedbackMessage.value = 'Try again! You said: '.tr + '"$recognized"';
    }

    showFeedback.value = true;
  }

  /// Load next sentence (refresh button)
  void loadNextSentence() {
    if (sentences.isEmpty) return;

    showFeedback.value = false;
    isSuccess.value = false;
    fluencyScore.value = 0.0;

    currentIndex.value = (currentIndex.value + 1) % sentences.length;
    currentSentence.value = sentences[currentIndex.value];
  }
}
