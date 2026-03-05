import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/Core/MusicService.dart';
import '../../../../App/network_caller.dart';
import '../../../Features/home/controller/home_controller.dart';

class SmartWritingController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  final homeController = Get.find<HomeController>();
  final selectedValue = ''.obs;

  // UI states
  final inProgress = false.obs;
  final isLoadingItem = false.obs;
  final isLoadingRelated = false.obs;
  final isSubmitting = false.obs;

  // Timer variables
  final totalDuration = Duration.zero.obs;
  final second = 0.obs;
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

  // Progress variables
  final currentTask = 0.obs;

  // data lists
  final items = <String>[].obs;
  final relatedWords = <String>[].obs;
  final relatedWord = false.obs;

  // writing input
  final writingController = TextEditingController();

  // final result
  final score = 0.obs;
  final motivation = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    start();
    homeController.apiAge <= 13 ? null :MusicService().play();
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
    second.value = totalDuration.value.inSeconds;
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

  @override
  void onClose() {
    _timer?.cancel();
    writingController.dispose();
    MusicService().stop();
    super.onClose();
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingItem.value = true;

      final response = await networkCaller.getRequest(
        url: urls.smartWritingCategories(
          homeController.apiAge.toString(),
          homeController.userId,
        ),
        removeAuthorization: true,
        extraHeaders: {"authtoken": "1"},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!;
        final raw = data["categories"];
        final list = (raw is List)
            ? raw.map((e) => e.toString()).toList()
            : <String>[];
        items.assignAll(list);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingItem.value = false;
    }
  }

  Future<void> select(String value) async {
    selectedValue.value = value;
    writingController.clear();

    inProgress.value = false;
    score.value = 0;
    motivation.value = '';

    await fetchRelatedWords(topic: value);
  }

  Future<void> fetchRelatedWords({required String topic}) async {
    try {
      isLoadingRelated.value = true;

      final res = await networkCaller.postRequest(
        url: urls.relatedWord(homeController.userId),
        body: {"topic": topic, "age": "${homeController.apiAge}"},
        removeAuthorization: true,
        extraHeaders: {"authtoken": "1"},
      );

      if (!res.isSuccess || res.responseData == null) {
        relatedWords.clear();
        relatedWord.value = false;
        return;
      }

      final json = res.responseData!;
      final rawAny = json["related_words"];

      final parsed = (rawAny is List)
          ? rawAny.map((e) => e.toString()).toList()
          : <String>[];

      relatedWords.assignAll(parsed);

      relatedWord.value = relatedWords.isNotEmpty;
    } catch (_) {
      relatedWords.clear();
      relatedWord.value = false;
    } finally {
      isLoadingRelated.value = false;
    }
  }

  Future<void> submitFinalWriting() async {
    final topic = selectedValue.value.trim();
    final paragraph = writingController.text.trim();

    if (topic.isEmpty) {
      Get.snackbar(
        "Select Topic",
        "Please select a topic first",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
      return;
    }
    if (paragraph.isEmpty) {
      Get.snackbar(
        "Write Something",
        "Please write something in the box",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSubmitting.value = true;
      stop();

      final body = {
        "topic": topic,
        "related_words": relatedWords.toList(),
        "user_paragraph": paragraph,
        "timeSpent": second.value,
      };

      final res = await networkCaller.postRequest(
        url: urls.smartWriting,
        body: body,
        removeAuthorization: true,
        extraHeaders: {"authtoken": "1"},
      );

      if (!res.isSuccess || res.responseData == null) {
        Get.snackbar(
          "Error",
          res.errorMessage,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
      final json = res.responseData!;
      final s = json["sentence_score"];
      final m = json["motivation"];

      score.value = (s is int) ? s : int.tryParse(s.toString()) ?? 0;
      motivation.value = (m ?? "").toString();

      inProgress.value = true;
      currentTask.value = 1;
      await smartWritingDataSend();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> smartWritingDataSend() async {
    NetworkResponse response = await NetworkCaller().postRequest(
      url: urls.smartWritingDataSend,
      body: {"sentence_score": score.value, "motivation": motivation.value},
    );
    if (response.isSuccess) {
      print('success');
    }
  }
}
