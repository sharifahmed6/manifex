import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../Controller/Controller.dart';


class PrecisionDrillController extends GetxController {

  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  var isRunning = false.obs;
  var currentWord = "".obs;
  var score = 0.obs;
  var feedback = ''.obs;
  var isLoading = false.obs;
  var recordDuration = 0.obs;

  Timer? _drillTimer;
  Timer? _recordTimer;
  int _currentIndex = 0;
  String _currentSection = "slow";
  var currentSpeed = "Slow".obs;
  var AudioFilePath = ''.obs;

  var precisionDrill = {
    "slow": [
      "perception"
    ],
    "medium": [
      "synergy","paradigm","leverage","holistic",
      "proactive","transformative","agile",
      "scalable","disruptive","visionary"
    ],
    "fast": [
      "ubiquitous","quintessential","conundrum",
      "serendipity","dichotomy","magnificent",
      "articulation","pronunciation",
      "enunciation","eloquence"
    ],
  };

  @override
  Future<void> onInit() async {
    initRecorder();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    await getPrecisionDrill();
    super.onReady();
  }


  Future<void> getPrecisionDrill() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse("https://ai.manifex.org/api/v1/presentation/precision-drill/get_precision_drill?user_id=$userId"
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
        final Map<String, dynamic> decoded =
        jsonDecode(response.body);

        // Convert safely to Map<String, List<String>>
        final Map<String, List<String>> converted = {};

        decoded.forEach((key, value) {
          converted[key] = List<String>.from(value);
        });

        precisionDrill = converted;

        print("Parsed Data: $precisionDrill");

      } else {
        print("Server returned error: ${response.statusCode}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
  }

  Future<void> startDrill() async {
    if (isRunning.value) return;

    isRunning.value = true;
    _currentSection = "slow";
    _currentIndex = 0;
    currentSpeed.value = "Slow";
    AudioFilePath.value = '';
    score.value = 0;
    feedback.value = '';


    await recorder.startRecorder(toFile: 'precision_drill.aac');
    _startRecordTimer();
    _startSection();
  }


  void _startSection() {
    if (!isRunning.value) return;

    final words = precisionDrill[_currentSection]!;

    if (_currentIndex >= words.length) {
      _moveToNextSection();
      return;
    }

    currentWord.value = words[_currentIndex];

    int seconds = _getDuration(_currentSection);

    _drillTimer = Timer(Duration(seconds: seconds), () {
      _currentIndex++;
      _startSection();
    });
  }


  int _getDuration(String section) {
    switch (section) {
      case "slow":
        return 5;
      case "medium":
        return 3;
      case "fast":
        return 2;
      default:
        return 5;
    }
  }

  void _moveToNextSection() {
    if (_currentSection == "slow") {
      _currentSection = "medium";
      currentSpeed.value = "Medium";
    } else if (_currentSection == "medium") {
      _currentSection = "fast";
      currentSpeed.value = "Fast";
    } else {
      stopDrill();
      AppSnackbar.show("Precision drill finished");
      return;
    }

    _currentIndex = 0;
    _startSection();
  }

  Future<void> stopDrill() async {
    isRunning.value = false;
    _drillTimer?.cancel();
    _stopRecordTimer();
    String? path = await recorder.stopRecorder();
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


  List<String> getAllPrecisionWords(Map<String, List<String>> drill) {
    return [
      ...?drill['slow'],
      ...?drill['medium'],
      ...?drill['fast'],
    ];
  }


  Future<void> submit() async {
    final url = Uri.parse("https://ai.manifex.org/api/v1/presentation/precision-drill/precision_drill");


    try {
      // Create Multipart request
      final request = http.MultipartRequest('POST', url);

      // Headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        'authtoken': '1',
      });
      final allWords = getAllPrecisionWords(precisionDrill);

      // Add text field
      request.fields['wordlist'] = jsonEncode(allWords);


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
  void onClose() {
    recorder.closeRecorder();
    super.onClose();
  }

}