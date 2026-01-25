import 'package:get/get.dart';

import '../../Change_password/View/Change_password.dart';


class OTP_verification_controller extends GetxController {
  var isResendCode = false.obs;


  Future<void> resent_code() async {
    //TODO: Handle resent otp code
  }

  Future<void> verify_otp(String OTP_CODE, String email) async {
    //TODO: Handle otp verification
    Get.to(resent_password(email: email,));
  }

}