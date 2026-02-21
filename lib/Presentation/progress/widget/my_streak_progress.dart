import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/progress/controllers/progress_controller.dart';
import '../../Share/custom_circle_progress_indicator.dart';
import '../../Share/text_title_small.dart';
import '../../all_course/practices/widget/transperent_gradient_border.dart';
import 'gradient_linear_progress.dart';

class MyStreakProgress extends StatelessWidget {
  const MyStreakProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProgressController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CustomCircleProgressIndicator(),
          ),
        );
      }
      final p = controller.userProgress.value.data;
      if (p == null) return const SizedBox.shrink();

      return Column(
        children: [
          _singleCard(
            progressCount: '${p.totalWords}',
            title: 'Word Learned',
            progress: 1.0, // Fixed or based on a goal if exists
            color1: const Color(0xffFFD6B7),
            color2: const Color(0xffE07C2F),
          ),
          SizedBox(height: 16.h),
          _singleCard(
            progressCount: '${p.dayStreak}',
            title: 'Day Streak',
            progress: 0.8, // Static indicator style or based on goal
            color1: const Color(0xffFFA6C8),
            color2: const Color(0xffB920ED),
          ),
          SizedBox(height: 16.h),
          _singleCard(
            progressCount: '${p.overallAccuracy}%',
            title: 'Accuracy',
            progress: (p.overallAccuracy / 100).clamp(0.0, 1.0),
            color1: const Color(0xffB2DEFF),
            color2: const Color(0xff3BA3F2),
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
                    text: '${p.totalBadges}',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: 'Badge Earned',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: const Color(
                      0xffFFFFFF,
                    ).withAlpha((2.56 * 90).toInt()),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    spacing: 8.w,
                    children: [
                      if (p.badges.isNotEmpty)
                        Image.asset(
                          'assets/icons/total badge.png',
                          width: 70.w,
                          height: 16.h,
                        ),
                      if (p.badges.length > 1)
                        CustomText(
                          text: '+${p.badges.length - 1} More',
                          fontWeight: FontWeight.w600,
                        ),
                      if (p.badges.isEmpty)
                        const CustomText(
                          text: 'No badges yet',
                          fontWeight: FontWeight.w500,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
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
