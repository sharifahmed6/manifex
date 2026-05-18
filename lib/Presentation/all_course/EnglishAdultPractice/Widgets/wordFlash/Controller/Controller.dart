import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
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

  var recordDuration = 0.obs;
  Timer? _recordTimer;
  Timer? _timer;

  var showResult = false.obs;
  var evaluationFeedback = "".obs;
  var currentScore = 0.obs;

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
    Directory tempDir = await getTemporaryDirectory();
    String recordPath =
        '${tempDir.path}/word_flash_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await recorder.startRecorder(toFile: recordPath, codec: Codec.aacMP4);
    _startRecordTimer();
  }

  void _startRecordTimer() {
    recordDuration.value = 0;
    _recordTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      recordDuration.value++;
    });
  }

  void _stopRecordTimer() {
    _recordTimer?.cancel();
    _recordTimer = null;
  }

  String formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }


  Future<void> stopRecording() async {
    String? path = await recorder.stopRecorder();
    isRunning.value = false;
    if (path != null) {
      AudioFilePath.value = path;
    }
    stopTimer();
    _stopRecordTimer();
  }


  @override
  void onClose() {
    _timer?.cancel();
    recorder.closeRecorder();
    super.onClose();
  }

  void nextWord() {
    showResult.value = false;
    if (currentIndex.value < words.length - 1) {
      currentIndex++;
      AudioFilePath.value = '';
    } else {
      final practiceController = Get.find<EnglishAdultPracticeController>();
      practiceController.finalResult[2]['marks'] =
          (score.value / (words.length * 100)) * 100;
      practiceController.unLockTask(3);
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

      debugPrint(response.body);

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
      "https://ai.manifex.org/api/v1/speaking/pronunciation/pronunciation",
    );

    try {
      final request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'authtoken': '1',
      });

      request.fields['word'] = words[currentIndex.value];

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
        int s = (data['score'] as num).toInt();
        score.value += s;
        currentScore.value = s;
        evaluationFeedback.value = data['feedback'] ?? "";
        showResult.value = true;
      } else {
        print("Error submitting word: ${response.body}");
        AppSnackbar.show("Error submitting word");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      print("HTTP Error: $e");
      AppSnackbar.show("Something went wrong");
    }
  }
}
