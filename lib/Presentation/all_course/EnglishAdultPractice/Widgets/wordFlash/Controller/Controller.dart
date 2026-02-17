import 'dart:async';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../Core/snakbar.dart';

class wordFlashController extends GetxController {
  var currentIndex = 0.obs;
  var words = [
  "exacerbate",
  "ubiquitous",
  "perspicacious",
  "ephemeral",
  "idiosyncratic"
  ];

  var isRunning = false.obs;
  var AudioFilePath = ''.obs;


  RxInt countdown = 3.obs;
  RxBool isCounting = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    initRecorder();
  }

  void startCountdown() {
    countdown.value = 3;
    isCounting.value = true;

    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 1) {
        countdown.value--;
      } else {
        timer.cancel();
        isCounting.value = false;
        stopRecording();
      }
    });
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    isCounting.value = false;
  }


  final FlutterSoundRecorder recorder = FlutterSoundRecorder();


  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
  }


  Future<void> startRecording() async {
    if (isRunning.value) return;

    isRunning.value = true;
    AudioFilePath.value = '';
    startCountdown();
    await recorder.startRecorder(toFile: 'contextSpin.aac');
  }

  Future<void> stopRecording() async {
    String? path = await recorder.stopRecorder();
    isRunning.value = false;
    AudioFilePath.value = path!;
    stopTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void nextWord() {
    if (currentIndex.value < words.length - 1) {
      currentIndex++;
      AudioFilePath.value = '';
      stopRecording();
      startCountdown();
    }else{
      AppSnackbar.show("No more words left.");
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      currentIndex--;
    }else{
      AppSnackbar.show("No more words left.");
    }
  }

}