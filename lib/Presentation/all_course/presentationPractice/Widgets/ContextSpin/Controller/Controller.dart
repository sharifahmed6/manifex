import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../Controller/Controller.dart';


class ContextSpinController extends GetxController {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  var isRunning = false.obs;
  var AudioFilePath = ''.obs;
  var score = 0.obs;
  var feedback = ''.obs;
  var isLoading = false.obs;
  var recordDuration = 0.obs;
  Timer? _timer;

  RxMap<String, dynamic> contextSpin = <String, dynamic>{
    "words": [
      "eloquent",
      "articulate",
      "persuasive",
      "engaging",
      "captivating"
    ],
    "scenario": "suppose you are presenting at a board meeting"
  }.obs;


  List<String> get words => (contextSpin["words"] as List).cast<String>();
  String get scenario => contextSpin["scenario"] as String;

  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
  }

  Future<void> startRecording() async {
    if (isRunning.value) return;

    isRunning.value = true;
    AudioFilePath.value = '';
    await recorder.startRecorder(
      toFile: 'contextSpin.m4a',
      codec: Codec.aacMP4,
    );
    _startTimer();
  }

  Future<void> stopRecording() async {
    String? path = await recorder.stopRecorder();
    isRunning.value = false;
    AudioFilePath.value = path!;
    _stopTimer();
  }

  void _startTimer() {
    recordDuration.value = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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

  Future<void> getContextSpin() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/presentation/context-spin/get_context_spin?user_id=$userId",
    );

    try {
      isLoading.value = true;
      final response = await http.get(
        url,
        headers: {
          'authtoken': '1',
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Raw Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        contextSpin.assignAll(decoded);

        print("Parsed Data: ${contextSpin.value}");
      }
      else {
        print("Server returned error: ${response.statusCode}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> submit() async {
    final url = Uri.parse("https://ai.manifex.org/api/v1/presentation/context-spin/context_spin");


    try {
      // Create Multipart request
      final request = http.MultipartRequest('POST', url);

      // Headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        'authtoken': '1',
      });

      // Add text field
      request.fields['scenario'] =
          contextSpin.value['scenario'] ?? '';

      request.fields['words'] =
          jsonEncode(contextSpin.value['words'] ?? []);


      // Add audio files if provided
      if (AudioFilePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          AudioFilePath.value,
        ));
      }

      isLoading.value = true;
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);


      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        score.value = data['score'] ?? 0;
        feedback.value = data['feedback'] ?? '';
        Get.find<presentationPracticeController>().finalResult.add(data);
        Get.find<presentationPracticeController>().showFinalResult();

      } else {
        print("Error submitting word: ${response.body}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    } finally {
      isLoading.value = false;
    }
  }



  @override
  void onInit() {
    initRecorder();
    super.onInit();
  }

  @override
  void onReady() {
    getContextSpin();
    super.onReady();
  }





  @override
  void onClose() {
    recorder.closeRecorder();
    super.onClose();
  }

}