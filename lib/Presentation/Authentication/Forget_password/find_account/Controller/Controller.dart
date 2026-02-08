import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Core/loading.dart';
import '../../../../../Core/snakbar.dart';
import '../../OTP_verification/View/OTP_verification.dart';

class find_account_controller extends GetxController {

  Future<void> find_account(String email) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(url: urls.forgetPassword, body: {
      "email": email
    });
    AppLoader.hide();

    if(response.statusCode == 200){
      AppSnackbar.show(response.responseData?['message']);
      Get.to(OtpVerification(email: email,));
    }else{
      AppSnackbar.show(response.errorMessage);
    }
  }
}