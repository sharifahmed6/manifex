import 'package:flutter/material.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import '../../../../Core/responsive.dart';
import '../../../Share/GradientMask.dart';
import '../Controller/Controller.dart';

// class subscription extends StatelessWidget {
//   subscription({super.key});
//   final controller = Get.find<subscriptionController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return scaffold_background(child: Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Wrap(
//               alignment: WrapAlignment.start,
//               crossAxisAlignment: WrapCrossAlignment.center,
//               spacing: 7,
//               runSpacing: 4,
//               children: [
//                 Text(
//                   "Choose Your",
//                   style: TextStyle(
//                     fontSize: ScreenResponsive.responsiveFont(
//                       context,
//                       20,
//                     ),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 GradientMask(
//                   child: Text(
//                     "Learning Path",
//                     style: TextStyle(
//                       fontSize: ScreenResponsive.responsiveFont(
//                         context,
//                         20,
//                       ),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Text(
//               "Start your journey with our free trial, then choose the plan that fits your learning goals"
//                   .tr,
//               style: TextStyle(
//                 fontSize: ScreenResponsive.responsiveFont(context, 16),
//               ),
//             ),
//
//             SizedBox(height: 20,),
//             Container(
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [
//                     Colors.white.withOpacity(0.1),
//                     Colors.white.withOpacity(0.02)
//                   ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(
//                       color: Colors.white.withOpacity(0.2)
//                   )
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     SizedBox(width: double.infinity,),
//                     Text("Premium".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 20), fontWeight: FontWeight.w500),),
//                     Text("\$19".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 44), fontWeight: FontWeight.bold),),
//                     Text("Per month".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 16)),),
//                     SizedBox(height: 20,),
//                     _buildList(text: "Unlimited lessons",),
//                     _buildList(text: "Advanced progress analytics",),
//                     _buildList(text: "Full reward library access",),
//                     _buildList(text: "Priority AI support",),
//                     _buildList(text: "Parent dashboard",),
//                     _buildList(text: "Offline mode",),
//                     SizedBox(height: 20,),
//                     Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             AppColors.yellow,
//                             AppColors.pink,
//                             AppColors.sky
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: (){},
//                           borderRadius: BorderRadius.circular(16),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                             child: Center(
//                               child: Text(
//                                 "Start With Premium Plan".tr,
//                                 style: TextStyle(
//                                   fontSize: ScreenResponsive.responsiveFont(context, 18),
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20,),
//             Container(
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [
//                     Colors.white.withOpacity(0.1),
//                     Colors.white.withOpacity(0.02)
//                   ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(
//                       color: Colors.white.withOpacity(0.2)
//                   )
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     SizedBox(width: double.infinity,),
//                     Text("Family".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 20), fontWeight: FontWeight.w500),),
//                     Text("\$39".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 44), fontWeight: FontWeight.bold),),
//                     Text("Per month".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 16)),),
//                     SizedBox(height: 20,),
//                     _buildList(text: "Up to 5 learner profiles",),
//                     _buildList(text: "All Premium features",),
//                     _buildList(text: "Family progress reports",),
//                     _buildList(text: "Shared reward library",),
//                     _buildList(text: "Priority support",),
//                     _buildList(text: "Educational resources",),
//                     SizedBox(height: 20,),
//                     GradientButton(
//                       text: 'Start With Family Plan',
//                       onPressed: () {
//                         print('Button pressed!');
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//     ));
//   }
// }

// class _buildList extends StatelessWidget {
//   String text;
//   _buildList({
//     super.key,
//     required this.text
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(Icons.check, color: Colors.white,),
//         SizedBox(width: 10,),
//         Text(text.tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 16), fontWeight: FontWeight.w500),)
//       ],
//     );
//   }
// }

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
                    Text(
                      controller.isPremium.value
                          ? "Premium Active".tr
                          : "Free Plan".tr,
                    ),
                    if (controller.isPremium.value) ...[
                      Text(
                        "Package: ".tr +
                            "${controller.activePackageName.value}",
                      ),
                      Text(
                        "Auto-Renew: ".tr +
                            "${controller.autoRenew.value ? "On".tr : "Off".tr}",
                      ),
                      Text(
                        "Next Renewal: ".tr +
                            "${controller.nextRenewDate.value}",
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

                    /// Map product identifiers to feature list
                    final features =
                        controller.subscriptionFeatures[product.identifier] ??
                        ["No details available"];

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
                              product.title,
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
                            GradientButton(
                              text: "Subscribe".tr,
                              onPressed: () async {
                                try {
                                  // Initiate purchase
                                  CustomerInfo customerInfo = await controller
                                      .purchasePackage(package);

                                  // Check if entitlement is active
                                  final activeEntitlement =
                                      customerInfo
                                          .entitlements
                                          .active
                                          .entries
                                          .isNotEmpty
                                      ? customerInfo
                                            .entitlements
                                            .active
                                            .entries
                                            .first
                                            .value
                                      : null;

                                  if (activeEntitlement != null &&
                                      activeEntitlement.isActive) {
                                    Get.snackbar(
                                      "Success".tr,
                                      "Subscription purchased!".tr,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  } else {
                                    // User cancelled or purchase failed
                                    Get.snackbar(
                                      "Cancelled".tr,
                                      "Subscription not completed.".tr,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                    );
                                    AppSnackbar.show(
                                      "Subscription not completed.".tr,
                                    );
                                  }
                                } catch (e) {
                                  // Handle network error, user cancel etc.
                                  // Get.snackbar(
                                  //   "Error",
                                  //   "Purchase failed: $e",
                                  //   snackPosition: SnackPosition.BOTTOM,
                                  //   backgroundColor: Colors.redAccent,
                                  // );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
              SizedBox(height: 20),
              Obx(() {
                if (!controller.isPremium.value) return SizedBox.shrink();

                return Column(
                  children: [
                    SizedBox(height: 10),
                    GradientButton(
                      text: "Unsubscribe".tr,
                      onPressed: () async {
                        try {
                          await controller
                              .cancelAutoRenew(); // call your logout/unsubscribe method
                          Get.snackbar(
                            "Success".tr,
                            "You have unsubscribed successfully!".tr,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } catch (e) {
                          Get.snackbar(
                            "Error".tr,
                            "Failed to unsubscribe: $e".tr,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                    ),
                  ],
                );
              }),
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
