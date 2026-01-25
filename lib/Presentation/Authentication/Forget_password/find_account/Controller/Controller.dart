import 'package:get/get.dart';
import '../../OTP_verification/View/OTP_verification.dart';

class find_account_controller extends GetxController {

  Future<void> find_account(String email) async {
    Get.to(OtpVerification(email: email,));
  }

}