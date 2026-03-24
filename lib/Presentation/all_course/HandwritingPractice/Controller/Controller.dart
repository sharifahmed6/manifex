import 'dart:async';
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

class HandwritingPracticeController extends GetxController {
  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;

  var listLock = [false, true, true, true, true, true, true, true, true, true].obs;
  var listComplete = [true, true, true, true, true, true, true, true, true, true].obs;

  Future<void> unLockTask(int index) async {
    if (index < listLock.length) {
      listLock[index] = false;
      listComplete[index - 1] = false;
      Get.back();
      AppSnackbar.show("Task $index Completed.");
    }
  }

  final result = [
    {"taskName": "Task 1", "marks": 0, "isAnswer": true},
    {"taskName": "Task 2", "marks": 0, "isAnswer": true},
    {"taskName": "Task 3", "marks": 0, "isAnswer": true},
    {"taskName": "Task 4", "marks": 0, "isAnswer": true},
    {"taskName": "Task 5", "marks": 0, "isAnswer": true},
    {"taskName": "Task 6", "marks": 0, "isAnswer": true},
    {"taskName": "Task 7", "marks": 0, "isAnswer": true},
    {"taskName": "Task 8", "marks": 0, "isAnswer": true},
    {"taskName": "Task 9", "marks": 0, "isAnswer": true},
    {"taskName": "Task 10", "marks": 0, "isAnswer": true},
  ];

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
        listComplete[9] = false;
      } else {
        print("Error submitting final answers ❌");
        print("Server message: ${response.responseData?['message'] ?? response.errorMessage}");
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

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

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
    super.onClose();
  }
}
