import 'package:get/get.dart';

class wordPartsWorkshopController extends GetxController {

  var currentIndex = 0.obs;

  var data = {
    "suffix": [
      "tion",
      "ness"
    ],
    "root": [
      "act",
      "un"
    ],
    "prefix": [
      "re",
      "un"
    ],
    "suffix_meaning": [
      "the act of",
      "state of"
    ],
    "root_meaning": [
      "to do",
      "not"
    ],
    "prefix_meaning": [
      "again",
      "not"
    ]
  };
}