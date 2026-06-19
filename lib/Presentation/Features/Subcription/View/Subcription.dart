import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import 'package:purchases_flutter/errors.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:flutter/services.dart';
import '../../../../Core/responsive.dart';
import '../../../Share/GradientMask.dart';
import '../Controller/Controller.dart';
import 'package:url_launcher/url_launcher.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const GradientButton({Key? key, required this.text, this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.yellow, AppColors.pink, AppColors.sky],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        margin: EdgeInsets.all(2), // Border width
        decoration: BoxDecoration(
          color: Color(0xFF1A1F2E), // Dark blue background
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Color(0xFFE8A87C),
                      Color(0xFFC38D9E),
                      Color(0xFF85A0D3),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context, 18),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class subscription extends StatelessWidget {
  subscription({super.key});

  final controller = Get.find<subscriptionController>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 7,
                runSpacing: 4,
                children: [
                  Text(
                    "Choose Your".tr,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context, 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GradientMask(
                    child: Text(
                      "Learning Path".tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Start your journey with our free trial, then choose the plan that fits your learning goals"
                    .tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 16),
                ),
              ),
              SizedBox(height: 20),

              /// Show Premium Status
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!controller.isPremium.value)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Free Plan".tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          controller.activePackageName.value.toLowerCase().contains('family')
                              ? "Family Active".tr
                              : "Premium Active".tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (controller.isPremium.value) ...[

                      Text(
                        "Auto-Renew: ".tr +
                            "${controller.autoRenew.value ? "On".tr : "Off".tr}",
                      ),
                      Text(
                        (controller.autoRenew.value
                                ? "Next Renewal: ".tr
                                : "Expire Date: ".tr) +
                            " ${controller.nextRenewDate.value}",
                      ),
                    ],
                  ],
                );
              }),
              SizedBox(height: 20),

              /// List all subscription packages dynamically
              Obx(() {
                final packages = controller.getCurrentPackages();
                if (packages.isEmpty) {
                  return Center(
                    child: Text("No subscription packages available.".tr),
                  );
                }

                return Column(
                  children: packages.map((package) {
                    final product = package.storeProduct;

                    /// Map product identifiers to feature list (using flexible matching)
                    final features =
                        controller.getFeatureList(product.identifier);

                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.02),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: double.infinity),
                            Text(
                              product.title.split('(')[0].trim(),
                              style: TextStyle(
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  20,
                                ),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              product.priceString,
                              style: TextStyle(
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  44,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Duration : One Month".tr,
                              style: TextStyle(
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  16,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            /// Features List
                            ...features.map(
                              (feature) => _buildList(text: feature),
                            ),

                            SizedBox(height: 20),
                            Obx(() {
                              final activePkg = controller.activePackageName.value;
                              final prodId = product.identifier;
                              final isActive = activePkg == prodId ||
                                  (activePkg.isNotEmpty && prodId.isNotEmpty && 
                                   activePkg.split(':').first == prodId.split(':').first);

                              void handlePurchase() async {
                                try {
                                  // Initiate purchase
                                  CustomerInfo customerInfo =
                                  await controller.purchasePackage(package);

                                  // Check if entitlement is active
                                  final activeEntitlement = customerInfo
                                      .entitlements.active.entries.isNotEmpty
                                      ? customerInfo
                                      .entitlements.active.entries.first.value
                                      : null;

                                  if (activeEntitlement != null &&
                                      activeEntitlement.isActive) {
                                    AppSnackbar.show(
                                      "Subscription purchased!".tr,
                                      title: "Success".tr,
                                      backgroundColor: Colors.green,
                                    );
                                  } else {
                                    // User cancelled or purchase failed
                                    AppSnackbar.show(
                                      "Subscription not completed.".tr,
                                      title: "Cancelled".tr,
                                      backgroundColor: Colors.redAccent,
                                    );
                                  }
                                } on PlatformException catch (e) {
                                  var strErr = e.toString().toLowerCase();
                                  if (e.code == '1' ||
                                      strErr.contains('cancelled') ||
                                      strErr.contains('user_canceled')) {
                                    return; // User cancelled, ignore completely
                                  }
                                  var errorCode = PurchasesErrorHelper.getErrorCode(e);
                                  if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
                                    return; // User cancelled, ignore completely
                                  }
                                  
                                  AppSnackbar.show(
                                    "An error occurred during purchase: ${e.message ?? e.toString()}".tr,
                                    title: "Error".tr,
                                    backgroundColor: Colors.redAccent,
                                  );
                                } catch (e) {
                                  // Handle other purchase errors
                                  AppSnackbar.show(
                                    "An error occurred: $e".tr,
                                    title: "Error".tr,
                                    backgroundColor: Colors.redAccent,
                                  );
                                }
                              }

                              final introPrice = product.introductoryPrice;
                              final isIosWithTrial = Platform.isIOS &&
                                  introPrice != null &&
                                  introPrice.price == 0;

                              if (isActive) {
                                if (Platform.isIOS) {
                                  return GradientButton(
                                    text: "Active".tr,
                                    onPressed: null,
                                  );
                                }
                                return GradientButton(
                                  text: "Unsubscribe".tr,
                                  onPressed: () {
                                    Get.dialog(
                                      Dialog(
                                        backgroundColor: const Color(0xFF1E1E2C), // Dark theme matching the app
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.warning_amber_rounded,
                                                color: Colors.orangeAccent,
                                                size: 48,
                                              ),
                                              const SizedBox(height: 16),
                                              Text(
                                                "Confirm Unsubscribe".tr,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                "Are you sure you want to unsubscribe? You will be redirected to the Play Store to manage your subscription.".tr,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                  height: 1.5,
                                                ),
                                              ),
                                              const SizedBox(height: 24),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextButton(
                                                      onPressed: () => Get.back(),
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: Colors.white70,
                                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12),
                                                          side: const BorderSide(color: Colors.white24),
                                                        ),
                                                      ),
                                                      child: Text("No".tr, style: const TextStyle(fontSize: 16)),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        Get.back(); // Close the dialog
                                                        final sku = product.identifier.split(':').first;
                                                        final url = Uri.parse(
                                                            "https://play.google.com/store/account/subscriptions?package=com.manifex.app&sku=$sku");

                                                        try {
                                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                                        } catch (e) {
                                                          Get.snackbar("Error".tr,
                                                              "Could not open Google Play Store".tr,
                                                              snackPosition: SnackPosition.BOTTOM);
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.redAccent,
                                                        foregroundColor: Colors.white,
                                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                      ),
                                                      child: Text("Yes".tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }

                              if (isIosWithTrial) {
                                return Column(
                                  children: [
                                    GradientButton(
                                      text: "Start 7 days free trial".tr,
                                      onPressed: handlePurchase,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "After trial, pay ${product.priceString}".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: ScreenResponsive.responsiveFont(
                                            context, 14),
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return GradientButton(
                                text: "Subscribe".tr,
                                onPressed: handlePurchase,
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}

/// Feature list item
class _buildList extends StatelessWidget {
  final String text;
  const _buildList({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check, color: Colors.white),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text.tr,
            style: TextStyle(
              fontSize: ScreenResponsive.responsiveFont(context, 16),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
