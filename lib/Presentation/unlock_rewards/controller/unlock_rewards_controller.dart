import 'package:get/get.dart';

class UnlockRewardsController extends GetxController{
  final progress = 0.obs;

  final tasks = <String>[
    "Daily reading practice",
    "Daily speaking practice",
    "Daily writing exercise",
    "Daily vocabulary challenge",
  ];

  int get completedCount => progress.value.clamp(0, 4);
  bool get unlocked => completedCount >= 4;

  bool taskDone(int index) => completedCount >= (index + 1);
  void completeNext() {
    if (progress.value < 4) progress.value++;
  }

  void reset() => progress.value = 0;
}
