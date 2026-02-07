import 'package:get/get.dart';
import '../../../../App/network_caller.dart';
import '../model/sight_word_model.dart';
import 'interactive_reading_controller.dart';

class SightWordController extends GetxController {
  final interactiveController = Get.find<InteractiveReadingController>();
  final NetworkCaller networkCaller = NetworkCaller();

  final isLoading = false.obs;
  final error = ''.obs;

  final items = <SightWordItem>[].obs;

  final currentIndex = 0.obs;
  final selectedIndex = (-1).obs;
  final isAnswered = false.obs;

  final correctCount = 0.obs;
  final percent = 0.0.obs;

  int get total => items.length;
  SightWordItem get current => items[currentIndex.value];
  bool get isLast => currentIndex.value == total - 1;

  double get progressOutOf100 {
    if (total == 0) return 0;
    final step = 100 / total;
    final value = correctCount.value * step;
    return value.clamp(0, 100);
  }
  String get progressText {
    final v = progressOutOf100.round();
    return v.toString().padLeft(2, '0');
  }
  @override
  void onReady() {
    super.onReady();
    loadSightWords(userId: "test");
  }

  Future<void> loadSightWords({required String userId}) async {
    try {
      isLoading.value = true;
      error.value = '';

      final res = await networkCaller.postRequest(
        url:
        "https://ai.manifex.org/api/v1/reading/sight-word-practice/sight_words?user_id=$userId",
        body: {
          'age': '6',
        },
        removeAuthorization: true,
        extraHeaders: const {"authtoken": "1"},
      );

      if (!res.isSuccess) {
        error.value = res.errorMessage;
        return;
      }

      final data = res.responseData;
      final List list = (data?['response'] is List) ? data!['response'] : [];

      items.value = list.map((e) => SightWordItem.fromJson(e)).toList();

      // reset
      currentIndex.value = 0;
      selectedIndex.value = -1;
      isAnswered.value = false;
      correctCount.value = 0;
      percent.value = 0;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void selectOption(int index) {
    if (isAnswered.value) return;

    selectedIndex.value = index;
    isAnswered.value = true;

    final ci = current.correctIndexSafe();
    if (ci != -1 && index == ci) {
      correctCount.value++;
    }
  }

  void nextOrFinish() {
    if (!isAnswered.value) return;

    if (isLast) {
      percent.value = total == 0 ? 0 : (correctCount.value / total) * 100;

      Get.back();
      interactiveController.task2.value = percent.value;
      return;
    }

    currentIndex.value++;
    selectedIndex.value = -1;
    isAnswered.value = false;
  }
}
