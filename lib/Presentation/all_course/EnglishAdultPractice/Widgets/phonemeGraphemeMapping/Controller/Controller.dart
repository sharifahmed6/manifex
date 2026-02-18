import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import 'package:http/http.dart' as http;
import '../../../Controller/Controller.dart';
import '../Model/Model.dart';

class phonemeGraphemeMappingController extends GetxController {

  RxInt currentIndex = 0.obs;
  RxList<ExerciseModel> exercises = <ExerciseModel>[].obs;
  RxList<String> selectedWords = <String>[].obs;
  var correctWord = 0.obs;


  List<String> get words =>
      exercises.isNotEmpty
          ? exercises[currentIndex.value].options
          : [];

  void toggleWord(String word) {
    if (selectedWords.contains(word)) {
      selectedWords.remove(word);
    } else {
      selectedWords.add(word);
    }
  }

  bool isSelected(String word) =>
      selectedWords.contains(word);

  String get combinedText =>
      selectedWords.join();

  void nextWord() {
    if (currentIndex.value < exercises.length - 1) {
      selectedWords.clear();
      currentIndex.value++;
    } else {
      double result = (correctWord.value / exercises.length) * 100;
      final practiceController =
      Get.find<EnglishAdultPracticeController>();
      practiceController.finalResult[1]['marks'] = result;
      practiceController.unLockTask(2);

      AppSnackbar.show("Task 2 Completed");
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.back();
      });
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      selectedWords.clear();
      currentIndex.value--;
    } else {
      AppSnackbar.show("No more words left.");
    }
  }

  @override
  void onReady() {
    super.onReady();
    getPhoneme();
  }

  Future<void> getPhoneme() async {
    final userId = PrefHelper.getUserId().toString();

    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/adult/phenome-mapping/get_phenome_mapping?user_id=$userId",
    );

    try {
      Get.dialog(
        CustomCircleProgressIndicator(),
        barrierDismissible: false,
      );

      final response = await http.get(
        url,
        headers: {'authtoken': '1'},
      );

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final List<ExerciseModel> parsedList =
        (decoded['exercises'] as List)
            .map((e) => ExerciseModel.fromJson(e))
            .toList();

        exercises.assignAll(parsedList);
        print("Parsed Data: ${exercises.toString()}");


        currentIndex.value = 0;
        selectedWords.clear();
      } else {
        AppSnackbar.show("Failed to load exercises");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackbar.show("Something went wrong");
      print("HTTP Error: $e");
    }
  }

}
