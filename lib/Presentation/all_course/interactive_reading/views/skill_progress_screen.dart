import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';
import 'package:manifex/Presentation/all_course/interactive_reading/controller/interactive_reading_controller.dart';
import 'package:manifex/Presentation/progress/widget/gradient_border_avater.dart';
import '../../../../App/assets_path.dart';
import '../../../Share/progress_card.dart';
import '../../../progress/widget/gradient_linear_progress.dart';
import '../../practices/widget/skill_welcome_card.dart';

class SkillProgressScreen extends StatelessWidget {
  SkillProgressScreen({super.key});
  final controller = Get.find<InteractiveReadingController>();
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SkillWelcomeCard(),
          SizedBox(height: 16.h),
          Obx(() {
            return ProgressCard(
              color1: Color(0xffFFD6B7),
              color2: Color(0xffE07C2F),
              imagePath: assets_path.fire,
              leftTitle: 'Streak',
              leftSubtitle: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [Color(0xffFFD6B7), Color(0xffE07C2F)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: Text(
                  "Keep it up!",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              rightTitle:
                  '${homeController.profileInfo.value?.data?.userProgress?.dayStreak ?? 0}',
              rightSubtitle: 'Days Streak!',
            );
          }),
          SizedBox(height: 10.h),
          Obx(() {
            controller.tick.value;
            final elapsed = controller.currentTime;
            return ProgressCard(
              color1: Color(0xffFFA6C8),
              color2: Color(0xffB920ED),
              imagePath: 'assets/icons/watch_icon.png',
              leftTitle: 'Session Timer',
              rightTitle: controller.format(elapsed),
              rightSubtitle: 'Remaining',
            );
          }),
          SizedBox(height: 10.h),
          Obx(() {
            final current = controller.currentTask.value;
            const total = 4;
            final fraction = current / total;
            return ProgressCard(
              color1: Color(0xffB2DEFF),
              color2: Color(0xff3BA3F2),
              imagePath: 'assets/icons/progress.png',
              leftTitle: 'Progress',
              rightTitle: '$current/$total',
              rightSubtitle: 'Tasks',
              leftSubtitle: GradientLinearProgress(
                value: fraction,
                height: 7.h,
                backgroundColor: Color(
                  0xffFFFFFF,
                ).withAlpha((2.56 * 15).toInt()),
                gradient: const LinearGradient(
                  colors: [Color(0xffB2DEFF), Color(0xff3BA3F2)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            );
          }),
          SizedBox(height: 10.h),
          Obx(() {
            final accuracyPercent = (homeController.profileInfo.value?.data?.userProgress?.overallAccuracy ?? 0)
                .toDouble();

            final progressValue = (accuracyPercent / 100).clamp(0.0, 1.0);
            return ProgressCard(
              color1: Color(0xff11D067),
              color2: Color(0xff01803A),
              imagePath: 'assets/icons/champion.png',
              leftTitle: 'Today’s Goal',
              rightTitle:
                  '${homeController.profileInfo.value?.data?.userProgress?.overallAccuracy.toInt() ?? 0}%',
              rightSubtitle: 'Accuracy',
              leftSubtitle: GradientLinearProgress(
                value: progressValue,
                height: 7.h,
                backgroundColor: Color(
                  0xffFFFFFF,
                ).withAlpha((2.56 * 15).toInt()),
                gradient: const LinearGradient(
                  colors: [Color(0xff11D067), Color(0xff01803A)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            );
          }),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
