import 'package:get/get.dart';
import 'package:manifex/Core/MusicService.dart';

class WritingTaskController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    MusicService().play();
  }

  @override
  void onClose() {
    super.onClose();
    MusicService().stop();
  }
}
