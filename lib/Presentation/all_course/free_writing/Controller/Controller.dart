import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'dart:ui' as ui;

import '../../../../App/Urls.dart';
import '../../../../App/network_caller.dart';
import '../../../../Core/loading.dart';
import '../../../../Core/SharepreferenceHelper.dart';
import '../../../../Core/MusicService.dart';

class FreeWritingController extends GetxController {
  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;

  var listLock = <bool>[].obs;
  var listComplete = <bool>[].obs;
  var result = <Map<String, dynamic>>[].obs;
  var userAgeGroup = "".obs;

  Future<void> unLockTask(int index) async {
    if (index - 1 < listLock.length) {
      listLock[index] = false;
      listComplete[index] = false;
    }
    Get.back();
    AppSnackbar.show("Task $index Completed.");
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

    // Default to '10-13' behaviour if age empty or malformed
    String age = PrefHelper.getAge();
    if (age.isEmpty) age = '10-13';
    userAgeGroup.value = age;

    int taskCount = 2;
    if (age == '14-17' || age == '18-40') {
      taskCount = 0; // No free writing assigned
    }

    listLock.assignAll(List.generate(taskCount, (index) => false));
    listComplete.assignAll(List.generate(taskCount, (index) => true));

    result.assignAll(
      List.generate(
        taskCount,
        (index) => {
          "taskName": "Task ${index + 1}",
          "marks": 0,
          "isAnswer": true,
        },
      ),
    );

    if (age == '6-9' || age == '10-13') {
      MusicService().play();
    }
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
        listComplete[8] = false;
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
      // 1️⃣ Convert signature to image
      final ui.Image? signatureImage = await controller.toImage();
      if (signatureImage == null) return null;

      // 2️⃣ Create a white background canvas
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

      // Paint white background
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

      // Draw the signature on top
      canvas.drawImage(signatureImage, Offset.zero, Paint());

      // 3️⃣ Convert canvas to PNG bytes
      final picture = recorder.endRecording();
      final img = await picture.toImage(
        signatureImage.width,
        signatureImage.height,
      );
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return null;

      // 4️⃣ Save to file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName.png');
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
    MusicService().stop();
    _timer?.cancel();
    super.onClose();
  }
}
