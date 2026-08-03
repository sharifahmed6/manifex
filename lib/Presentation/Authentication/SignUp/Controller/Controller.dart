import 'package:flutter/material.dart';
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
  var selectedAgeGroup = Rx<String?>(null);
  final List<String> ageGroups = ["6 - 9", "10 - 13", "14 - 17", "Adult"];
  
  var selectedHobbies = <String>[].obs;
  var hobbies = <String>[].obs;
  
  var selectedUserType = Rx<String?>(null);
  final List<String> userTypes = ["Adult", "Student"];

  signupModel? tempSignupModel;

  final Map<String, List<String>> ageToHobbies = {
    "6 - 9": ["Animals", "Sports", "Dance"],
    "10 - 13": ["Animals", "Sports", "Dance", "Music", "Gaming", "Art"],
    "14 - 17": ["Animals", "Sports", "Dance", "Music", "Gaming", "Science", "Art", "Cooking"],
    "Adult": ["Animals", "Sports", "Dance", "Music", "Gaming", "Science", "Art", "Cooking", "Meditation"],
  };

  void updateAgeGroup(String age) {
    selectedAgeGroup.value = age;
    hobbies.assignAll(ageToHobbies[age] ?? []);
    // Clear all previously selected hobbies when the age group changes
    selectedHobbies.clear();
  }

  Future<void> resent_code(String email) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(
      url: urls.resendOtp,
      body: {"email": email},
    );
    AppLoader.hide();

    if (response.statusCode == 200) {
      AppSnackbar.show(
        response.responseData?['message'],
        title: "Success",
        backgroundColor: Colors.green,
      );
    } else {
      AppSnackbar.show(
        response.errorMessage,
        title: "Error",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> verify_otp(String OTP_CODE, String email) async {
    emailAddress.value = email;
    otp.value = OTP_CODE;
    Get.offNamed(routes.signup_screen);
  }

  Future<void> sent_otp(String email) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(
      url: urls.createOne,
      body: {"email": email},
    );
    AppLoader.hide();

    if (response.statusCode == 200) {
      otp.value = ""; // Clear old OTP value just in case
      Get.to(() => signupVerification(email: email));
    } else {
      AppSnackbar.show(
        response.errorMessage,
        title: "OTP Failed",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> createAccount(signupModel model) async {
    AppLoader.show();
    NetworkResponse response = await NetworkCaller().postRequest(
      url: urls.userVerify,
      body: {
        "otpCode": otp.value,
        "data": {
          "firstName": model.firstName,
          "lastName": model.lastName,
          "email": model.email,
          "password": model.password,
          "age": model.ageGroup == "Adult" ? "18-40" : model.ageGroup?.replaceAll(" - ", "-"),
          "hobbies": model.hobbies,
          "profilePic":
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
          "userType": model.userType.toLowerCase(),
          "language": "English",
        },
      },
    );
    AppLoader.hide();
    if (response.statusCode == 200) {
      final accessToken = response.responseData?['data']['accessToken'];
      final Map<String, dynamic> userInfo = decodeJwtToJson(
        response.responseData?['data']['accessToken'],
      );

      await PrefHelper.saveLoginData(
        accessToken: accessToken,
        firstName: model.firstName.toString(),
        lastName: model.lastName.toString(),
        email: model.email.toString(),
        age: model.ageGroup.toString(),
        hobbies: model.hobbies.toString(),
        profilePic:
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
        userType: model.userType.toLowerCase(),
        language: "English",
        userId: userInfo['id'],
      );
      await PrefHelper.saveLoggedIn();
      await PrefHelper.saveSubscription(
        isSubscribed: userInfo['isSubscribed'],
        isSubscriptionFree: userInfo['isSubscriptionFree'],
      );

      AppSnackbar.show(
        "Account created & logged in",
        title: "Success",
        backgroundColor: Colors.green,
      );
      Get.offAllNamed(routes.bottom_navbar);
    } else {
      AppSnackbar.show(
        response.errorMessage,
        title: "Signup Failed",
        backgroundColor: Colors.red,
      );
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
    super.onInit();
    // Intentionally leaving these null to show the hint text in the UI
  }
}
