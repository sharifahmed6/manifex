import 'package:get/get.dart';

import '../../../../../App/Urls.dart';
import '../../../../../App/network_caller.dart';
import '../../../../../Core/loading.dart';
import '../../../../../Core/snakbar.dart';
import '../../Change_password/View/Change_password.dart';
import '../View/OTP_verification.dart';


class OTP_verification_controller extends GetxController {
  var isResendCode = false.obs;


  Future<void> resent_code(String email) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(url: urls.forgetPassword, body: {
      "email": email
    });
    AppLoader.hide();
    if(response.statusCode == 200){
      AppSnackbar.show("A new OTP is sent to your email address.");
    }else{
      AppSnackbar.show(response.errorMessage);
    }
  }

  Future<void> verify_otp(String OTP_CODE, String email) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(url: urls.verifyRestPasswordOtp, body: {
      "email": email,
      "otp": OTP_CODE
    });
    AppLoader.hide();

    if(response.statusCode == 200){
      Get.to(resent_password(email: email,));
    }else{
      AppSnackbar.show(response.errorMessage);
    }
  }

}