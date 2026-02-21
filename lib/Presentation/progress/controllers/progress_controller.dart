import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../App/Urls.dart';
import '../../../App/network_caller.dart';
import '../model/achievement_model.dart' as badge_model;
import '../model/user_progress_model.dart';

class ProgressController extends GetxController {
  final isLoading = false.obs;
  final isBadgeLoading = false.obs;
  final userProgress = const UserProgressResponse().obs;
  final userBadges = <badge_model.Badge>[].obs;
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
      getUserBadges();
    });

    // Initial fetch
    getUserBadges();
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

  Future<void> getUserBadges() async {
    try {
      isBadgeLoading.value = true;
      NetworkResponse response = await NetworkCaller().getRequest(
        url: urls.userBadges,
      );

      if (response.isSuccess) {
        final badgeResponse = badge_model.UserBadgesResponse.fromJson(
          response.responseData,
        );

        // Sort: unlocked badges first
        final List<badge_model.Badge> sortedBadges = List.from(
          badgeResponse.data,
        );
        sortedBadges.sort((a, b) {
          if (a.isUnlocked && !b.isUnlocked) return -1;
          if (!a.isUnlocked && b.isUnlocked) return 1;
          return 0;
        });

        userBadges.value = sortedBadges;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching badges: $e");
      }
    } finally {
      isBadgeLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    final dayValue = selectedDay.value.split(' ')[0];
    await Future.wait([getUserProgress(dayValue), getUserBadges()]);
  }

  String formatSeconds(int totalSeconds) {
    if (totalSeconds <= 0) return '00:00';
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;

    String h = hours.toString().padLeft(2, '0');
    String m = minutes.toString().padLeft(2, '0');
    String s = seconds.toString().padLeft(2, '0');

    if (hours > 0) {
      return '$h:$m:$s';
    } else {
      return '$m:$s';
    }
  }
}
