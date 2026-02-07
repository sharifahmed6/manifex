import 'package:get/get.dart';
import '../../../../App/network_caller.dart';
import '../model/reading_quiz_model.dart';

class TaskFourController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();

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
  void onReady() {
    super.onReady();
    load(age: 5);
  }

  Future<void> load({required int age}) async {
    try {
      isLoading.value = true;
      error.value = '';

      final url =
          "https://ai.manifex.org/api/v1/reading/comprehension/generate_comprehension?age=$age";

      final res = await networkCaller.getRequest(
          url: url,
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
      percent.value = 0;
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

  /// ✅ user সব answer select করার পর Next চাপলে score বের হবে
  void submitNext() {
    if (!allAnswered) return;

    final d = data.value;
    if (d == null) return;
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
    percent.value = total == 0 ? 0 : (correct / total) * 100;
    isSubmitted.value = true;
  }

  String get scoreText =>
      "${correctCount.value} of ${total}";
}
