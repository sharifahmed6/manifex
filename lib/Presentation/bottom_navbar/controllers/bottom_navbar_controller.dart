import 'package:get/get.dart';
import '../../Features/home/controller/home_controller.dart';

class BottomNavbarController extends GetxController {
  final selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;

    // Pause or play music based on the active tab
    try {
      final homeController = Get.find<HomeController>();
      if (index == 0) {
        // Tab 0 is Home Screen
        homeController.music.play();
      } else {
        homeController.music.stop();
      }
    } catch (e) {
      // HomeController might not be initialized yet
    }
  }
}
