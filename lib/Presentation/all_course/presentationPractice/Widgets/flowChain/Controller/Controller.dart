import 'dart:async';
import 'dart:convert';


import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../Controller/Controller.dart';


class flowChainController extends GetxController {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  var isRunning = false.obs;
  var score = 0.obs;
  var feedback = ''.obs;
  var AudioFilePath = ''.obs;
  var isLoading = false.obs;

  var recordDuration = 0.obs;

  Timer? _recordTimer;



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

  /// Selected words
  RxList<String> selectedWords = <String>[].obs;

  void toggleWord(String word) {

    if (selectedWords.contains(word)) {
      selectedWords.remove(word);
    }
    else {
      selectedWords.add(word);
    }
  }

  bool isSelected(String word) => selectedWords.contains(word);

  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
  }

  Future<void> startRecording() async {
    if (selectedWords.length < 5) {
      AppSnackbar.show("Please select at least 5 words to record.".tr);
      return;
    }
    if (isRunning.value) return;

    isRunning.value = true;
    AudioFilePath.value = '';
    await recorder.startRecorder(
      toFile: 'flow_chain.m4a',
      codec: Codec.aacMP4,
    );
    _startRecordTimer();
  }

  Future<void> stopRecording() async {
    String? path = await recorder.stopRecorder();
    isRunning.value = false;
    _stopRecordTimer();
    AudioFilePath.value = path!;
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

        // ✅ Proper way to update RxList
        flowChain.assignAll(List<String>.from(decoded));

        print("Parsed Data: ${flowChain.value}");
      } else {
        print("Server returned error: ${response.statusCode}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> submit() async {
    final url = Uri.parse(
        "https://ai.manifex.org/api/v1/presentation/flow-chain/flow_chain");

    try {
      // Show loading
      isLoading.value = true;

      final request = http.MultipartRequest('POST', url);


      // Headers
      request.headers.addAll({
        'authtoken': '1',
        'Accept': 'application/json',
      });

      // ✅ Get words safely
      final List<String> words =
      (selectedWords.value ?? []).map((e) => e.toString()).toList();

      if (words.isEmpty) {
        Get.back();
        Get.snackbar("Error", "Word list is empty");
        return;
      }

      // ✅ IMPORTANT FIX:
      // Send as comma-separated string instead of jsonEncode
      request.fields['word_list'] = words.join(",");

      // ✅ Add audio file if exists
      if (AudioFilePath.value.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            AudioFilePath.value,
          ),
        );
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Status Code: ${response.statusCode}");

      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          Get.snackbar("Error", "Empty response from server");
          return;
        }

        final Map<String, dynamic> data = jsonDecode(response.body);

        // ✅ Safe parsing
        score.value = data['score'] ?? 0;
        feedback.value = data['feedback'] ?? '';
        
        // Ensure finalResult includes the score for overall result calculation
        var resultData = {
          "task": "Flow Chain",
          "score": score.value,
          "feedback": feedback.value,
        };
        Get.find<presentationPracticeController>().finalResult.add(resultData);

      } else {
        // Backend validation error
        Get.snackbar("Server Error", response.body);
        print("Server returned error: ${response.statusCode}");
      }

    } catch (e) {
      print("HTTP Error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }





}