
import 'package:get/get.dart';
import 'package:manifex/App/routes.dart';

class SplashController extends GetxController {
  final radius = 50.0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 100), () {
      radius.value = 110;
      Future.delayed(const Duration(milliseconds: 1600), () {
        //TODO: please handle your logic here
        Get.toNamed(routes.on_borading_screen);

      });
    });
  }
}