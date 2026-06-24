import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Core/SharepreferenceHelper.dart';
import 'package:manifex/Core/loading.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:http/http.dart' as http;

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Delete Account'.tr,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20.h),
            CustomText(
              text: 'Are you sure you want to delete your account? This action is permanent and cannot be undone. All your progress and data will be lost.'.tr,
              fontSize: 16,
              color: Colors.white70,
            ),
            SizedBox(height: 40.h),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showDeleteConfirmation(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: CustomText(
                  text: 'Delete My Account'.tr,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.primary,
        title: Text(
          "Delete Account".tr,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          "Are you really sure you want to permanently delete your account? Please note that once deleted, your account cannot be recovered.".tr,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Cancel".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      Get.back();
                      AppLoader.show();

                      final response = await http.delete(
                        Uri.parse(urls.deleteAccount),
                        headers: {
                          'Authorization': PrefHelper.getAccessToken(),
                          'Content-Type': 'application/json',
                        },
                      );

                      final responseData = json.decode(response.body);

                      if (response.statusCode == 200 && responseData['success'] == true) {
                        // Logout logic
                        await PrefHelper.clear();

                        // RevenueCat Logout
                        try {
                          final info = await Purchases.getCustomerInfo();
                          if (info.entitlements.all.isNotEmpty) {
                            await Purchases.logOut();
                          }
                        } catch (e) {
                          print("RevenueCat logout error: $e");
                        }

                        AppLoader.hide();
                        Get.offAllNamed(routes.login_screen);

                        Get.snackbar(
                          "Success".tr,
                          responseData['message'] ?? "Your account has been deleted successfully!".tr,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      } else {
                        AppLoader.hide();
                        Get.snackbar(
                          "Error".tr,
                          responseData['message'] ?? "Failed to delete account. Please try again.".tr,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      }
                    } catch (e) {
                      AppLoader.hide();
                      print("Delete account error: $e");
                      Get.snackbar(
                        "Error".tr,
                        "An unexpected error occurred. Please try again.".tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    "Delete".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
