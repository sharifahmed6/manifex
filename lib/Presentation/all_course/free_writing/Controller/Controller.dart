import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'dart:ui' as ui;

import 'package:manifex/App/assets_path.dart';
import '../../../../App/Urls.dart';
import '../../../../App/network_caller.dart';
import '../../../../Core/loading.dart';
import '../../../../Core/SharepreferenceHelper.dart';
import '../../../../Core/MusicService.dart';

class FreeWritingController extends GetxController {
  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;

  var listLock = [false, true, true].obs;
  var listComplete = [true, true, true].obs;
  var result = <Map<String, dynamic>>[].obs;
  var userAgeGroup = "".obs;

  Future<void> unLockTask(int index) async {
    if (index >= 0 && index < listLock.length) {
      listLock[index] = false;
    }
    if (index > 0 && index <= listComplete.length) {
      listComplete[index - 1] = false;
    }
    
    Get.back(closeOverlays: true);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppSnackbar.show("Task $index Completed.");
    });
  }

  final List<String> allWords = [
    'Tree','Book','Fish','Moon','Star',
    'Milk','Ball','Duck','Frog','Ship',
    'Ring','King','Wind','Fire','Rock',
    'Snow','Rain','Leaf','Bird','Lion',
    'Bear','Lamp','Road','Boat','Seed',
    'Fork','Desk','Cake','Hill','Farm',
  ];

  List<String> getRandomWords(List<String> words) {
    final shuffled = List<String>.from(words)..shuffle(Random());
    return shuffled.take(5).toList();
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();

    String age = PrefHelper.getAge();
    if (age.isEmpty) age = '10-13';
    userAgeGroup.value = age;

    result.assignAll(
      List.generate(
        3,
        (index) => {
          "taskName": "Task ${index + 1}",
          "marks": 0,
          "isAnswer": true,
        },
      ),
    );

    MusicService().play(AssetsPath.smartWritingMusic);
  }

  Future<void> FinalSubmission() async {
    AppLoader.show();

    try {
      NetworkResponse response = await NetworkCaller().postRequest(
        url: urls.adultTaskSubmit,
        body: {"tasks": result, "timeSpent": seconds.value},
      );
      AppLoader.hide();

      if (response.statusCode == 201 &&
          response.responseData != null &&
          response.responseData?['success'] == true) {
        listComplete[2] = false;
      } else {
        print("Error submitting final answers ❌");
        print(
          "Server message: ${response.responseData?['message'] ?? response.errorMessage}",
        );
      }
    } catch (e) {
      AppLoader.hide();
      print("HTTP Error: $e");
    }
  }

  //==============================================================================================
  Future<String?> saveSignaturePng(
    SignatureController controller,
    String fileName,
  ) async {
    try {
      final ui.Image? signatureImage = await controller.toImage();
      if (signatureImage == null) return null;

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
        recorder,
        Rect.fromLTWH(
          0,
          0,
          signatureImage.width.toDouble(),
          signatureImage.height.toDouble(),
        ),
      );

      final paint = Paint()..color = Colors.white;
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          signatureImage.width.toDouble(),
          signatureImage.height.toDouble(),
        ),
        paint,
      );

      canvas.drawImage(signatureImage, Offset.zero, Paint());

      final picture = recorder.endRecording();
      final img = await picture.toImage(
        signatureImage.width,
        signatureImage.height,
      );
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return null;

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName.png';
      final file = File(filePath);
      
      if (await file.exists()) {
        await file.delete();
      }
      
      await file.writeAsBytes(byteData.buffer.asUint8List());

      return file.path;
    } catch (e) {
      print("Error saving signature with white background: $e");
      return null;
    }
  }

  RxInt seconds = 0.obs;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds.value++;
    });
  }

  String get formattedTime {
    final h = (seconds.value ~/ 3600).toString().padLeft(2, '0');
    final m = ((seconds.value % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (seconds.value % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  @override
  void onClose() {
    _timer?.cancel();
    MusicService().stop();
    super.onClose();
  }
}
