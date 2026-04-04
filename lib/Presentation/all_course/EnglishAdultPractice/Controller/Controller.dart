import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../../../App/Urls.dart';
import '../../../../App/network_caller.dart';
import '../../../../Core/loading.dart';
import '../../../../Core/snakbar.dart';

class EnglishAdultPracticeController extends GetxController {
  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;

  var listLock = [false, true, true, true, true].obs;
  var listComplete = [true, true, true, true, true].obs;

  var finalResult = [
    {"taskName": "Task 1", "marks": 0, "isAnswer": true},
    {"taskName": "Task 2", "marks": 0, "isAnswer": true},
    {"taskName": "Task 3", "marks": 0, "isAnswer": true},
    {"taskName": "Task 4", "marks": 0, "isAnswer": true},
    {"taskName": "Task 5", "marks": 0, "isAnswer": true},
  ].obs;

  Future<void> unLockTask(int index) async {
    if (index >= 0 && index < listLock.length) {
      listLock[index] = false;
    }
    if (index > 0 && index <= listComplete.length) {
      listComplete[index - 1] = false;
    }
    
    // Using closeOverlays: true is a cleaner way to close snackbars/dialogs during navigation
    Get.back(closeOverlays: true);
    
    // Show completion message after navigation starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppSnackbar.show("Task $index Completed.");
    });
  }


  Future<void> FinalSubmission() async {
    // AppLoader.show();

    try {
      NetworkResponse response = await NetworkCaller().postRequest(
        url: urls.adultTaskSubmit,
        body: {"tasks": finalResult, "timeSpent": seconds.value},
      );
      // AppLoader.hide();

      if (response.statusCode == 201 &&
          response.responseData != null &&
          response.responseData?['success'] == true) {
        listComplete[4] = false;
      } else {
        print("Error submitting final answers ❌");
        print("Server message: ${response.responseData?['message'] ?? response.errorMessage}");
      }
    } catch (e) {
      AppLoader.hide();
      print("HTTP Error: $e");
    }


  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }


  String get formattedTime {
    final h = (seconds.value ~/ 3600).toString().padLeft(2, '0');
    final m = ((seconds.value % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (seconds.value % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }






  //=================== Timer Section ==========================================
  Timer? _timer;

  // This variable stores seconds
  RxInt seconds = 0.obs;

  /// Start Timer
  void startTimer() {
    stopTimer(); // Prevent multiple timers

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds.value++;
    });
  }

  /// Stop Timer
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// Reset Timer
  void resetTimer() {
    stopTimer();
    seconds.value = 0;
  }

  /// Get current seconds value
  int get currentSeconds => seconds.value;

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }
}
