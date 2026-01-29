import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../App/assets_path.dart';
import '../../../Share/progress_card.dart';
import '../../../progress/widget/gradient_linear_progress.dart';
import '../../practices/widget/skill_welcome_card.dart';

class SmartWritingSkillProgress extends StatelessWidget {
  const SmartWritingSkillProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SkillWelcomeCard(),
          SizedBox(height: 16.h,),
          ProgressCard(
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
            rightTitle: '6',
            rightSubtitle: 'Days Streak!',
          ),
          SizedBox(height: 10.h),
          ProgressCard(
              color1: Color(0xffFFA6C8),
              color2: Color(0xffB920ED),
              imagePath: 'assets/icons/watch_icon.png',
              leftTitle: 'Session Timer',
              rightTitle: '12:34',
              rightSubtitle: 'Remaining',
              leftSubtitle: GradientLinearProgress(
                value: 0.5,
                height: 7.h,
                backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffFFA6C8),
                    Color(0xffB920ED),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              )
          ),
          SizedBox(height: 10.h),
          ProgressCard(
            color1: Color(0xffB2DEFF),
            color2: Color(0xff3BA3F2),
            imagePath: 'assets/icons/progress.png',
            leftTitle: 'Progress',
            rightTitle: '2/4',
            rightSubtitle: 'Remaining',
            leftSubtitle: GradientLinearProgress(
              value: 0.5,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffB2DEFF),
                  Color(0xff3BA3F2),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          ProgressCard(
            color1: Color(0xff11D067),
            color2: Color(0xff01803A),
            imagePath: 'assets/icons/champion.png',
            leftTitle: 'Today’s Goal',
            rightTitle: '75%',
            rightSubtitle: 'Accuracy',
            leftSubtitle: GradientLinearProgress(
              value: 0.5,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xff11D067),
                  Color(0xff01803A),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
