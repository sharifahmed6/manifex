import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/profile_edit/controller/profile_edit_controller.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  final controller = Get.find<ProfileEditController>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Obx(
        () => Padding(
          padding: EdgeInsets.all(16.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8.w,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                    ),
                    CustomText(
                      text: 'Account'.tr,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _gradientTitle(
                  normalText: 'Personal '.tr,
                  gradientText: 'Information'.tr,
                ),
                SizedBox(height: 8.h),
                controller.isProfileLoading.value
                    ? CustomCircleProgressIndicator(size: 24.sp)
                    : _personalInfo(),
                SizedBox(height: 16.h),
                ButtonGradient(
                  onTap: controller.isProfileLoading.value
                      ? null
                      : () => controller.updateProfile(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/edit_profile.png',
                        width: 24,
                        height: 24,
                      ),
                      CustomText(
                        text: 'Edit Profile'.tr,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                CustomText(
                  text: 'Security'.tr,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: 'Change your password from here.'.tr,
                  fontSize: 16,
                ),
                SizedBox(height: 8.h),
                _securityInfo(),
                SizedBox(height: 16.h),
                ButtonGradient(
                  onTap: controller.isPasswordLoading.value
                      ? null
                      : () => controller.changePassword(),
                  child: controller.isPasswordLoading.value
                      ? CustomCircleProgressIndicator(
                          size: 24.sp,
                          color: Colors.white,
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: 'Update Password'.tr,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _securityInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [
            Color(0xffCFDBFF).withAlpha(30),
            Color(0xff111217).withAlpha(30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: BoxBorder.all(
          color: Color(0xffFFFFFF).withAlpha((2.56 * 22).toInt()),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Old Password".tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller.oldPasswordController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter you Old Password'.tr,
              hintStyle: TextStyle(
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "New Password".tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller.newPasswordController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter your New Password'.tr,
              hintStyle: TextStyle(
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Confirm Password".tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller.confirmPasswordController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter your Confirm Password'.tr,
              hintStyle: TextStyle(
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _personalInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [
            Color(0xffCFDBFF).withAlpha(30),
            Color(0xff111217).withAlpha(30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: BoxBorder.all(
          color: Color(0xffFFFFFF).withAlpha((2.56 * 22).toInt()),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "First Name".tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller.firstNameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter you First Name'.tr,
              hintStyle: TextStyle(
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Last Name".tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller.lastNameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter your Last Name'.tr,
              hintStyle: TextStyle(
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Hobby".tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller.hobbyController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter your Hobby'.tr,
              hintStyle: TextStyle(
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientTitle({String? normalText, String? gradientText}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
        children: [
          TextSpan(
            text: normalText ?? '',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xffFFFFFF),
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFFFBC6F), // pink
                    Color(0xFFF176B7), // orange
                    Color(0xFF3797CD), // blue
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: Text(
                gradientText ?? '',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
