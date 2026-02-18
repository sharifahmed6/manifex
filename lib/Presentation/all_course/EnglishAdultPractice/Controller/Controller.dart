import 'package:get/get.dart';

class EnglishAdultPracticeController extends GetxController {
  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;

  var listLock = [false, false, false, false].obs;
  var listComplete = [true, true, true, true].obs;

  var finalResult = [
    {"taskName": "Task 1", "marks": 0, "isAnswer": true},
    {"taskName": "Task 2", "marks": 0, "isAnswer": true},
    {"taskName": "Task 3", "marks": 0, "isAnswer": true},
    {"taskName": "Task 4", "marks": 0, "isAnswer": true},
    {"taskName": "Task 5", "marks": 0, "isAnswer": true},
    {"taskName": "Task 6", "marks": 0, "isAnswer": true},
  ].obs;

  Future<void> unLockTask(int index) async {
    listLock[index] = false;
    listComplete[index - 1] = false;
  }

  void showFinalResult() {
    print("Final Result Length: ${finalResult.length}");
    print("Final Result: $finalResult");
  }
}
