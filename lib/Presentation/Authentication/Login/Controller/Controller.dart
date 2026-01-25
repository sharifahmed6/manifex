import 'package:get/get.dart';
import 'package:manifex/App/routes.dart';

class login_controller extends GetxController {
  var password = true.obs;
  var isRemeber = true.obs;

  void route_forget_password() => Get.toNamed(routes.find_account_screen);


}