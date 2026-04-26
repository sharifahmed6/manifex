import 'package:get/get.dart';
import 'package:manifex/App/assets_path.dart';
import 'package:manifex/Core/MusicService.dart';

class AFHandwritingController extends GetxController {
  var isCursive = false.obs;

  @override
  void onInit() {
    super.onInit();
    MusicService().play();
  }

  @override
  void onClose() {
    super.onClose();
    // Removed MusicService().stop() to allow smooth transition to Home Screen
  }
}
