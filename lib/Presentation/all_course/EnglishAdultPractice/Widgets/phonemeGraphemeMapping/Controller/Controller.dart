import 'package:get/get.dart';

import '../../../../../../Core/snakbar.dart';

class phonemeGraphemeMappingController extends GetxController {
  var currentIndex = 0.obs;

  var exercises = [
    {
      "word": "should",
      "word_url": "http://206.162.244.135:8061/temp_audio/word_0_2562.mp3",
      "options": ["sh", "ch", "s", "ou", "ow", "ld", "nd"],
    },
    {
      "word": "apple",
      "word_url": "http://206.162.244.135:8061/temp_audio/word_1_8196.mp3",
      "options": ["ap", "p", "le", "b", "ple", "a", "lp"],
    },
    {
      "word": "think",
      "word_url": "http://206.162.244.135:8061/temp_audio/word_2_8944.mp3",
      "options": ["th", "f", "i", "e", "nk", "ng", "ck"],
    },
    {
      "word": "green",
      "word_url": "http://206.162.244.135:8061/temp_audio/word_3_9244.mp3",
      "options": ["gr", "br", "ee", "ea", "n", "m", "en"],
    },
    {
      "word": "catch",
      "word_url": "http://206.162.244.135:8061/temp_audio/word_4_7663.mp3",
      "options": ["c", "k", "a", "e", "tch", "ch", "sh"],
    },
  ];

  List<String> get words => (exercises[currentIndex.value]['options'] as List).cast<String>();
  RxList<String> selectedWords = <String>[].obs;

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

  String get combinedText => selectedWords.join();

  void nextWord() {
    if (currentIndex.value < exercises.length - 1) {
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
