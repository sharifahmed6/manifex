import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';

class powerWordsPluseController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();

  var powerWords = [
    "Loading...",
  ].obs;


  var currentWord = 0.obs;
  var defineRecording = false.obs;
  var sentenceRecording = false.obs;
  var defineAudioFile = ''.obs;
  var sentenceAudioFile = ''.obs;
  var score = 0.obs;
  var feedback = ''.obs;


  void nextWord() {
    if (currentWord.value < powerWords.length - 1) {
      currentWord.value++;
      defineRecording.value = false;
      sentenceRecording.value = false;
      stopRecording("");
      defineAudioFile.value = '';
      sentenceAudioFile.value = '';
      score.value = 0;
      feedback.value = '';
    } else {
      AppSnackbar.show("No more words left.");
    }
  }

  var isVoiceRecording = false.obs;

  FlutterSoundRecorder? _recorder;
  String? recordPath;
  var loadingAudio_Response = false.obs;




  Future<void> _initAudioModules() async {
    await Permission.microphone.request();
    await Permission.storage.request();

    await _recorder!.openRecorder();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    _recorder = FlutterSoundRecorder();
    _initAudioModules();
    await getPowerWords();
  }


  Future<void> getPowerWords() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse(
        "https://ai.manifex.org/api/v1/presentation/power-words/get_power_words?user_id=$userId"
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'authtoken': '1',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<String> words = jsonData.map((e) => e.toString()).toList();
        powerWords.assignAll(words);
      } else {
        print("Server returned error: ${response.statusCode}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    }
  }

  Future<void> submit({
    required String define,
    required String sentence,
    required String word,
  }) async {
    final url = Uri.parse("https://ai.manifex.org/api/v1/presentation/power-words/power_words");
    score.value = 0;
    feedback.value = '';

    try {
      // Create Multipart request
      final request = http.MultipartRequest('POST', url);

      // Headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        'authtoken': '1',
      });

      // Add text field
      request.fields['word'] = word;

      // Add audio files if provided
      if (define.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'defintion_file',
          define,
        ));
      }

      if (sentence.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'sentence_file',
          sentence,
        ));
      }

      Get.dialog(
        barrierDismissible: false,
          CustomCircleProgressIndicator()
      );
      // Send request
      final streamedResponse = await request.send();

      // Convert to Response
      final response = await http.Response.fromStream(streamedResponse);
      Get.back();

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        score.value = data['score'] ?? 0;
        feedback.value = data['feedback'] ?? '';
      } else {
        print("Error submitting word: ${response.body}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    }
  }


  Future<void> startRecording() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      // Change extension for M4A
      recordPath =
      '${tempDir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _recorder!.startRecorder(
        toFile: recordPath,
        codec: Codec.aacMP4, // M4A recording
        audioSource: AudioSource.microphone,
      );
    } catch (e) {
      debugPrint("Start recording error: $e");
    }
  }

  /// Call this to stop recording
  Future<void> stopRecording(String type) async {
    try {
      String? path = await _recorder!.stopRecorder();
      recordPath = path;

      if (recordPath != null) {
        if(type == "define"){
          defineAudioFile.value = recordPath ?? '';
        }else{
          sentenceAudioFile.value = recordPath ?? '';
        }
      }
    } catch (e) {
      debugPrint("Stop recording error: $e");
    }
  }
}
