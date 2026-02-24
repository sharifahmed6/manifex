import 'package:get/get.dart';
import 'package:manifex/Core/MusicService.dart';

import '../../../../../../Core/snakbar.dart';

class AFHandwritingController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    MusicService().play();
    super.onInit();
  }

  @override
  void onClose() async {
    await MusicService().stop();
    await MusicService().dispose();
    print("On Close");
    super.onClose();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;




}