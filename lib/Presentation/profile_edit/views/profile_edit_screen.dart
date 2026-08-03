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
import 'package:manifex/Core/snakbar.dart';

void _showMultiSelectDialog(BuildContext context, ProfileEditController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xff111217),
        title: Text("Select Hobbies".tr, style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.hobbies.length,
            itemBuilder: (context, index) {
              final hobby = controller.hobbies[index];
              return Obx(() {
                final isSelected = controller.selectedHobbies.contains(hobby);
                return CheckboxListTile(
                  title: Text(hobby, style: TextStyle(color: Colors.white)),
                  value: isSelected,
                  activeColor: Colors.white,
                  checkColor: const Color(0xff111217),
                  side: BorderSide(color: Colors.white),
                  onChanged: (bool? checked) {
                    if (checked == true) {
                      if (!controller.selectedHobbies.contains(hobby)) {
                        if (controller.selectedHobbies.length >= 2) {
                          AppSnackbar.show(
                            "You can select maximum 2 hobbies".tr,
                            backgroundColor: Colors.red,
                          );
                        } else {
                          controller.selectedHobbies.add(hobby);
                        }
                      }
                    } else {
                      controller.selectedHobbies.remove(hobby);
                    }
                  },
                );
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Done".tr, style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

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
                    : _personalInfo(context),
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

  Widget _personalInfo(BuildContext context) {
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
            "Age".tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedAgeGroup.value,
                dropdownColor: const Color(0xff111217),
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white70,
                hint: Text(
                  'Select an age'.tr,
                  style: TextStyle(
                    color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                  ),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                items: controller.ageToHobbies.keys.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.updateAgeGroup(newValue);
                  }
                },
              )),
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
          Obx(() => GestureDetector(
                onTap: () {
                  if (controller.selectedAgeGroup.value == null) {
                    AppSnackbar.show(
                      "Please select your age group first".tr,
                      backgroundColor: Colors.red,
                    );
                  } else {
                    _showMultiSelectDialog(context, controller);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          controller.selectedHobbies.isEmpty
                              ? "Select your Hobby".tr
                              : controller.selectedHobbies.join(", "),
                          style: TextStyle(
                            color: controller.selectedHobbies.isEmpty
                                ? const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt())
                                : Colors.white,
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )),
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
