import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';

import 'package:manifex/App/assets_path.dart';
import '../../../../App/Urls.dart';
import '../../../../App/network_caller.dart';
import '../../../../Core/loading.dart';
import '../../../../Core/SharepreferenceHelper.dart';
import '../../../../Core/MusicService.dart';

class FreeWritingController extends GetxController {
  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;

  // Task 1 is unlocked initially, Task 2 is locked
  var listLock = [false, false].obs;
  // Both tasks are "available" (visible as buttons)
  var listComplete = [true, true].obs; 
  var result = <Map<String, dynamic>>[].obs;

  Future<void> unLockTask(int index) async {
    // index is taskNumber (1 or 2)
    // Unlock next task if it exists
    if (index < listLock.length) {
      listLock[index] = false; 
    }
    // Mark current task as finished (this hides the button in the current UI logic)
    if (index > 0 && index <= listComplete.length) {
      listComplete[index - 1] = false;
    }
    
    Get.back(closeOverlays: true);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppSnackbar.show("Task $index Completed.");
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();

    result.assignAll(
      List.generate(
        2,
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
        // Handle final submission state if needed
      } else {
        print("Error submitting final answers ❌");
      }
    } catch (e) {
      AppLoader.hide();
      print("HTTP Error: $e");
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
