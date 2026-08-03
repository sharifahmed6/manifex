import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Features/Subcription/View/Subcription.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/Share/welcome_card.dart';
import 'package:manifex/Presentation/Share/show_dialog.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import 'package:manifex/Presentation/progress/controllers/progress_controller.dart';
import '../../../Core/SharepreferenceHelper.dart';
import '../widget/gradient_border_avater.dart';
import '../widget/learning_progress_card.dart';
import '../widget/my_streak_progress.dart';
import 'achivement_screen.dart';
import 'daily_average_progress.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});
  final controller = Get.find<ProgressController>();
  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: RefreshIndicator(
        onRefresh: () => controller.refreshData(),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _gradientTitle(
                  normalText: "Learning You ".tr,
                  gradientText: "Can See".tr,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text:
                      'Track your learning journey with daily stats, streaks  and achievements — see how far you’ve come.'
                          .tr,
                  fontSize: 16,
                  color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                  textAlign: TextAlign.start,
                ),
                Center(
                  child: GradientBorderAvatar(
                    image: AssetImage('assets/images/splash_icon.png'),
                  ),
                ),
                SizedBox(height: 5.h),
                WelcomeCard(
                  name: PrefHelper.getFirstName(),
                  describe:
                      'I can see how much effort you’ve put in! Together, we’ll keep improving your reading, writing, and speaking skills.'
                          .tr,
                ),
                SizedBox(height: 10.h),
                DailyAverageProgress(),
                _gradientTitle(
                  normalText: "Learning You ",
                  gradientText: "Can See",
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text:
                      'Track your 30-day, 60-day, and 90-day growth visually, designed for both learners and parents'
                          .tr,
                  fontSize: 16,
                  color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                ),
                SizedBox(height: 16.h),
                LearningProgressCard(),
                SizedBox(height: 16.h),
                CustomText(
                  text:
                      'Our advanced analytics dashboard provides real-time insights into learning progress, helping both students and parents understand achievements and areas for improvement.'
                          .tr,
                  fontSize: 16,
                  color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                ),
                SizedBox(height: 8.h),
                MyStreakProgress()
              ],
            ),
          ),
        ),
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
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
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
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
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
