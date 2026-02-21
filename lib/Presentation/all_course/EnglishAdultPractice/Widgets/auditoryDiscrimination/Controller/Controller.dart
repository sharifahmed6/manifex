import 'dart:convert';

import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';

import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import 'package:http/http.dart' as http;

import '../../../Controller/Controller.dart';
class auditoryDiscriminationController extends GetxController {
  var word_pairs = [
    {
      "word1": "box",
      "word2": "bog",
      "answer": "different",
      "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_0_1066.mp3",
      "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_1_4760.mp3",
    },
    {
      "word1": "sun",
      "word2": "son",
      "answer": "different",
      "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_2_4582.mp3",
      "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_3_8847.mp3",
    },
    {
      "word1": "man",
      "word2": "men",
      "answer": "different",
      "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_4_7541.mp3",
      "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_5_257.mp3",
    },
    {
      "word1": "bug",
      "word2": "bag",
      "answer": "different",
      "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_6_5032.mp3",
      "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_7_3374.mp3",
    },
    {
      "word1": "bat",
      "word2": "bat",
      "answer": "same",
      "audio_file1": "http://127.0.0.1:8061/temp_audio/word_pair_8_9667.mp3",
      "audio_file2": "http://127.0.0.1:8061/temp_audio/word_pair_8_9667.mp3",
    },
  ].obs;
  var correctWord = 0.obs;

  @override
  void onReady() {
    getAuditory();
    super.onReady();
  }


  Future<void> getAuditory() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse(
      "https://ai.manifex.org/api/v1/adult/auditory-discrimination/get_auditory_discrimination?user_id=$userId",
    );

    try {
      Get.dialog(
          barrierDismissible: false,
          CustomCircleProgressIndicator()
      );
      final response = await http.get(
        url,
        headers: {
          'authtoken': '1',
        },
      );
      Get.back();

      print("Status Code: ${response.statusCode}");
      print("Raw Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // decoded['word_pairs'] is List<dynamic>
        final List<Map<String, String>> parsedList = (decoded['word_pairs'] as List<dynamic>)
            .map((e) => Map<String, String>.from(e))
            .toList();

        // Assign to your RxList
        word_pairs.assignAll(parsedList);

        print("Parsed Data: ${word_pairs}");
      }

      else {
        print("Server returned error: ${response.statusCode}");
      }
    } catch (e) {
      print("HTTP Error: $e");
    }
  }


  var currentIndex = 0.obs;
  var finalAnswer = "".obs;

  void nextWord() {
    if (currentIndex.value < word_pairs.length - 1) {
      finalAnswer.value = "";
      currentIndex.value++;
    } else {

      AppSnackbar.show("No more words left.");
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      finalAnswer.value = "";
      currentIndex.value--;
    } else {
      AppSnackbar.show("No more words left.");
    }
  }

  void submit() {
    if (finalAnswer.value.isNotEmpty) {
      checkAnswer();
    } else {
      AppSnackbar.show("Please select answer.");
    }
  }

  void checkAnswer() {
    bool isCorrect =
        finalAnswer.value == word_pairs[currentIndex.value]['answer'];

    if (isCorrect) {
      AppSnackbar.show("Correct");
      correctWord.value++;
    } else {
      AppSnackbar.show("Incorrect");
    }

    finalAnswer.value = "";

    bool isLast = currentIndex.value == word_pairs.length - 1;

    if (isLast) {
      double result =
          (correctWord.value / word_pairs.length) * 100;

      final practiceController =
      Get.find<EnglishAdultPracticeController>();

      practiceController.unLockTask(1);
      practiceController.finalResult[0]['marks'] = result;

      AppSnackbar.show("Task 1 Completed.");

      Future.delayed(const Duration(milliseconds: 300), () {
        Get.back();
      });

      return; // stop execution
    }

    nextWord();
  }

}
