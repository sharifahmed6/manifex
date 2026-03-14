import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'native_speaking_skill_controller.dart';

class NativeTaskOneController extends GetxController {
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
  final words = <String>[].obs;
  final currentWordIndex = 0.obs;
  final currentWord = ''.obs;
  final feedbackMessage = ''.obs;

  // Speech recognition
  final speechAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
    fetchPronunciationWords();
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

    flutterTts.setStartHandler(() {
      isSpeaking.value = true;
    });
    flutterTts.setCompletionHandler(() {
      isSpeaking.value = false;
    });
    flutterTts.setCancelHandler(() {
      isSpeaking.value = false;
    });
    flutterTts.setErrorHandler((msg) {
      isSpeaking.value = false;
    });
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

  /// Fetch pronunciation words from API
  Future<void> fetchPronunciationWords() async {
    try {
      isLoading.value = true;

      final response = await networkCaller.getRequest(
        url: urls.getPronunciation(
          homeController.userId,
          homeController.apiAge.toString(),
        ),
        removeAuthorization: true,
        extraHeaders: {"authtoken": "1"},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!;

        // Try different possible response structures
        List<dynamic>? wordsList;

        if (data.containsKey('words')) {
          wordsList = data['words'];
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
          words.assignAll(wordsList.map((e) => e.toString()).toList());
          currentWordIndex.value = 0;
          currentWord.value = words[0];

          Future.delayed(const Duration(milliseconds: 500), () {
            playWordPronunciation();
          });
        } else {
          Get.snackbar(
            'No Words'.tr,
            'No pronunciation words found'.tr,
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
      print('Error fetching words: $e');
      Get.snackbar(
        'Error'.tr,
        'Failed to load words'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Play word pronunciation using TTS (headphone button)
  Future<void> playWordPronunciation() async {
    if (currentWord.value.isEmpty) return;

    try {
      if (isSpeaking.value) {
        await flutterTts.stop();
        isSpeaking.value = false;
      } else {
        await flutterTts.speak(currentWord.value);
      }
    } catch (e) {
      print('TTS error: $e');
      isSpeaking.value = false;
      Get.snackbar(
        'Error'.tr,
        'Failed to play pronunciation'.tr,
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
            final recognizedWords = result.recognizedWords.trim().toLowerCase();
            final targetWord = currentWord.value.trim().toLowerCase();

            checkPronunciation(recognizedWords, targetWord);
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

  /// Check if pronunciation matches
  void checkPronunciation(String recognized, String target) {
    final isMatch = recognized == target;

    // Update score in parent controller
    try {
      final parentController = Get.find<NativeSpeakingSkillController>();
      parentController.score.value = isMatch ? 100 : 0;
      parentController.taskOneScore.value = isMatch ? 100 : 0;
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

  /// Load next word (reset button)
  Future<void> loadNextWord() async {
    if (words.isEmpty) return;

    showFeedback.value = false;
    isSuccess.value = false;

    currentWordIndex.value = (currentWordIndex.value + 1) % words.length;
    currentWord.value = words[currentWordIndex.value];

    await flutterTts.stop();
    isSpeaking.value = false;
    await flutterTts.speak(currentWord.value);
  }
}
