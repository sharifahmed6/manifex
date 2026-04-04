import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../../Core/SharepreferenceHelper.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import 'package:http/http.dart' as http;
import '../../../Controller/Controller.dart';
import '../Model/Model.dart';

class phraseMakerController extends GetxController {
  RxList<PhraseModel> phrases = <PhraseModel>[].obs;
  var currentIndex = 0.obs;
  RxList<String> words = <String>[].obs;
  RxList<String> selectedWords = <String>[].obs;
  int correctSentence = 0;

  @override
  void onReady() {
    super.onReady();
    getPhaseMaker();
  }

  // API call
  Future<void> getPhaseMaker() async {
    final userId = PrefHelper.getUserId().toString();
    final url = Uri.parse(
        "https://ai.manifex.org/api/v1/adult/phrase-maker/get_phrases?user_id=$userId");

    try {
      Get.dialog(
          barrierDismissible: false, CustomCircleProgressIndicator());
      final response = await http.get(url, headers: {'authtoken': '1'});
      if (Get.isDialogOpen ?? false) Get.back();

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<PhraseModel> parsedList = (decoded['phrases'] as List)
            .map((e) => PhraseModel.fromJson(e))
            .toList();
        phrases.assignAll(parsedList);

        // Load first phrase and shuffle
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

  // Load current phrase words and shuffle
  void loadWords() {
    if (phrases.isEmpty) return;

    final current = phrases[currentIndex.value];

    // Make a fresh copy and shuffle
    final List<String> shuffled = List<String>.from(current.phraseOptions);
    shuffled.shuffle();

    // Assign to RxList
    words.assignAll(shuffled);

    // Clear selected words
    selectedWords.clear();

    print("Shuffled Words: $shuffled"); // ✅ debug
  }

  // Toggle word selection
  void toggleWord(String word) {
    if (selectedWords.contains(word)) {
      selectedWords.remove(word);
    } else {
      selectedWords.add(word);
    }
  }

  bool isSelected(String word) => selectedWords.contains(word);

  // Submit answer
  void submit() {
    if (selectedWords.isEmpty) {
      AppSnackbar.show("Please select an answer.");
      return;
    }

    final currentPhrase =
    phrases[currentIndex.value].phraseOptions.join(" ");

    final selectedPhrase = selectedWords.join(" ");

    if (currentPhrase == selectedPhrase) {
      correctSentence++;
      AppSnackbar.show("Correct");
    } else {
      AppSnackbar.show("Incorrect");
    }
    nextPhrase();
  }

  // Next phrase
  void nextPhrase() {
    if (currentIndex.value < phrases.length - 1) {
      currentIndex.value++;
      loadWords();
    } else {
      double result = (correctSentence / phrases.length) * 100;
      final practiceController =  Get.find<EnglishAdultPracticeController>();
      practiceController.finalResult[4]['marks'] = result;
      practiceController.unLockTask(5);
    }
  }

  // Previous phrase
  void previousPhrase() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      loadWords(); // shuffle previous phrase
    } else {
      AppSnackbar.show("No previous phrases.");
    }
  }
}
