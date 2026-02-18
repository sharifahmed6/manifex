import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'native_speaking_skill_controller.dart';

class NativeTaskTwoController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  final homeController = Get.find<HomeController>();
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speechToText = stt.SpeechToText();

  // UI states
  final isLoading = false.obs;
  final isListening = false.obs;
  final showFeedback = false.obs;
  final isSuccess = false.obs;

  // Data
  final phrases = <String>[].obs;
  final currentPhraseIndex = 0.obs;
  final currentWord = ''.obs;
  final feedbackMessage = ''.obs;

  // Speech recognition
  final speechAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
    fetchPhraseRepeat();
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
  }

  /// Initialize Speech Recognition
  Future<void> initSpeech() async {
    try {
      speechAvailable.value = await speechToText.initialize(
        onError: (error) {
          print('Speech recognition error: $error');
          // Silently turn off mic on any error (e.g. timeout, no speech)
          isListening.value = false;
        },
        onStatus: (status) {
          print('Speech recognition status: $status');
          // Auto off when speech recognition stops on its own
          if (status == 'done' || status == 'notListening') {
            isListening.value = false;
          }
        },
      );

      if (!speechAvailable.value) {
        Get.snackbar(
          'Not Available',
          'Speech recognition is not available on this device',
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

  /// Fetch phrase repeat data from API
  Future<void> fetchPhraseRepeat() async {
    try {
      isLoading.value = true;

      final response = await networkCaller.getRequest(
        url: urls.getPhraseRepeat(
          homeController.userId,
          homeController.apiAge.toString(),
        ),
        removeAuthorization: true,
        extraHeaders: {"authtoken": "1"},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!;

        // Try different possible response structures
        List<dynamic>? phrasesList;

        if (data.containsKey('phrases')) {
          phrasesList = data['phrases'];
        } else if (data.containsKey('words')) {
          phrasesList = data['words'];
        } else if (data.containsKey('data')) {
          final dataField = data['data'];
          if (dataField is List) {
            phrasesList = dataField;
          } else if (dataField is Map && dataField.containsKey('phrases')) {
            phrasesList = dataField['phrases'];
          }
        } else if (data is List) {
          phrasesList = data as List<dynamic>;
        }

        if (phrasesList != null && phrasesList.isNotEmpty) {
          phrases.assignAll(phrasesList.map((e) => e.toString()).toList());
          currentPhraseIndex.value = 0;
          currentWord.value = phrases[0];
        } else {
          Get.snackbar(
            'No Phrases',
            'No phrase repeat data found',
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withAlpha(200),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error fetching phrases: $e');
      Get.snackbar(
        'Error',
        'Failed to load phrases',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Play phrase using TTS (headphone button)
  Future<void> playWordPronunciation() async {
    if (currentWord.value.isEmpty) return;

    try {
      await flutterTts.speak(currentWord.value);
    } catch (e) {
      print('TTS error: $e');
      Get.snackbar(
        'Error',
        'Failed to play pronunciation',
        snackPosition: SnackPosition.TOP,
      );
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

  /// Start listening to user speech (microphone button)
  Future<void> startListening() async {
    if (!speechAvailable.value) {
      Get.snackbar(
        'Not Available',
        'Speech recognition is not available',
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
            final recognizedWords = result.recognizedWords.trim().toLowerCase();
            final targetPhrase = currentWord.value.trim().toLowerCase();

            checkPronunciation(recognizedWords, targetPhrase);
            speechToText.stop();
            isListening.value = false;
          }
        },
        listenFor: const Duration(seconds: 4),
        pauseFor: const Duration(seconds: 3),
        listenOptions: stt.SpeechListenOptions(
          partialResults: false,
          cancelOnError: true,
        ),
      );
    } catch (e) {
      print('Listening error: $e');
      isListening.value = false;
      Get.snackbar(
        'Error',
        'Failed to start speech recognition',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    }
  }

  /// Check if phrase matches
  void checkPronunciation(String recognized, String target) {
    final isMatch = recognized == target;

    // Update score in parent controller
    try {
      final parentController = Get.find<NativeSpeakingSkillController>();
      parentController.score.value = isMatch ? 100 : 0;
    } catch (e) {
      print('Parent controller not found: $e');
    }

    isSuccess.value = isMatch;

    if (isMatch) {
      feedbackMessage.value = 'Perfect! Great Pronunciation!';
    } else {
      feedbackMessage.value = 'Try again! You said: "$recognized"';
    }

    showFeedback.value = true;
  }

  /// Load next phrase (reset button)
  void loadNextWord() {
    if (phrases.isEmpty) return;

    showFeedback.value = false;
    isSuccess.value = false;

    currentPhraseIndex.value = (currentPhraseIndex.value + 1) % phrases.length;
    currentWord.value = phrases[currentPhraseIndex.value];
  }
}
