import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../App/network_caller.dart';

class SmartWritingController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();

  final selectedValue = ''.obs;

  // UI states
  final inProgress = false.obs;
  final isLoadingItem = false.obs;
  final isLoadingRelated = false.obs;
  final isSubmitting = false.obs;

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
  }

  @override
  void onClose() {
    writingController.dispose();
    super.onClose();
  }

  // GET categories
  Future<void> fetchCategories() async {
    try {
      isLoadingItem.value = true;

      final response = await networkCaller.getRequest(
        // remove space: user_id=test
        url: "https://ai.manifex.org/api/v1/writing/category?age=1&user_id=test",
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

    await fetchRelatedWords(topic: value, age: "6");
  }
  
  Future<void> fetchRelatedWords({
    required String topic,
    required String age,
  }) async {
    try {
      isLoadingRelated.value = true;

      final res = await networkCaller.postRequest(
        url: "https://ai.manifex.org/api/v1/writing/topic?user_id=test",
        body: {"topic": topic, "age": age},
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
        colorText: Colors.white
      );
      return;
    }
    if (paragraph.isEmpty) {
      Get.snackbar(
        "Write Something",
        "Please write something in the box",
        snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withAlpha(200),
          colorText: Colors.white
      );
      return;
    }

    try {
      isSubmitting.value = true;

      final body = {
        "topic": topic,
        "related_words": relatedWords.toList(),
        "user_paragraph": paragraph,
      };

      final res = await networkCaller.postRequest(
        url: "https://ai.manifex.org/api/v1/writing/final",
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
      // ✅ response: { sentence_score: 10, motivation: "..." }
      final s = json["sentence_score"];
      final m = json["motivation"];

      score.value = (s is int) ? s : int.tryParse(s.toString()) ?? 0;
      motivation.value = (m ?? "").toString();

      inProgress.value = true;
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
}
