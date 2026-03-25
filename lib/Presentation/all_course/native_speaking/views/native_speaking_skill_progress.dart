import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../App/assets_path.dart';
import '../../../Share/progress_card.dart';
import '../../../progress/widget/gradient_linear_progress.dart';
import '../../practices/widget/skill_welcome_card.dart';
import '../controller/native_speaking_skill_controller.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';

class NativeSpeakingSkillProgress extends StatelessWidget {
  const NativeSpeakingSkillProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          SkillWelcomeCard(),
          SizedBox(height: 16.h),
          Obx(() {
            return ProgressCard(
              color1: Color(0xffFFD6B7),
              color2: Color(0xffE07C2F),
              imagePath: AssetsPath.fire,
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
            final ctrl = Get.find<NativeSpeakingSkillController>();
            ctrl.tick.value;
            final elapsed = ctrl.currentTime;
            return ProgressCard(
              color1: Color(0xffFFA6C8),
              color2: Color(0xffB920ED),
              imagePath: 'assets/icons/watch_icon.png',
              leftTitle: 'Session Timer',
              rightTitle: ctrl.format(elapsed),
              rightSubtitle: 'Remaining',
            );
          }),
          SizedBox(height: 10.h),
          Obx(() {
            final ctrl = Get.find<NativeSpeakingSkillController>();
            final done = ctrl.currentTask.value;
            final fraction = (done / 4.0).clamp(0.0, 1.0);
            return ProgressCard(
              color1: Color(0xffB2DEFF),
              color2: Color(0xff3BA3F2),
              imagePath: 'assets/icons/progress.png',
              leftTitle: 'Progress',
              rightTitle: '$done/4',
              rightSubtitle: 'Tasks Done',
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
            final accuracyPercent =
                (homeController
                            .profileInfo
                            .value
                            ?.data
                            ?.userProgress
                            ?.overallAccuracy ??
                        0)
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
