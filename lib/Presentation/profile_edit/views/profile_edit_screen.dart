import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
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
                    text: 'Account',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _gradientTitle(
                normalText: 'Personal ',
                gradientText: 'Information',
              ),
              SizedBox(height: 8.h,),
              _personalInfo(),
              SizedBox(height: 8.h,),
              CustomText(text: 'Security',fontSize: 20,fontWeight: FontWeight.w600,),
              SizedBox(height: 8.h,),
              CustomText(text: 'Change your password from here.',fontSize: 16),
              SizedBox(height: 8.h,),
              _securityInfo(),
              SizedBox(height: 16.h,),
              ButtonGradient(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/edit_profile.png',width: 24,height: 24,),
                    CustomText(text: 'Edit Profile',fontWeight: FontWeight.w600,fontSize: 16,)
                  ],
                ),
              )
            ],
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
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter you Old Password';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hint: CustomText(
                        text: 'Enter you Old Password',
                        color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  Text(
                    "New Password".tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your New Password';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hint: CustomText(
                        text: 'Enter your New Password',
                        color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  Text(
                    "Confirm Password".tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Confirm Password';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hint: CustomText(
                        text: 'Enter your Confirm Password',
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
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter you First Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hint: CustomText(
                      text: 'Enter you First Name',
                      color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                    ),
                  ),
                ),
                SizedBox(height: 16.h,),
                Text(
                  "Last Name".tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Last Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hint: CustomText(
                      text: 'Enter your Last Name',
                      color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                    ),
                  ),
                ),
                SizedBox(height: 16.h,),
                Text(
                  "Hobby".tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Hobby';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hint: CustomText(
                      text: 'Enter your Hobby',
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
