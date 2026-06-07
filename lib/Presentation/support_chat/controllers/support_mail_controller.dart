import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../App/AppColors.dart';
import '../../../App/Urls.dart';
import '../../../Core/SharepreferenceHelper.dart';
import '../../../Core/loading.dart';

class SupportMailController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Pre-fill user data if available
    fullNameController.text =
        '${PrefHelper.getFirstName()} ${PrefHelper.getLastName()}';
    emailController.text = PrefHelper.getEmail();
  }

  void sendSupportEmail() async {
    if (formKey.currentState!.validate()) {
      try {
        AppLoader.show();
        final body = {
          "fullName": fullNameController.text,
          "email": emailController.text,
          "subject": subjectController.text,
          "description": descriptionController.text,
        };
        final response = await http.post(
          Uri.parse(urls.sendSupportEmail),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );
        AppLoader.hide();

        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.dialog(
            AlertDialog(
              backgroundColor: AppColors.primary,
              title: Text(
                "Success".tr,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: Text(
                "Your message has been sent successfully. We will get back to you shortly."
                    .tr,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.back(); // Go back from support mail screen
                  },
                  child: Text(
                    "OK".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle other status codes if needed
          Get.snackbar(
            "Error".tr,
            "Failed to send message. Please try again.".tr,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        AppLoader.hide();
        Get.snackbar(
          "Error".tr,
          "An unexpected error occurred. Please try again.".tr,
          snackPosition: SnackPosition.BOTTOM,
        );
        print("Support mail error: $e");
      }
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
