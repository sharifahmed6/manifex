import 'package:get/get.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Core/loading.dart';

import '../../../../../App/Urls.dart';
import '../../../../../App/routes.dart';
import '../../../../../Core/snakbar.dart';

class reset_password_controller extends GetxController {
  var password = true.obs;
  var confirm_password = true.obs;

  Future<void> resetPassword(String email, String password) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(url: urls.restPassword, body: {
      "email": email,
      "newPassword": password,
      "confirmPassword": password
    });
    AppLoader.hide();
    if(response.statusCode == 200){
      AppSnackbar.show(response.responseData?['message']);
      Get.offAllNamed(routes.login_screen);
    }else{
      AppSnackbar.show(response.errorMessage);
    }
  }


}