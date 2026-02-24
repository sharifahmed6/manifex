import 'package:get/get.dart';
import 'package:manifex/Core/MusicService.dart';

import '../../../../../../Core/snakbar.dart';

class AFHandwritingController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    MusicService().play();
    print("TracingController INIT");
  }

  @override
  void onClose() {
    super.onClose();
    MusicService().stop();
    print("TracingController CLOSED");
  }




}