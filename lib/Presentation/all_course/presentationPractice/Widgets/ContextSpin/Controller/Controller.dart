import 'dart:convert';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import '../../../Controller/Controller.dart';

class ContextSpinController extends GetxController {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  var isRunning = false.obs;
  var AudioFilePath = ''.obs;
  var score = 0.obs;
  var feedback = ''.obs;

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
    await recorder.startRecorder(toFile: 'contextSpin.aac');
  }

  Future<void> stopRecording() async {
    String? path = await recorder.stopRecorder();
    isRunning.value = false;
    AudioFilePath.value = path!;
  }

  Future<void> getContextSpin() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/presentation/context-spin/get_context_spin?user_id=$userId",
    );

    try {
      Get.dialog(
          barrierDismissible: false,
          CustomCircleProgressIndicator()
      );
      final response = await http.get(
        url,
        headers: {
          'authtoken': '1',
        },
      );
      Get.back();

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

      Get.dialog(
          barrierDismissible: false,
          CustomCircleProgressIndicator()
      );
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      Get.back();

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