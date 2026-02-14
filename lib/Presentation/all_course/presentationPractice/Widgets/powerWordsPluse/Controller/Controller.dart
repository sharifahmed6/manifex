import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class powerWordsPluseController extends GetxController {

  var powerWords = [
    "thrive",
    "expand",
    "transform",
    "evolve",
    "progress",
    "develop",
    "escalate",
    "advance",
    "prosper",
    "flourish"
  ].obs;

  var currentWord = 0.obs;
  var defineRecording = false.obs;
  var sentenceRecording = false.obs;
  var defineAudioFile = ''.obs;
  var sentenceAudioFile = ''.obs;

  void skipWord() {

    if (currentWord.value < powerWords.length - 1) {
      currentWord.value++;
      defineRecording.value = false;
      sentenceRecording.value = false;
      stopRecording("");
      defineAudioFile.value = '';
      sentenceAudioFile.value = '';
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
  void onInit() {
    super.onInit();
    _recorder = FlutterSoundRecorder();
    _initAudioModules();
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
      // Stop the recorder and get the actual file path
      String? path = await _recorder!.stopRecorder();

      // Update your variable just in case
      recordPath = path;

      if (recordPath != null) {
        if(type == "define"){
          defineAudioFile.value = recordPath ?? '';
        }else{
          sentenceAudioFile.value = recordPath ?? '';
        }
        print("===================================================================");
        print("Recorded Path : $path");
        // AppSnackbar.show(path!);
        print("===================================================================");
      }
    } catch (e) {
      debugPrint("Stop recording error: $e");
    }
  }
}
