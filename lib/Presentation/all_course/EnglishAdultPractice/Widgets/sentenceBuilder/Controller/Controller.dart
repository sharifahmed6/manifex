import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import 'package:http/http.dart' as http;

import '../Model/Model.dart';
class sentenceBuilderController extends GetxController {
  RxList<SentenceModel> sentences = <SentenceModel>[].obs;
  var currentIndex = 0.obs;

  // Words displayed shuffled
  RxList<String> words = <String>[].obs;

  // Words selected by user
  RxList<String> selectedWords = <String>[].obs;

  // Get final sentence text
  String get finalSentence => selectedWords.join(" ");

  @override
  void onReady() {
    super.onReady();
    getSentenceBuilder();
  }

  Future<void> getSentenceBuilder() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse(
        "https://ai.manifex.org/api/v1/adult/phrase-maker/get_phrases?user_id=$userId");

    try {
      Get.dialog(
        barrierDismissible: false,
        CustomCircleProgressIndicator(),
      );
      final response = await http.get(url, headers: {'authtoken': '1'});
      if (Get.isDialogOpen ?? false) Get.back();

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<SentenceModel> parsed = (decoded['phrases'] as List)
            .map((e) => SentenceModel.fromJson(e))
            .toList();
        sentences.assignAll(parsed);

        // Load first sentence
        loadWords();
      } else {
        AppSnackbar.show("Failed to load phrases.");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      AppSnackbar.show("Something went wrong.");
      print("HTTP Error: $e");
    }
  }

  void loadWords() {
    if (sentences.isEmpty) return;

    // Shuffle the words so user sees a random order
    words.value = List<String>.from(sentences[currentIndex.value].phraseOptions)
      ..shuffle();

    // Clear previously selected words
    selectedWords.clear();
  }

  void toggleWord(String word) {
    if (selectedWords.contains(word)) {
      selectedWords.remove(word);
    } else {
      selectedWords.add(word);
    }
  }

  bool isSelected(String word) => selectedWords.contains(word);

  void nextSentence() {
    if (currentIndex.value < sentences.length - 1) {
      currentIndex.value++;
      loadWords();
    } else {
      AppSnackbar.show("No more sentences left.");
    }
  }

  void previousSentence() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      loadWords();
    } else {
      AppSnackbar.show("No previous sentence.");
    }
  }

  void submit() {
    if (selectedWords.isEmpty) {
      AppSnackbar.show("Please build the sentence first.");
      return;
    }

    final correct = selectedWords.join(" ") ==
        sentences[currentIndex.value].phrase;

    if (correct) {
      AppSnackbar.show("Correct");
    } else {
      AppSnackbar.show("Incorrect");
    }
  }

}
