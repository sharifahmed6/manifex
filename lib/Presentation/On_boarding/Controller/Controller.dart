import 'package:get/get.dart';

class on_boarding_controller extends GetxController {
  var page_index = 0.obs;

  void change_page(int index) {
    page_index.value = index;
  }

}