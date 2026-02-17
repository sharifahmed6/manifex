import 'package:get/get.dart';

import '../../../../../../Core/snakbar.dart';

class wordFlashController extends GetxController {
  var currentIndex = 0.obs;
  var words = [
  "exacerbate",
  "ubiquitous",
  "perspicacious",
  "ephemeral",
  "idiosyncratic"
  ];

  void nextWord() {
    if (currentIndex.value < words.length - 1) {
      // selectedWords.clear();
      currentIndex++;
    }else{
      AppSnackbar.show("No more words left.");
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      // selectedWords.clear();
      currentIndex--;
    }else{
      AppSnackbar.show("No more words left.");
    }
  }

}