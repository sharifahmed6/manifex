import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../App/Urls.dart';
import '../../../App/network_caller.dart';
import '../../../Core/snakbar.dart';
import '../../Features/home/controller/home_controller.dart';

class ProfileEditController extends GetxController {
  final isProfileLoading = false.obs;
  final isPasswordLoading = false.obs;

  // Profile Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // Dynamic Age and Hobbies
  var selectedAgeGroup = Rx<String?>(null);
  var selectedHobbies = <String>[].obs;
  var hobbies = <String>[].obs;

  final Map<String, List<String>> ageToHobbies = {
    "6 - 9": ["Animals", "Sports", "Dance"],
    "10 - 13": ["Animals", "Sports", "Dance", "Music", "Gaming", "Art"],
    "14 - 17": ["Animals", "Sports", "Dance", "Music", "Gaming", "Science", "Art", "Cooking"],
    "Adult": ["Animals", "Sports", "Dance", "Music", "Gaming", "Science", "Art", "Cooking", "Meditation"],
  };

  void updateAgeGroup(String age) {
    selectedAgeGroup.value = age;
    hobbies.assignAll(ageToHobbies[age] ?? []);
    selectedHobbies.clear();
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  // Security Controllers
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProfileInfo();
  }

  Future<void> getProfileInfo() async {
    try {
      isProfileLoading.value = true;
      NetworkResponse response = await NetworkCaller().getRequest(
        url: urls.profileInfo,
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!['data'];
        if (data != null) {
          firstNameController.text = data['firstName'] ?? '';
          lastNameController.text = data['lastName'] ?? '';
          
          if (data['age'] != null) {
            String ageStr = data['age'].toString();
            if (ageStr == "6-9") ageStr = "6 - 9";
            if (ageStr == "10-13") ageStr = "10 - 13";
            if (ageStr == "14-17") ageStr = "14 - 17";
            if (ageStr == "18-40") ageStr = "Adult";
            
            if (ageToHobbies.containsKey(ageStr)) {
              selectedAgeGroup.value = ageStr;
              hobbies.assignAll(ageToHobbies[ageStr] ?? []);
            }
          }

          if (data['hobbies'] != null) {
            String hobbiesStr = data['hobbies'].toString();
            selectedHobbies.assignAll(
                hobbiesStr.split(',').map((e) => _capitalize(e.trim())).where((e) => e.isNotEmpty).toList());
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      isProfileLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      AppSnackbar.show(
        "First name and last name are required",
        title: "Validation Error",
        backgroundColor: Colors.red,
      );
      return;
    }

    if (selectedHobbies.isEmpty) {
      AppSnackbar.show(
        "Please select at least one hobby",
        title: "Validation Error",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      isProfileLoading.value = true;
      
      String joinedHobbies = selectedHobbies.join(", ").toLowerCase();
      String formattedHobbies = joinedHobbies.isEmpty 
          ? "" 
          : joinedHobbies[0].toUpperCase() + joinedHobbies.substring(1);

      final profileBody = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "hobbies": formattedHobbies,
        "age": selectedAgeGroup.value == "Adult" ? "18-40" : (selectedAgeGroup.value ?? "").replaceAll(" - ", "-"),
      };

      final response = await NetworkCaller().patchRequest(
        url: urls.updateProfile,
        body: profileBody,
      );

      if (response.isSuccess) {
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().fetchProfileInfo();
        }
        Get.back();
        AppSnackbar.show(
          "Profile updated successfully",
          title: "Success",
          backgroundColor: Colors.green,
        );
      } else {
        AppSnackbar.show(
          response.errorMessage,
          title: "Update Failed",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        "An unexpected error occurred",
        title: "Error",
        backgroundColor: Colors.red,
      );
    } finally {
      isProfileLoading.value = false;
    }
  }

  Future<void> changePassword() async {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppSnackbar.show(
        "Current, New, and Confirm password are all required",
        title: "Incomplete Fields",
        backgroundColor: Colors.red,
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      AppSnackbar.show(
        "New passwords do not match",
        title: "Error",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      isPasswordLoading.value = true;
      final passwordBody = {
        "currentPassword": oldPasswordController.text,
        "newPassword": newPasswordController.text,
        "confirmPassword": confirmPasswordController.text,
      };

      final response = await NetworkCaller().putRequest(
        url: urls.changePassword,
        body: passwordBody,
      );

      if (response.isSuccess) {
        Get.back();
        AppSnackbar.show(
          "Password changed successfully",
          title: "Success",
          backgroundColor: Colors.green,
        );
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else {
        AppSnackbar.show(
          response.errorMessage,
          title: "Update Failed",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      AppSnackbar.show(
        "An unexpected error occurred",
        title: "Error",
        backgroundColor: Colors.red,
      );
    } finally {
      isPasswordLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
