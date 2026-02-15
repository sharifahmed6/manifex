import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../Core/snakbar.dart';

class ContextSpinController extends GetxController {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  var isRunning = false.obs;
  var AudioFilePath = ''.obs;

  var contextSpin = {
    "words": [
      "eloquent",
      "articulate",
      "persuasive",
      "engaging",
      "captivating"
    ],
    "scenario": "suppose you are presenting at a board meeting"
  };

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
    AppSnackbar.show(path!);
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

}