import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manifex/Core/MusicService.dart';

import '../../../../../../Core/snakbar.dart';

class AFHandwritingController extends GetxController  with WidgetsBindingObserver {
  var isCursive = true.obs;
  final music = MusicService();


  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    MusicService().play();
    print("TracingController INIT");
  }


  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    music.stop(); // 👈 stop when leaving page
    super.onClose();
  }

  // 👇 Detect app minimize / resume
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      music.stop(); // App minimized
    }

    if (state == AppLifecycleState.resumed) {
      music.play(); // Optional: resume when back
    }
  }
}
