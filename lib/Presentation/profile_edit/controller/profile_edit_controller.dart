import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../App/Urls.dart';
import '../../../App/network_caller.dart';
import '../../../Core/snakbar.dart';

class ProfileEditController extends GetxController {
  final isProfileLoading = false.obs;
  final isPasswordLoading = false.obs;

  // Profile Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final hobbyController = TextEditingController();

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
          hobbyController.text = data['hobbies'] ?? '';
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

    try {
      isProfileLoading.value = true;
      final profileBody = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "hobbies": hobbyController.text,
      };

      final response = await NetworkCaller().patchRequest(
        url: urls.updateProfile,
        body: profileBody,
      );

      if (response.isSuccess) {
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
    hobbyController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
