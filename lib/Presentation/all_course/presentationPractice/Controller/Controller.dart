import 'package:get/get.dart';

class presentationPracticeController extends GetxController {
  var selectedIndex = 0.obs;
  void changeTab(int index) => selectedIndex.value = index;

  var listLock = [false,true,true,true].obs;
  var listComplete = [true, true, true, true].obs;


}