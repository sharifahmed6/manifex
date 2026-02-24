import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/bottom_navbar/controllers/bottom_navbar_controller.dart';

class UnlockPracticeCard extends StatelessWidget {
   UnlockPracticeCard({super.key});
  final bottomNavController = Get.find<BottomNavbarController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with Gradient
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2B5BFC), Color(0xFFA524FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Unlock Unlimited Practice",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Body Content
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "You've used your free practice. Upgrade your plan to continue learning without limits.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                _buildFeatureItem("Unlimited practice sessions"),
                SizedBox(height: 12.h),
                _buildFeatureItem("Advanced learning features"),
                SizedBox(height: 12.h),
                _buildFeatureItem("Progress tracking"),
                SizedBox(height: 32.h),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2B5BFC), Color(0xFFA524FF)],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2B5BFC).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            bottomNavController.selectedIndex(3);
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "View Plans",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      children: [
        Icon(Icons.check_rounded, color: const Color(0xFF00D261), size: 18.sp),
        SizedBox(width: 12.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
