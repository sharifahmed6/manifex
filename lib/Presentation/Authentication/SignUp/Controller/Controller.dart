import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/Core/loading.dart';
import 'package:manifex/Core/snakbar.dart';

import '../../../../App/network_caller.dart';
import '../../../../App/routes.dart';
import '../../../../Core/SharepreferenceHelper.dart';
import '../Model/signup_model.dart';
import '../View/signupVerification.dart';

class signup_controller extends GetxController {
  var password = true.obs;
  var confirm_password = true.obs;
  var isResendCode = false.obs;
  var emailAddress = "".obs;
  var otp = "".obs;
  var selectedAgeGroup = "";
  final List<String> ageGroups = [
    "6 - 9",
    "10 - 13",
    "14 - 17",
    "18 - 40",
  ];
  var selectedHobbies = "";
  final List<String> hobbies = [
    "Dancing",
    "Gaming",
    "Sports",
  ];
  var selectedUserType = "";
  final List<String> userTypes = [
    "Student",
    "Teacher",
    "Parent",
    ];





  Future<void> resent_code(String email) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(url: urls.resendOtp, body: {
      "email": email
    });
    AppLoader.hide();
    
    if(response.statusCode == 200){
      AppSnackbar.show(response.responseData?['message']);
    }else{
      AppSnackbar.show(response.errorMessage);
    }
  }

  Future<void> verify_otp(String OTP_CODE, String email) async {
    emailAddress.value = email;
    otp.value = OTP_CODE;
    Get.toNamed(routes.signup_screen);
  }


  Future<void> sent_otp(String email) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(url: urls.createOne, body: {
      "email": email
    });
    AppLoader.hide();

    if(response.statusCode == 200){
      Get.to(signupVerification(email: email,));
    }else{
      AppSnackbar.show(response.errorMessage);
    }
  }

  Future<void> createAccount(signupModel model) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(url: urls.userVerify, body: {
      "otpCode": otp.value,
      "data": {
        "firstName": model.firstName,
        "lastName": model.lastName,
        "email": model.email,
        "password": model.password,
        "age": model.ageGroup,
        "hobbies": model.hobbies,
        "profilePic": "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
        "userType": model.userType.toLowerCase(),
        "language": "English"
      }
    });
    AppLoader.hide();
    if(response.statusCode == 200) {
      final accessToken = response.responseData?['data']['accessToken'];
      final Map<String, dynamic> userInfo = decodeJwtToJson(response.responseData?['data']['accessToken']);

      await PrefHelper.saveLoginData(
        accessToken: accessToken,
        firstName: model.firstName.toString(),
        lastName: model.lastName.toString(),
        email: model.email.toString(),
        age: model.ageGroup.toString(),
        hobbies: model.hobbies.toString(),
        profilePic: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
        userType: model.userType.toLowerCase(),
        language: "English",
      );
      await PrefHelper.saveLoggedIn();
      await PrefHelper.saveSubscription(
        isSubscribed: userInfo['isSubscribed'],
        isSubscriptionFree: userInfo['isSubscriptionFree'],
      );

      AppSnackbar.show("Account created & logged in");
      Get.offAllNamed(routes.bottom_navbar);
    }else{
      AppSnackbar.show(response.errorMessage);
    }

  }

  Map<String, dynamic> decodeJwtToJson(String token) {
    try {
      final Map<String, dynamic> decoded = JwtDecoder.decode(token);
      return decoded;
    } catch (e) {
      return {};
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedHobbies = hobbies.first;
    selectedUserType = userTypes.first;
    selectedAgeGroup = ageGroups.first;

  }




}