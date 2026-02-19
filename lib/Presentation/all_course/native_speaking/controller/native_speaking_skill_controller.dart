import 'package:get/get.dart';

class NativeSpeakingSkillController extends GetxController {
  final score = 0.obs;

  final taskOneScore = 0.obs;
  final taskTwoScore = 0.obs;
  final taskThreeScore = 0.obs;
  final taskFourScore = 0.obs;

  // ── Lock flags (true = locked, false = unlocked) ─────────────────────────
  // t*Done controls whether the NEXT task's card is locked
  final t1Done = false.obs; // Task 1 always open
  final t2Done = true.obs; // Locked until Task 1 done
  final t3Done = true.obs;
  final t4Done = true.obs;

  // ── Completion flags (true = card shows button/logo, false = card complete) ─
  // These match the isComplete param of SingleSkillCard
  final t1Complete = true.obs;
  final t2Complete = true.obs;
  final t3Complete = true.obs;
  final t4Complete = true.obs;

  // Submit button visibility
  final allTasksDone = false.obs;

  // Progress counter — how many tasks finished (0–4)
  final currentTask = 0.obs;

  // ── Call after finishing each task ─────────────────────────────────────
  void checkAllComplete() {
    // Count tasks where isComplete went false = that task is finished
    int done = 0;
    if (!t1Complete.value) done++;
    if (!t2Complete.value) done++;
    if (!t3Complete.value) done++;
    if (!t4Complete.value) done++;
    if (done > 4) done = 4;
    currentTask.value = done;
    allTasksDone.value = (done >= 4);
  }
}
