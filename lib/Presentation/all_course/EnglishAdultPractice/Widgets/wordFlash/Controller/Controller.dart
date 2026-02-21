import 'dart:async';
import 'dart:convert';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import 'package:http/http.dart' as http;

import '../../../Controller/Controller.dart';

class wordFlashController extends GetxController {
  var currentIndex = 0.obs;
  var words = ["Loading.."].obs;

  var isRunning = false.obs;
  var AudioFilePath = ''.obs;
  var score = 0.obs;

  RxInt countdown = 3.obs;
  RxBool isCounting = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    initRecorder();
  }

  void startCountdown() {
    countdown.value = 3;
    isCounting.value = true;

    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 1) {
        countdown.value--;
      } else {
        timer.cancel();
        isCounting.value = false;
        stopRecording();
      }
    });
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    isCounting.value = false;
  }

  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
  }

  Future<void> startRecording() async {
    if (isRunning.value) return;

    isRunning.value = true;
    AudioFilePath.value = '';
    startCountdown();
    await recorder.startRecorder(toFile: 'contextSpin.aac');
  }

  Future<void> stopRecording() async {
    String? path = await recorder.stopRecorder();
    isRunning.value = false;
    AudioFilePath.value = path!;
    stopTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void nextWord() {
    if (currentIndex.value < words.length - 1) {
      currentIndex++;
      AudioFilePath.value = '';
      stopRecording();
      startCountdown();
    } else {
      final practiceController = Get.find<EnglishAdultPracticeController>();
      practiceController.finalResult[3]['marks'] =
          (score.value / (words.length * 100)) * 100;
      practiceController.unLockTask(3);
      Get.back();
      AppSnackbar.show("Task 3 Completed.");
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      currentIndex--;
    } else {
      AppSnackbar.show("No more words left.");
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getWordFlash();
    super.onReady();
  }

  Future<void> getWordFlash() async {
    final userId = PrefHelper.getUserId().toString();

    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/adult/word-flash/get_word_flash?user_id=$userId",
    );

    try {
      Get.dialog(CustomCircleProgressIndicator(), barrierDismissible: false);

      final response = await http.get(url, headers: {'authtoken': '1'});

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (response.statusCode == 200) {
        words.clear();
        final decoded = jsonDecode(response.body);
        words.assignAll(List<String>.from(decoded['words']));
      } else {
        AppSnackbar.show("Failed to load exercises");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackbar.show("Something went wrong");
      print("HTTP Error: $e");
    }
  }

  Future<void> submit() async {
    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/adult/word-flash/word_flash",
    );

    try {
      // Create Multipart request
      final request = http.MultipartRequest('POST', url);

      // Headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        'authtoken': PrefHelper.getAccessToken(),
      });

      // Add text field
      request.fields['word'] = jsonEncode(words[currentIndex.value]);

      // Add audio files if provided
      if (AudioFilePath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('file', AudioFilePath.value),
        );
      }

      Get.dialog(barrierDismissible: false, CustomCircleProgressIndicator());
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      Get.back();

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        score.value += (data['score'] as int?) ?? 0;
        // print("Score: ${score.value}");
        // print("Final Score: ${(score.value / (words.length * 100)) * 100}");

        nextWord();
      } else {
        print("Error submitting word: ${response.body}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    }
  }
}
