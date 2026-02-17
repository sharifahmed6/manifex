import 'package:get/get.dart';

import '../../../../../../Core/snakbar.dart';

class wordPartsWorkshopController extends GetxController {
  var currentIndex = 0.obs;

  var data = {
    "suffix": ["less", "ness", "ify"],
    "root": ["ject", "struct", "scribe"],
    "prefix": ["pre", "mis", "bi"],
    "suffix_meaning": ["without", "state of being", "to make"],
    "root_meaning": ["throw", "build", "write"],
    "prefix_meaning": ["before", "wrongly", "two"],
  };

  void nextWord() {
    if (currentIndex.value < (data['suffix'] as List).length - 1) {
      currentIndex++;
    }else{
      AppSnackbar.show("No more words left.");
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
}
