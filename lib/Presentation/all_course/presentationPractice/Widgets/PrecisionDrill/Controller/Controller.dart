import 'dart:async';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:permission_handler/permission_handler.dart';

class PrecisionDrillController extends GetxController {

  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  var isRunning = false.obs;
  var currentWord = "".obs;

  Timer? _timer;
  int _currentIndex = 0;
  String _currentSection = "slow";
  var currentSpeed = "Slow".obs;
  var AudioFilePath = ''.obs;

  final Map<String, List<String>> precisionDrill = {
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
  void onInit() {
    initRecorder();
    super.onInit();
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


    await recorder.startRecorder(toFile: 'precision_drill.aac');

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

    _timer = Timer(Duration(seconds: seconds), () {
      _currentIndex++;
      _startSection();
    });
  }

  int _getDuration(String section) {
    switch (section) {
      case "slow":
        return 8;
      case "medium":
        return 5;
      case "fast":
        return 3;
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
    _timer?.cancel();
    String? path = await recorder.stopRecorder();
    print("Recorded Path : $path");
    AppSnackbar.show(path!);
    AudioFilePath.value = path;
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    super.onClose();
  }

}