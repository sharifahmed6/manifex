import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import 'package:http/http.dart' as http;
import '../../../Controller/Controller.dart';
import '../Model/Model.dart';

class wordPartsWorkshopController extends GetxController {
  var currentIndex = 0.obs;

  void nextWord() {
    final wp = wordParts.value;

    if (wp == null) return;

    if (currentIndex.value < wp.suffix.length - 1) {
      currentIndex.value++;
      return;
    } else {
      final practiceController =
      Get.find<EnglishAdultPracticeController>();
      practiceController.finalResult[3]['marks'] = 100;
      practiceController.unLockTask(4);

      print("Final Result: ${practiceController.finalResult}");

      AppSnackbar.show("Task 4 Completed");

      Future.delayed(const Duration(milliseconds: 200), () {
        Get.back();
      });
      return;
    }
  }


  void previousWord() {
    if (currentIndex.value > 0) {
      currentIndex--;
    }else{
      AppSnackbar.show("No more words left.");
    }
  }

  void submit() {
    nextWord();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getWordParts();
    super.onReady();
  }
  Rxn<WordPartsModel> wordParts = Rxn<WordPartsModel>();

  Future<void> getWordParts() async {
    final userId = PrefHelper.getUserId().toString();

    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/adult/word-parts-workshop/get_word_parts?user_id=$userId",
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

      if (Get.isDialogOpen ?? false) Get.back();

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // ✅ Parse into model
        wordParts.value = WordPartsModel.fromJson(decoded);

        print("Parsed Data: ${wordParts.value}");
      } else {
        AppSnackbar.show("Failed to load word parts");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      AppSnackbar.show("Something went wrong");
      print("HTTP Error: $e");
    }
  }

}
