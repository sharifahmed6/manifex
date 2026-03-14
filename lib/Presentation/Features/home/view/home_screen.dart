import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifex/App/assets_path.dart';
import 'package:manifex/Core/SharepreferenceHelper.dart';
import 'package:manifex/Core/responsive.dart';
import 'package:manifex/Presentation/Share/GradientMask.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../../../../App/AppColors.dart';
import '../../../../App/routes.dart';
import '../../../all_course/interactive_reading/views/task_one.dart';
import '../../../all_course/practices/widget/transperent_gradient_border.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(ScreenResponsive.r(context, 15)),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(
                    ScreenResponsive.r(context, 12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    SizedBox(width: double.infinity),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 7,
                      runSpacing: 4,
                      children: [
                        GradientMask(
                          child: Text(
                            "${PrefHelper.getFirstName()} ${PrefHelper.getLastName()}!",
                            style: TextStyle(
                              fontSize: ScreenResponsive.responsiveFont(
                                context,
                                20,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Welcome back".tr,
                          style: TextStyle(
                            fontSize: ScreenResponsive.responsiveFont(
                              context,
                              20,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "I'm Mercury, your AI reading companion. Today we'll practice reading together!"
                          .tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenResponsive.h(context, 10)),
              Text(
                "Today Progress".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.7,
                              heightFactor: 0.6,
                              child: Image.asset(
                                assets_path.time_file,
                                width: ScreenResponsive.w(context, 200),
                                height: ScreenResponsive.h(context, 200),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 21,
                            left: 21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Words".tr,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    controller.totalWords,
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        12,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.7,
                              heightFactor: 0.6,
                              child: Image.asset(
                                assets_path.streak_file,
                                width: ScreenResponsive.w(context, 200),
                                height: ScreenResponsive.h(context, 200),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 21,
                            left: 21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Streak".tr,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),

                                Obx(
                                  () => Text(
                                    "${controller.dayStreak} ${"Days".tr}",
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        12,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.7,
                              heightFactor: 0.6,
                              child: Image.asset(
                                assets_path.progress_file,
                                width: ScreenResponsive.w(context, 200),
                                height: ScreenResponsive.h(context, 200),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 21,
                            left: 21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Daily Goal".tr,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    controller.dailyGoal,
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        12,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.7,
                              heightFactor: 0.6,
                              child: Image.asset(
                                assets_path.goal_file,
                                width: ScreenResponsive.w(context, 200),
                                height: ScreenResponsive.h(context, 200),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 21,
                            left: 21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today’s Goal".tr,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    "${controller.overallAccuracy}% ${" Accuracy".tr}",
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        12,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: ScreenResponsive.h(context, 10)),
              Text(
                "Running Practices".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ScreenResponsive.h(context, 10)),
              TransparentGradientBorder(
                strokeWidth: 0.5,
                radius: 16.r,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff111217).withAlpha(50),
                        Color(0xffCFDBFF).withAlpha(30),
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  child: Column(
                    spacing: 5,
                    children: [
                      SizedBox(width: double.infinity),
                      Text(
                        "Phoneme Flashcards".tr,
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(
                            context,
                            18,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Complete each task to improve your English reading skill"
                            .tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(
                            context,
                            16,
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenResponsive.h(context, 10)),
                      SizedBox(
                        width: ScreenResponsive.w(context, 200),
                        height: ScreenResponsive.h(context, 50),
                        child: ButtonGradient(
                          text: "Start Practices".tr,
                          onTap: () => Get.to(TaskOne()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: ScreenResponsive.h(context, 10)),
              Text(
                "Trending Practices".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ScreenResponsive.h(context, 10)),

              _practicesCard(
                imagePath: 'assets/images/book.png',
                title: 'Interactive Reading'.tr,
                subTitle:
                    'Phoneme recognition and word games with visual cues designed for dyslexic learners'
                        .tr,
                context: context,
                onTap: () => Get.toNamed(routes.interactive_reading_screen),
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/icons/smart_writing_icon.png',
                title: 'Smart Writing'.tr,
                subTitle:
                    'Write. Learn. Improve. AI checks your grammar, structure, and style instantly.'
                        .tr,
                context: context,
                onTap: () => Get.toNamed(routes.smart_writing_screen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _practicesCard({
  String? imagePath,
  String? title,
  String? subTitle,
  VoidCallback? onTap,
  required BuildContext context,
}) {
  return TransparentGradientBorder(
    strokeWidth: 0.5,
    radius: ScreenResponsive.r(context, 16),
    child: Container(
      padding: EdgeInsets.all(ScreenResponsive.r(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenResponsive.r(context, 16)),
        gradient: LinearGradient(
          colors: [
            Color(0xff111217).withAlpha(50),
            Color(0xffCFDBFF).withAlpha(30),
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Container(
            padding: EdgeInsets.all(ScreenResponsive.r(context, 16)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                ScreenResponsive.r(context, 12),
              ),
              color: AppColors.white.withAlpha((2.56 * 17).toInt()),
            ),
            child: Image.asset(
              imagePath ?? '',
              width: ScreenResponsive.w(context, 35),
              height: ScreenResponsive.h(context, 32),
            ),
          ),
          Text(
            title ?? '',
            style: TextStyle(
              fontSize: ScreenResponsive.responsiveFont(context, 16),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            subTitle ?? '',
            style: TextStyle(
              fontSize: ScreenResponsive.responsiveFont(context, 12),
            ),
          ),
          SizedBox(height: 10.h),
          ButtonGradient(text: 'Start Reading'.tr, onTap: onTap),
        ],
      ),
    ),
  );
}
