import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void show(
      String message, {
        String title = '',
        Duration duration = const Duration(seconds: 2),
      }) {
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();

    Get.rawSnackbar(
      title: title.isEmpty ? null : title,
      message: message,
      duration: duration,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 250),

      snackStyle: SnackStyle.FLOATING,

      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      titleText: title.isEmpty
          ? null
          : Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
