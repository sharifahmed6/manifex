import 'dart:async';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';

class InteractiveReadingController extends GetxController {
  final isLoading = false.obs;
  final totalDuration = Duration.zero.obs;
  final tick = 0.obs;
  Timer? _timer;
  final isRunning = false.obs;
  DateTime? _dateTime;
  final allAnswerSubmit = false.obs;
  Duration get currentTime {
    if (isRunning.value && _dateTime != null) {
      return totalDuration.value + DateTime.now().difference(_dateTime!);
    }
    return totalDuration.value;
  }

  // Task Marks start
  final task1 = 0.obs;
  final task2 = 0.0.obs;
  final task3 = 0.0.obs;
  final task4 = 0.0.obs;
  // Task Marks end
  /// Lock Skill Start
  final t1Done = false.obs; // false = not locked (task 1 always open)
  final t2Done = true.obs; // true = locked (must complete t1 first)
  final t3Done = true.obs;
  final t4Done = true.obs;
  final t1SkillLock = true.obs; // true = isComplete (card visible/active)
  final t2SkillLock = true.obs;
  final t3SkillLock = true.obs;
  final t4SkillLock = true.obs;

  /// Lock Skill end

  /// Which task the user is currently on (1–4) — reflects completed task count
  final currentTask = 1.obs;

  /// Called whenever a task is completed — updates currentTask and allAnswerSubmit
  void checkAllComplete() {
    // Count tasks where SkillLock went false = the task ITSELF is finished
    // (t*Done = unlock flag for NEXT task; t*SkillLock = this task is complete)
    int done = 0;
    if (!t1SkillLock.value) done++;
    if (!t2SkillLock.value) done++;
    if (!t3SkillLock.value) done++;
    if (!t4SkillLock.value) done++;
    if (done > 4) done = 4;
    currentTask.value = done == 0 ? 1 : done;
    allAnswerSubmit.value = (done >= 4);
  }

  @override
  void onInit() {
    super.onInit();
    start();
  }

  void start() {
    if (isRunning.value) return;
    isRunning.value = true;
    _dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      tick.value++;
    });
  }

  void stop() {
    if (!isRunning.value) return;
    final now = DateTime.now();
    final session = now.difference(_dateTime!);
    totalDuration.value = totalDuration.value + session;
    _timer?.cancel();
    _timer = null;
    isRunning.value = false;
    _dateTime = null;
  }

  String format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return '${two(h)}:${two(m)}:${two(s)}';
  }

  Future<void> interactiveReadingAnsSubmit() async {
    final seconds = totalDuration.value.inSeconds;
    try {
      isLoading.value = true;
      NetworkResponse response = await NetworkCaller().postRequest(
        url: urls.readingTaskComplete,
        body: {
          "sessionName": "Reading",
          "tasks": [
            {
              "taskName": "Task 1",
              "marks": task1.value.round(),
              "isAnswer": true,
            },
            {
              "taskName": "Task 2",
              "marks": task2.value.round(),
              "isAnswer": true,
            },
            {
              "taskName": "Task 3",
              "marks": task3.value.round(),
              "isAnswer": true,
            },
            {
              "taskName": "Task 4",
              "marks": task4.value.round(),
              "isAnswer": true,
            },
          ],
          "timeSpent": seconds,
        },
      );
      if (response.isSuccess) {
        final message = response.responseData?['message'];
        Get.back();
        Get.showSnackbar(
          GetSnackBar(
            title: "Success",
            message: message,
            duration: Duration(seconds: 4),
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
          ),
        );
      } else {
        final message = response.responseData?['message'];
        Get.back();
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: message,
            duration: Duration(seconds: 4),
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
    print('Controller closed');
  }
}
