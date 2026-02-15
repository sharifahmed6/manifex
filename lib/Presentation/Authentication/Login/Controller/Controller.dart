import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Core/loading.dart';
import '../../../../App/Urls.dart';
import '../../../../Core/SharepreferenceHelper.dart';
import '../../../../Core/snakbar.dart';

class login_controller extends GetxController {
  var password = true.obs;
  var isRemeber = true.obs;

  void route_forget_password() => Get.toNamed(routes.find_account_screen);

  Future<void> Login(String email, String password) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(url: urls.login, body: {
      "email": email,
      "password": password
    });
    AppLoader.hide();

    if(response.statusCode == 200){
      final Map<String, dynamic> userInfo = decodeJwtToJson(response.responseData?['data']['accessToken']);
      if(isRemeber.value) PrefHelper.saveLoggedIn();

      await PrefHelper.saveLoginData(
        accessToken: response.responseData?['data']['accessToken'],
        firstName: userInfo['firstName'],
        lastName: userInfo['lastName'],
        email: userInfo['email'],
        age: '',
        hobbies: '',
        profilePic: userInfo['profilePic'],
        userType: userInfo['userType'],
        language: userInfo['language'],
        userId: userInfo['id'],
      );

      await PrefHelper.saveSubscription(
        isSubscribed: userInfo['isSubscribed'],
        isSubscriptionFree: userInfo['isSubscriptionFree'],
      );
      Get.offAllNamed(routes.bottom_navbar);
    }else{
      AppSnackbar.show(response.errorMessage);
    }
  }

  Map<String, dynamic> decodeJwtToJson(String token) {
    try {
      final Map<String, dynamic> decoded = JwtDecoder.decode(token);
      print(decoded);
      return decoded;
    } catch (e) {
      return {};
    }
  }
}