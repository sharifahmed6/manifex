import 'package:get/get.dart';
import 'package:manifex/Core/MusicService.dart';

import '../../../../../../Core/snakbar.dart';

class AFHandwritingController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    MusicService().play();  // 🎵 music starts when page opens
    print("TracingController INIT");
  }

  @override
  void onClose() {
    MusicService().stop();  // ⛔ music stops when page closes
    print("TracingController CLOSED");
    super.onClose();
  }




}