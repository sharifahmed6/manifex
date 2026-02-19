import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../App/Urls.dart';
import '../../../App/network_caller.dart';
import '../model/user_progress_model.dart';

class ProgressController extends GetxController {
  final isLoading = false.obs;
  final userProgress = const UserProgressResponse().obs;
  final progressError = ''.obs;
  final selectedDay = '30 D'.obs;
  final progressDays = ['30 D', '60 D', '90 D'];

  @override
  void onInit() {
    super.onInit();
    // Default to 30 days
    getUserProgress("30");

    // Listen to changes in selectedDay and refetch data
    ever(selectedDay, (String day) {
      // Convert '30 D' -> '30' or '14 D' -> '14'
      final dayValue = day.split(' ')[0];
      print("Refetching user progress for $dayValue days");
      getUserProgress(dayValue);
    });
  }

  Future<void> getUserProgress(String days) async {
    try {
      isLoading.value = true;
      progressError.value = '';

      NetworkResponse response = await NetworkCaller().getRequest(
        url: "${urls.userProgress}?days=$days",
      );

      if (response.isSuccess) {
        userProgress.value = UserProgressResponse.fromJson(
          response.responseData,
        );

        // final message =
        //     response.responseData?['message']?.toString() ?? "Loaded";

        // Optional: Show snackbar only on manual trigger or error
        // Get.showSnackbar(...)
      } else {
        final message = response.errorMessage.isNotEmpty
            ? response.errorMessage
            : (response.responseData?['message']?.toString() ?? "Failed");

        progressError.value = message;

        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: message,
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          ),
        );
      }
    } catch (e) {
      progressError.value = "Something went wrong";

      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: "Something went wrong",
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        ),
      );

      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
