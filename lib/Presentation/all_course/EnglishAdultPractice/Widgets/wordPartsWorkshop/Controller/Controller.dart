import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import 'package:http/http.dart' as http;
import '../../../Controller/Controller.dart';
import '../Model/Model.dart';

class wordPartsWorkshopController extends GetxController {
  var currentIndex = 0.obs;

  // Recording variables
  var isRecording = false.obs;
  var audioFile = ''.obs;
  var recordDuration = 0.obs;
  Timer? _timer;
  FlutterSoundRecorder? _recorder;
  String? recordPath;

  // Feedback variables
  var showFeedback = false.obs;
  var isSuccess = false.obs;
  var feedbackMessage = ''.obs;
  var score = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _recorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder!.openRecorder();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _recorder?.closeRecorder();
    super.onClose();
  }

  void _startTimer() {
    recordDuration.value = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      recordDuration.value++;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  String formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> startRecording() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      recordPath = '${tempDir.path}/word_parts_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder!.startRecorder(
        toFile: recordPath,
        codec: Codec.aacMP4,
        audioSource: AudioSource.microphone,
      );
      isRecording.value = true;
      showFeedback.value = false;
      _startTimer();
    } catch (e) {
      debugPrint("Start recording error: $e");
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await _recorder!.stopRecorder();
      audioFile.value = path ?? '';
      isRecording.value = false;
      _stopTimer();
    } catch (e) {
      debugPrint("Stop recording error: $e");
    }
  }

  void nextWord() {
    final wp = wordParts.value;
    if (wp == null) return;

    if (currentIndex.value < wp.suffix.length - 1) {
      currentIndex.value++;
      resetState();
      return;
    } else {
      final practiceController = Get.find<EnglishAdultPracticeController>();
      practiceController.finalResult[3]['marks'] = 100;
      practiceController.unLockTask(4);
      Get.back();
      return;
    }
  }

  void resetState() {
    audioFile.value = '';
    recordDuration.value = 0;
    showFeedback.value = false;
    isSuccess.value = false;
    feedbackMessage.value = '';
    score.value = 0;
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      currentIndex--;
      resetState();
    } else {
      AppSnackbar.show("No more words left.");
    }
  }

  Future<void> submit() async {
    final wp = wordParts.value;
    if (wp == null) return;

    final word = "${wp.prefix[currentIndex.value]}${wp.root[currentIndex.value]}${wp.suffix[currentIndex.value]}";
    // Using the requested pronunciation check URL
    final url = Uri.parse("https://ai.manifex.org/api/v1/speaking/pronunciation/pronunciation");

    try {
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Content-Type': 'application/json',
        'authtoken': '1',
      });
      request.fields['word'] = word;

      if (audioFile.value.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          audioFile.value,
        ));
      }

      Get.dialog(const CustomCircleProgressIndicator(), barrierDismissible: false);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (Get.isDialogOpen ?? false) Get.back();

      // Print API response as requested
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        score.value = data['score'] ?? 0;
        feedbackMessage.value = data['feedback'] ?? '';
        isSuccess.value = score.value >= 70; // Assuming 70+ is success
        showFeedback.value = true;
      } else {
        AppSnackbar.show("Submission failed");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      print("Submit Error: $e");
    }
  }

  @override
  void onReady() {
    getWordParts();
    super.onReady();
  }
  Rxn<WordPartsModel> wordParts = Rxn<WordPartsModel>();

  Future<void> getWordParts() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/adult/word-parts-workshop/get_word_parts?user_id=$userId",
    );

    try {
      Get.dialog(const CustomCircleProgressIndicator(), barrierDismissible: false);
      final response = await http.get(url, headers: {'authtoken': '1'});
      if (Get.isDialogOpen ?? false) Get.back();

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        wordParts.value = WordPartsModel.fromJson(decoded);
      } else {
        AppSnackbar.show("Failed to load word parts");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      AppSnackbar.show("Something went wrong");
      print("HTTP Error: $e");
    }
  }
}
