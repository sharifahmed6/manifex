import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Share/text_title_small.dart';
import '../../all_course/practices/widget/transperent_gradient_border.dart';
import 'gradient_linear_progress.dart';

class MyStreakProgress extends StatelessWidget {
  const MyStreakProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _singleCard(
          progressCount: '508',
          title: 'Word Learned',
          progress: 0.5,
          color1: Color(0xffFFD6B7),
          color2: Color(0xffE07C2F),
        ),
        SizedBox(height: 16.h),
        _singleCard(
          progressCount: '34',
          title: 'Day Streak',
          progress: 0.8,
          color1: Color(0xffFFA6C8),
          color2: Color(0xffB920ED),
        ),
        SizedBox(height: 16.h),
        _singleCard(
          progressCount: '95%',
          title: 'Accuracy',
          progress: 0.3,
          color1: Color(0xffB2DEFF),
          color2: Color(0xff3BA3F2),
        ),
        SizedBox(height: 16.h),
        TransparentGradientBorder(
          strokeWidth: 0.5,
          radius: 16.r,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [
                  const Color(0xff111217).withAlpha(50),
                  const Color(0xffCFDBFF).withAlpha(30),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '12',
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: 'Badge Earned',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                ),
                SizedBox(height: 8.h),
                Row(
                  spacing: 8.w,
                  children: [
                    Image.asset(
                      'assets/icons/total badge.png',
                      width: 70.w,
                      height: 16.h,
                    ),
                    CustomText(text: '+9 More', fontWeight: FontWeight.w600),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TransparentGradientBorder _singleCard({
    String? progressCount,
    String? title,
    double? progress,
    Color? color1,
    Color? color2,
  }) {
    return TransparentGradientBorder(
      strokeWidth: 0.5,
      radius: 16.r,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: [
              const Color(0xff111217).withAlpha(50),
              const Color(0xffCFDBFF).withAlpha(30),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: progressCount ?? '',
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: title ?? '',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
            ),
            SizedBox(height: 16.h),
            GradientLinearProgress(
              value: progress ?? 0.0,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: LinearGradient(
                colors: [
                  color1 ?? Colors.transparent,
                  color2 ?? Colors.transparent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
