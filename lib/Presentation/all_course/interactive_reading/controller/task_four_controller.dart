import 'package:get/get.dart';

class TaskFourController extends GetxController {
  final readingData = <Map<String, dynamic>>[
    {
      "title": "Tom’s Adventure",
      "passages": [
        "Tom has a red ball. He likes to play with it in the park.",
        "The ball is very bouncy. Tom throws it high up in the air.",
        "His dog Max runs to catch the ball. They play together every day.",
      ],
      "image": "https://res.cloudinary.com/dd0ryfgtu/image/upload/v1770024350/ab035381f98d3701f9a9988d93ac8998bd1b1a34_1_movedp.png",
      "questions": [
        {
          "questionNo": 1,
          "question": "What color is Tom’s ball?",
          "options": ["Blue", "Red", "Green"],
          "correctIndex": 1,
        },
        {
          "questionNo": 2,
          "question": "What is the dog’s name?",
          "options": ["Max", "Rex", "Buddy"],
          "correctIndex": 0,
        },
      ],
    },
  ].obs;

  /// questionIndex -> selectedOptionIndex
  final RxMap<int, int> selectedAnswers = <int, int>{}.obs;

  void selectOption(int questionIndex, int optionIndex) {
    selectedAnswers[questionIndex] = optionIndex;
    selectedAnswers.refresh();
  }
}
