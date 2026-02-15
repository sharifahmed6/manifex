import 'dart:convert';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';

class flowChainController extends GetxController {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  var isRunning = false.obs;
  var AudioFilePath = ''.obs;
  var score = 0.obs;
  var feedback = ''.obs;


  var flowChain = [
    "inspiration",
    "motivation",
    "determination",
    "perseverance",
    "success",
    "achievement",
    "fulfillment",
    "happiness",
    "contentment",
    "satisfaction"
  ].obs;

  List<String> get words => flowChain;

  /// Selected words (max 3)
  RxList<String> selectedWords = <String>[].obs;

  void toggleWord(String word) {

    if (selectedWords.contains(word)) {
      selectedWords.remove(word);
    }
    else {
      if (selectedWords.length < 3) {
        selectedWords.add(word);
      } else {
        AppSnackbar.show("Limit Reached Max 3 Words".tr);
      }
    }
  }

  bool isSelected(String word) => selectedWords.contains(word);

  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
  }

  Future<void> startRecording() async {
    if (selectedWords.isEmpty) {
      AppSnackbar.show("Please select at least one word.".tr);
      return;
    }
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

  @override
  void onInit() {
    initRecorder();
    super.onInit();
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    super.onClose();
  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    await getFlowChain();
    super.onReady();
  }

  Future<void> getFlowChain() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/presentation/flow-chain/get_flow_chain?user_id=$userId",
    );

    try {
      Get.dialog(
        barrierDismissible: false,
        CustomCircleProgressIndicator(),
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

        // ✅ Proper way to update RxList
        flowChain.assignAll(List<String>.from(decoded));

        print("Parsed Data: ${flowChain.value}");
      } else {
        print("Server returned error: ${response.statusCode}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    }
  }

  Future<void> submit() async {
    final url = Uri.parse(
        "https://ai.manifex.org/api/v1/presentation/flow-chain/flow_chain");

    try {
      // Create Multipart request
      final request = http.MultipartRequest('POST', url);

      // ✅ Headers (do NOT set content-type manually for MultipartRequest)
      request.headers.addAll({
        'authtoken': '1',
        // 'Content-Type' is set automatically by MultipartRequest
      });

      // ✅ Send the word list as JSON string
      final words = selectedWords.value ?? [];
      request.fields['word_list'] = jsonEncode(words);

      // ✅ Add audio file if provided
      if (AudioFilePath.value.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          AudioFilePath.value,
        ));
      }

      // ✅ Show loading
      Get.dialog(
        barrierDismissible: false,
        CustomCircleProgressIndicator(),
      );

      // Send request
      final streamedResponse = await request.send();

      // Convert to http.Response
      final response = await http.Response.fromStream(streamedResponse);

      // Close loading
      Get.back();

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // ✅ Parse response safely
        final Map<String, dynamic> data = jsonDecode(response.body);

        score.value = data['score'] ?? 0;
        feedback.value = data['feedback'] ?? '';

        print("Word submitted successfully");
      } else {
        print("Error submitting word: ${response.body}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    }
  }



}