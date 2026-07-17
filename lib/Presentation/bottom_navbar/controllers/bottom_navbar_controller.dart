import 'package:get/get.dart';
import '../../Features/home/controller/home_controller.dart';
import '../../../../App/assets_path.dart';
import '../../Features/Subcription/Controller/Controller.dart';

class BottomNavbarController extends GetxController {
  final selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;

    // Pause or play music based on the active tab
    try {
      final homeController = Get.find<HomeController>();
      if (index == 0) {
        // Tab 0 is Home Screen
        homeController.music.play(AssetsPath.homeMusic);
      } else {
        homeController.music.stop();
      }

      // Auto restore silently when switching to subscription screen
      if (index == 3) {
        if (Get.isRegistered<subscriptionController>()) {
          Get.find<subscriptionController>().restorePurchasesSilently();
        }
      }
    } catch (e) {
      // HomeController might not be initialized yet
    }
  }
}
