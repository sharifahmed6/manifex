import 'package:get/get.dart';

import '../../../../../../Core/snakbar.dart';

class phraseMakerController extends GetxController {
  var phrases = [
    ["across", "the", "street"],
    ["extremely", "busy"],
    ["playing", "outside"],
    ["in", "the", "library"],
    ["under", "the", "table"],
  ];

  var currentIndex = 0.obs;
  var isAnswerCorrect = false.obs;

  RxList<String> words = <String>[].obs;
  RxList<String> selectedWords = <String>[].obs;

  List<String> get finalWords => selectedWords;

  void nextPhrase() {
    if (currentIndex.value < phrases.length - 1) {
      currentIndex.value++;
      loadWords();
    }
  }

  void toggleWord(String word) {
    if (selectedWords.contains(word)) {
      selectedWords.remove(word);
    } else {
      selectedWords.add(word);
    }
  }

  bool isSelected(String word) {
    return selectedWords.contains(word);
  }

  void submit(){
    if(selectedWords.isEmpty){
      AppSnackbar.show("Please select answer.");
    }else{
      if(selectedWords.toString() == phrases[currentIndex.value].toString()){
        AppSnackbar.show("Correct");
        nextWord();
      }else{
        AppSnackbar.show("Incorrect");
        nextWord();
      }
    }
  }


  @override
  void onInit() {
    super.onInit();
    loadWords();
    ever(currentIndex, (_) {
      loadWords();
    });
  }

  void loadWords() {
    final list = (phrases[currentIndex.value] as List).cast<String>();

    words.value = List<String>.from(list)..shuffle();

    selectedWords.clear();
  }


  void nextWord() {
    if (currentIndex.value < phrases.length - 1) {
      selectedWords.clear();
      currentIndex++;
    }else{
      AppSnackbar.show("No more words left.");
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      selectedWords.clear();
      currentIndex--;
    }else{
      AppSnackbar.show("No more words left.");
    }
  }



}
