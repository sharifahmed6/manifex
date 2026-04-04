import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void show(
    String message, {
    String title = '',
    Duration duration = const Duration(seconds: 3),
    SnackPosition snackPosition = SnackPosition.TOP,
    Color backgroundColor = Colors.black87,
  }) {
    // Using a try-catch and avoiding rapid close/open cycles helps prevent GetX disposed assertion errors
    try {
      if (Get.isSnackbarOpen) {
        // Instead of closeAll, we can just let them stack or try to close current
        // Get.closeAllSnackbars(); 
      }
    } catch (e) {
      debugPrint("Error closing snackbar: $e");
    }

    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: duration,
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
