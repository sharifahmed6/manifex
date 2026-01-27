import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/App/assets_path.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import 'package:manifex/Presentation/progress/controllers/progress_controller.dart';

import '../../practices/widget/transperent_gradient_border.dart';
import '../widget/achivenents.dart';
import '../widget/gradient_border_avater.dart';
import '../widget/gradient_linear_progress.dart';
import '../widget/learning_progress_card.dart';
import '../widget/my_streak_progress.dart';

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
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _gradientTitle(
                normalText: "Learning You ",
                gradientText: "Can See",
              ),
              SizedBox(height: 8.h),
              CustomText(
                text:
                    'Track your learning journey with daily stats, streaks  and achievements — see how far you’ve come.',
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
              _welcomeCard(context),
              SizedBox(height: 10.h),
              _progressCard(
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
              _progressCard(
                color1: Color(0xffFFA6C8),
                color2: Color(0xffB920ED),
                imagePath: 'assets/icons/watch_icon.png',
                leftTitle: 'Session Timer',
                rightTitle: '12:34',
                rightSubtitle: 'Remaining',
                leftSubtitle: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [Color(0xffFFA6C8), Color(0xffB920ED)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    );
                  },
                  child: LinearProgressIndicator(
                    value: 0.5,
                    minHeight: 6,
                    borderRadius: BorderRadiusGeometry.circular(100.r),
                    backgroundColor: Color(
                      0xffFFFFFF,
                    ).withAlpha((2.56 * 15).toInt()),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              _progressCard(
                color1: Color(0xffB2DEFF),
                color2: Color(0xff3BA3F2),
                imagePath: 'assets/icons/progress.png',
                leftTitle: 'Progress',
                rightTitle: '2/4',
                rightSubtitle: 'Remaining',
                leftSubtitle: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [Color(0xffB2DEFF), Color(0xff3BA3F2)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    );
                  },
                  child: LinearProgressIndicator(
                    value: 0.5,
                    minHeight: 6,
                    borderRadius: BorderRadiusGeometry.circular(100.r),
                    backgroundColor: Color(
                      0xffFFFFFF,
                    ).withAlpha((2.56 * 15).toInt()),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              _progressCard(
                color1: Color(0xff11D067),
                color2: Color(0xff01803A),
                imagePath: 'assets/icons/progress.png',
                leftTitle: 'Today’s Goal',
                rightTitle: '75%',
                rightSubtitle: 'Accuracy',
                leftSubtitle: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [Color(0xff11D067), Color(0xff01803A)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    );
                  },
                  child: LinearProgressIndicator(
                    value: 0.5,
                    minHeight: 6,
                    borderRadius: BorderRadiusGeometry.circular(100.r),
                    backgroundColor: Color(
                      0xffFFFFFF,
                    ).withAlpha((2.56 * 15).toInt()),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ),
              _gradientTitle(),
              _gradientTitle(
                normalText: "Learning You ",
                gradientText: "Can See",
              ),
              SizedBox(height: 8.h),
              CustomText(
                text:
                    'Track your 30-day, 60-day, and 90-day growth visually, designed for both learners and parents',
                fontSize: 16,
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
              SizedBox(height: 16.h),
              LearningProgressCard(),
              SizedBox(height: 16.h),
              CustomText(text: 'Our advanced analytics dashboard provides real-time insights into learning progress, helping both students and parents understand achievements and areas for improvement.',fontSize: 16,color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),),
              SizedBox(height: 8.h),
              MyStreakProgress(),
              SizedBox(height: 8.h),
              Achivenents()
            ],
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

  Widget _gradientName(double fontSize) {
    const gradient = LinearGradient(
      colors: [Color(0xFFFFBC6F), Color(0xFFF176B7), Color(0xFF3797CD)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final shader = gradient.createShader(
          Rect.fromLTWH(0, 0, constraints.maxWidth, 0),
        );

        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Hi Afsar! ",
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  foreground: Paint()..shader = shader,
                ),
              ),
              TextSpan(
                text: "Welcome Back!",
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffFFFFFF),
                ),
              ),
            ],
          ),
          softWrap: true,
        );
      },
    );
  }

  Widget _welcomeCard(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    const cardAspectRatio = 343 / 144;

    final titleSize = isLandscape ? 18.sp : 24.sp;
    final bodySize = isLandscape ? 12.sp : 16.sp;
    final topPad = isLandscape ? 100.h : 40.h;
    final bottomPad = isLandscape ? 10.h : 24.h;

    return AspectRatio(
      aspectRatio: cardAspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset('assets/images/welcome_shape.svg', fit: BoxFit.fill),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, topPad, 24.w, bottomPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _gradientName(titleSize),
                  SizedBox(height: 6.h),
                  CustomText(
                    text:
                        'I can see how much effort you’ve put in! Together, we’ll keep improving your reading, writing, and speaking skills.',
                    fontSize: bodySize,
                    color: Colors.white,
                    textAlign: TextAlign.start,
                    maxLines: isLandscape ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressCard({
    Color? color1,
    Color? color2,
    String? imagePath,
    String? leftTitle,
    Widget? leftSubtitle,
    String? rightTitle,
    String? rightSubtitle,
  }) {
    {
      return TransparentGradientBorder(
        strokeWidth: 0.5,
        radius: 16.r,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              colors: [
                Color(0xff111217).withAlpha(30),
                Color(0xffCFDBFF).withAlpha(20),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              color1 ?? Colors.transparent,
                              color2 ?? Colors.transparent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Image.asset(
                          imagePath ?? '',
                          color: Colors.white,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: leftTitle ?? '',
                        color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: rightTitle ?? '',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                      CustomText(
                        text: rightSubtitle ?? '',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              leftSubtitle ?? SizedBox.shrink(),
            ],
          ),
        ),
      );
    }
  }
}
