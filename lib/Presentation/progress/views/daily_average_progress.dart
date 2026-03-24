import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/progress/controllers/progress_controller.dart';
import '../../../App/assets_path.dart';
import '../../Share/custom_circle_progress_indicator.dart';
import '../../Share/progress_card.dart';
import '../widget/gradient_linear_progress.dart';

class DailyAverageProgress extends StatelessWidget {
  const DailyAverageProgress({super.key});

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
          ProgressCard(
            color1: const Color(0xffFFD6B7),
            color2: const Color(0xffE07C2F),
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
            rightTitle: '${p.dayStreak}',
            rightSubtitle: 'Days Streak!',
          ),
          SizedBox(height: 10.h),
          ProgressCard(
            color1: const Color(0xffFFA6C8),
            color2: const Color(0xffB920ED),
            imagePath: AssetsPath.timeFile,
            leftTitle: 'Session Timer',
            rightTitle: controller.formatSeconds(p.todaySessionTime),
            rightSubtitle: 'Total Spent',
          ),
          SizedBox(height: 10.h),
          ProgressCard(
            color1: const Color(0xffFFA6C8),
            color2: const Color(0xffB920ED),
            imagePath: 'assets/icons/watch_icon.png',
            leftTitle: 'Lessons',
            rightTitle: '${p.todayLessons}',
            rightSubtitle: 'Today',
          ),
          SizedBox(height: 10.h),
          ProgressCard(
            color1: const Color(0xffB2DEFF),
            color2: const Color(0xff3BA3F2),
            imagePath: 'assets/icons/progress.png',
            leftTitle: 'Progress',
            rightTitle: '${p.dailyGoalCompleted}/${p.dailyGoal}',
            rightSubtitle: 'Completed',
            leftSubtitle: GradientLinearProgress(
              value: (p.dailyGoal > 0)
                  ? (p.dailyGoalCompleted / p.dailyGoal).clamp(0.0, 1.0)
                  : 0.0,
              height: 7.h,
              backgroundColor: const Color(
                0xffFFFFFF,
              ).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [Color(0xffB2DEFF), Color(0xff3BA3F2)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          ProgressCard(
            color1: const Color(0xff11D067),
            color2: const Color(0xff01803A),
            imagePath: 'assets/icons/champion.png',
            leftTitle: 'Today\'s Goal',
            rightTitle: '${p.todayAccuracy}%',
            rightSubtitle: 'Accuracy',
            leftSubtitle: GradientLinearProgress(
              value: (p.todayAccuracy / 100).clamp(0.0, 1.0),
              height: 7.h,
              backgroundColor: const Color(
                0xffFFFFFF,
              ).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [Color(0xff11D067), Color(0xff01803A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      );
    });
  }
}
