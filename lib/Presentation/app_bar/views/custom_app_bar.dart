import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../App/AppColors.dart';
import '../../../App/assets_path.dart';
import '../../Features/home/controller/home_controller.dart';
import '../../Share/text_title_small.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Image.asset(AssetsPath.logo, width: 48.w, height: 48.h),
          Spacer(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha((2.56 * 12).toInt()),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF4E505D), width: 2),
            ),
            child: Obx(
                  () => Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6.w,
                children: [
                  Image.asset(AssetsPath.fire, width: 20.w, height: 20.h),
                  CustomText(
                    text:
                    '${controller.profileInfo.value?.data?.userProgress?.dayStreak ?? 0}',
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          /*          SizedBox(width: 8.w,),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha((2.56 * 12).toInt() ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFF4E505D),
                width: 2.w,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6.w,
              children: [
                Image.asset(AssetsPath.star,width: 20.w,height: 20.h,),
                CustomText(text: '777',fontWeight: FontWeight.w600,)
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
