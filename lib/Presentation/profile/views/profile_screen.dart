import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import 'package:manifex/Presentation/progress/widget/gradient_border_avater.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../App/assets_path.dart';
import '../../../Core/SharepreferenceHelper.dart';
import '../../../Core/loading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            children: [
              _profileInfo(),
              SizedBox(height: 20.h),
              Container(
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
                  children: [
                    _customItem(
                      imagePath: 'assets/icons/account_icon.png',
                      title: 'Account & Security',
                      onTap: () {
                        Get.toNamed(routes.profile_edit_screen);
                      },
                    ),
                    SizedBox(height: 8.h),
                    Divider(
                      color: Color(0xffFFFFFF).withAlpha((2.56 * 22).toInt()),
                    ),
                    SizedBox(height: 16.h),
                    _customItem(
                      imagePath: 'assets/icons/subscription_plan.png',
                      title: 'Subscription Plan',
                      onTap: () {},
                    ),
                    SizedBox(height: 8.h),
                    Divider(
                      color: Color(0xffFFFFFF).withAlpha((2.56 * 22).toInt()),
                    ),
                    SizedBox(height: 16.h),
                    _customItem(
                      imagePath: 'assets/icons/language.png',
                      title: 'Language',
                      onTap: () {
                        Get.toNamed(routes.language_screen);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
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
                  children: [
                    _customItem(
                      imagePath: 'assets/icons/check_icon.png',
                      title: 'About Us',
                      onTap: () {
                        Get.toNamed(routes.about_us_screen);
                      },
                    ),
                    SizedBox(height: 8.h),
                    Divider(
                      color: Color(0xffFFFFFF).withAlpha((2.56 * 22).toInt()),
                    ),
                    SizedBox(height: 16.h),
                    _customItem(
                      imagePath: 'assets/icons/documents.png',
                      title: 'Terms & Conditions',
                      onTap: () {
                        Get.toNamed(routes.terms_conditon_screen);
                      },
                    ),
                    SizedBox(height: 8.h),
                    Divider(
                      color: Color(0xffFFFFFF).withAlpha((2.56 * 22).toInt()),
                    ),
                    SizedBox(height: 16.h),
                    _customItem(
                      imagePath: 'assets/icons/lock.png',
                      title: 'Privacy Policy',
                      onTap: () {
                        Get.toNamed(routes.privacy_policy_screen);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
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
                  children: [
                    _customItem(
                      imagePath: 'assets/icons/unlock_rewards.png',
                      title: 'Unlock Rewards',
                      onTap: () {
                     Get.toNamed(routes.unlock_rewards_screen);
                      },
                    ),
                    SizedBox(height: 8.h),
                    Divider(
                      color: Color(0xffFFFFFF).withAlpha((2.56 * 22).toInt()),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: AppColors.primary,
                            title: const Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),),
                            content: const Text("Are you sure you want to logout?"),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text("Cancel", style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Get.back();
                                        AppLoader.show();
                                        await PrefHelper.clear();
                                        AppLoader.hide();
                                        await Purchases.logOut();
                                        Get.offAllNamed(routes.login_screen);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text(
                                        "Logout",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          barrierDismissible: false,
                        );

                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/logout_icon.png',
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 8.w),
                          CustomText(
                            text: 'Logout',
                            fontSize: 16,
                            color: Color(0xffFF5959),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customItem({String? imagePath, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(imagePath ?? '', width: 24, height: 24),
          SizedBox(width: 8.w),
          Expanded(child: CustomText(text: title ?? '', fontSize: 16)),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
            size: 24.sp,
          ),
        ],
      ),
    );
  }

  Widget _profileInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GradientBorderAvatar(
          image: AssetImage(assets_path.splash_image),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6.h,
            children: [
              CustomText(text: '${PrefHelper.getFirstName()} ${PrefHelper.getLastName()}', fontSize: 24),
              CustomText(
                text: PrefHelper.getEmail(),
                fontSize: 16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w300,
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF).withAlpha((2.56 * 12).toInt()),
              borderRadius: BorderRadius.circular(100.r),
              border: BoxBorder.all(
                color: Color(0xffFFFFFF).withAlpha((2.56 * 22).toInt()),
              ),
            ),
            child: Row(
              spacing: 8.w,
              children: [
                Image.asset(
                  'assets/icons/premium_icon.png',
                  width: 16,
                  height: 16,
                ),
                CustomText(text: 'Premium'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
