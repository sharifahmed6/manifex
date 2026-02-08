import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import '../../../../App/network_caller.dart';
import '../model/reading_quiz_model.dart';
import 'interactive_reading_controller.dart';

class TaskFourController extends GetxController {
  final interactiveController = Get.find<InteractiveReadingController>();
  final NetworkCaller networkCaller = NetworkCaller();
  final age = '6';
  final isLoading = false.obs;
  final error = ''.obs;

  final data = Rxn<ReadingQuizData>();

  /// questionIndex -> selectedOptionIndex
  final RxMap<int, int> selectedAnswers = <int, int>{}.obs;

  final isSubmitted = false.obs;
  final correctCount = 0.obs;
  final percent = 0.0.obs;

  int get total => data.value?.questions.length ?? 0;

  bool get allAnswered => total > 0 && selectedAnswers.length == total;
  @override
  void onInit() {
    super.onInit();
    load();
  }
  Future<void> load() async {
    try {
      isLoading.value = true;
      error.value = '';

      final res = await networkCaller.getRequest(
          url: urls.aiQuestion(age),
        removeAuthorization: true,
        extraHeaders: {'authtoken': '1'}
      );

      if (!res.isSuccess || res.responseData == null) {
        error.value = res.errorMessage;
        return;
      }

      data.value = ReadingQuizData.fromJson(res.responseData!);

      // reset
      selectedAnswers.clear();
      selectedAnswers.refresh();
      isSubmitted.value = false;
      correctCount.value = 0;
      interactiveController.task4.value = 0;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void selectOption(int questionIndex, int optionIndex) {
    selectedAnswers[questionIndex] = optionIndex;
    selectedAnswers.refresh();
  }

  void submitNext() {
    if (!allAnswered) return;

    final d = data.value;
    if (d == null) return;

    int correct = 0;
    for (int i = 0; i < d.questions.length; i++) {
      final q = d.questions[i];
      final selected = selectedAnswers[i];
      if (selected != null && selected == q.correctIndex) {
        correct++;
      }
    }

    correctCount.value = correct;
    interactiveController.task4.value = total == 0 ? 0.0 : (correct / total) * 100.0;
    isSubmitted.value = true;
  }

  String get scoreText =>
      "${correctCount.value} of ${total}";
}
