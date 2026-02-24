import 'dart:async';

import 'package:get/get.dart';

class PracticesController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    startOneMinutePrinter();
    super.onInit();
  }

  Timer? _timer;

  void startOneMinutePrinter() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      print("Triggered after 1 minute");
    });
  }

}