import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../Core/snakbar.dart';

class flowChainController extends GetxController {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  var isRunning = false.obs;
  var AudioFilePath = ''.obs;

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
  ];

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