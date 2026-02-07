import 'dart:async';
import 'dart:ffi';
import 'package:get/get.dart';

class InteractiveReadingController extends GetxController {
  final totalDuration = Duration.zero.obs;
  final tick = 0.obs;
 Timer? _timer;
 final isRunning = false.obs;
 DateTime? _dateTime;
 final allAnswerSubmit = false.obs;
 Duration get currentTime {
   if(isRunning.value && _dateTime != null){
     return totalDuration.value + DateTime.now().difference(_dateTime!);
   }
   return totalDuration.value;
 }
 // Task Marks start
  final task1 = ''.obs;
  final  task2 = 0.0.obs;
  final task3 = ''.obs;
  final task4 = ''.obs;
 // Task Marks end
 /// Lock Skill Start
  final t1Done = true.obs;
  final t2Done = false.obs;
  final t3Done = false.obs;
  final t4Done = false.obs;
  final t1SkillLock = true.obs;
  final t2SkillLock = true.obs;
  final t3SkillLock = true.obs;
  final t4SkillLock = true.obs;
  /// Lock Skill end
  @override
  void onInit() {
    super.onInit();
    start();
  }
void start(){
   if(isRunning.value) return;
   isRunning.value = true;
   _dateTime = DateTime.now();
   _timer = Timer.periodic(const Duration(seconds: 1), (_){
     tick.value++;
   });
}
void stop(){
   if(!isRunning.value) return;
   final now = DateTime.now();
   final session = now.difference(_dateTime!);
   totalDuration.value = totalDuration.value + session;
   _timer?.cancel();
   _timer = null;
   isRunning.value = false;
   _dateTime = null;
}
  String format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return '${two(h)}:${two(m)}:${two(s)}';
  }


  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
    print('Controller closed');
  }
}