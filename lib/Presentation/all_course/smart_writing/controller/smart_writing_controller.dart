import 'package:get/get.dart';

class SmartWritingController extends GetxController {
  final selectedValue = ''.obs;

  final List<String> items = const [
    "Sports",
    "Dance",
    "Cooking",
    "Food",
    "Gaming",
    "Nature",
    "Travel",
    "Science",
    "Movies",
    "Meditation",
    "Music",
    "Art",
    "Animals",
  ];

  void select(String value) {
    selectedValue.value = value;
    print(selectedValue.value );
  }
}
