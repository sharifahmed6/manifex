import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../App/Urls.dart';
import '../../../../App/network_caller.dart';

class NativeSpeakingSkillController extends GetxController {
  final score = 0.obs;
  final isLoading = false.obs;
  final taskOneScore = 0.obs;
  final taskTwoScore = 0.obs;
  final taskThreeScore = 0.obs;
  final taskFourScore = 0.obs;

  // Timer variables
  final totalDuration = Duration.zero.obs;
  final tick = 0.obs;
  Timer? _timer;
  final isRunning = false.obs;
  DateTime? _dateTime;

  Duration get currentTime {
    if (isRunning.value && _dateTime != null) {
      return totalDuration.value + DateTime.now().difference(_dateTime!);
    }
    return totalDuration.value;
  }

  // ── Lock flags (true = locked, false = unlocked) ─────────────────────────
  // t*Done controls whether the NEXT task's card is locked
  final t1Done = false.obs;
  final t2Done = true.obs;
  final t3Done = true.obs;
  final t4Done = true.obs;

  // ── Completion flags (true = card shows button/logo, false = card complete) ─
  // These match the isComplete param of SingleSkillCard
  final t1Complete = true.obs;
  final t2Complete = true.obs;
  final t3Complete = true.obs;
  final t4Complete = true.obs;

  // Submit button visibility
  final allTasksDone = false.obs;

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

  Future<void> nativeSpeakingAnsSubmit() async {
    final seconds = currentTime.inSeconds;
    try {
      isLoading.value = true;
      NetworkResponse response = await NetworkCaller().postRequest(
        url: urls.readingTaskComplete,
        body: {
          "sessionName": "Speaking",
          "tasks": [
            {
              "taskName": "Task 1",
              "marks": taskOneScore.value.round(),
              "isAnswer": true,
            },
            {
              "taskName": "Task 2",
              "marks": taskTwoScore.value.round(),
              "isAnswer": true,
            },
            {
              "taskName": "Task 3",
              "marks": taskThreeScore.value.round(),
              "isAnswer": true,
            },
            {
              "taskName": "Task 4",
              "marks": taskFourScore.value.round(),
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
            titleText: Text(
              "Success".tr,
              style: const TextStyle(color: Colors.white),
            ),
            message: message,
            duration: Duration(seconds: 4),
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
          ),
        );
        stop();
      } else {
        final message = response.responseData?['message'];
        Get.back();
        Get.showSnackbar(
          GetSnackBar(
            titleText: Text(
              "Error".tr,
              style: const TextStyle(color: Colors.white),
            ),
            message: message,
            duration: Duration(seconds: 4),
            backgroundColor: Colors.red,
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

  // Progress counter — how many tasks finished (0–4)
  final currentTask = 0.obs;

  // ── Call after finishing each task ─────────────────────────────────────
  void checkAllComplete() {
    int done = 0;
    if (!t1Complete.value) done++;
    if (!t2Complete.value) done++;
    if (!t3Complete.value) done++;
    if (!t4Complete.value) done++;
    if (done > 4) done = 4;
    currentTask.value = done;
    allTasksDone.value = (done >= 4);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
