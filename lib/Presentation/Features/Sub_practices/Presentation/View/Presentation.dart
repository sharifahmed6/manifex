import 'package:flutter/material.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/Core/responsive.dart';
import 'package:manifex/Presentation/Share/back_button.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../App/assets_path.dart';
import '../../../../Share/GradientMask.dart';
import '../../../../Share/button_gradient.dart';
import '../../../../Share/text_title_small.dart';
import '../../../../all_course/practices/widget/transperent_gradient_border.dart';
import '../../../../progress/widget/gradient_linear_progress.dart';
import '../Controller/Controller.dart';

class presentation extends StatelessWidget {
  presentation({super.key});
  final controller = Get.find<presentation_controller>();

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPractice(),
      _buildProgress()
    ];
    return scaffold_background(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: back_button(),
          title: Text("Presentation Practice".tr, style: TextStyle(color: Colors.white, fontSize: ScreenResponsive.responsiveFont(context, 18)),),
          titleSpacing: -10,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.sky
                  )
                ),
                child: Obx(() => Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          controller.tab_text.value = "practices";
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(colors: controller.tab_text.value == "practices" ? [
                                AppColors.yellow,
                                AppColors.pink,
                                AppColors.sky
                              ] : [Colors.transparent, Colors.transparent])
                          ),
                          child: Center(child: Text("Practices".tr,style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 18), fontWeight: FontWeight.w600),)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          controller.tab_text.value = "progress";
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                  colors: controller.tab_text.value == "progress" ?  [
                                    AppColors.sky,
                                    AppColors.pink,
                                    AppColors.yellow
                                  ] : [Colors.transparent, Colors.transparent])
                          ),
                          child: Center(child: Text("Progress".tr,style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 18), fontWeight: FontWeight.w600),)),
                        ),
                      ),
                    )
                  ],
                ),)
              ),
              SizedBox(height: 20,),

              Expanded(
                child: SingleChildScrollView(
                  child: Obx(() => pages[controller.tab_text.value == "practices" ? 0 : 1]),
                ),
              )


            ],
          ),
        ));
  }

}

// _buildProgress()

class _buildProgress extends StatelessWidget {
  const _buildProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 70,
            width: 70,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                AppColors.yellow,
                AppColors.pink,
                AppColors.sky
              ]),

            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: "https://img.freepik.com/free-photo/courage-man-jump-through-gap-hill-business-concept-idea_1323-262.jpg?semt=ais_hybrid&w=740&q=80",
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                      child: CircularProgressIndicator.adaptive()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
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
              SizedBox(width: double.infinity,),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 7,
                runSpacing: 4,
                children: [
                  GradientMask(
                    child: Text(
                      "Sadid Ahammed!",
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
                    "Welcome back",
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
                "I'm Mercury, your AI reading companion. Today we'll practice reading together with some exciting challenges. Are you ready to unlock your potential?"
                    .tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            _progressCard(
              color1: Color(0xffFFD6B7),
              color2: Color(0xffE07C2F),
              imagePath: assets_path.fire,
              leftTitle: 'Streak',
              context: context,
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
              context: context,
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
            _progressCard(
              context: context,
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
            _progressCard(
              context: context,
              color1: Color(0xff11D067),
              color2: Color(0xff01803A),
              imagePath: 'assets/icons/progress.png',
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
          ],
        )



      ],
    );
  }
}

// _buildPractice(),

class _buildPractice extends StatelessWidget {
  const _buildPractice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 70,
            width: 70,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  AppColors.yellow,
                  AppColors.pink,
                  AppColors.sky
                ]),

            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: "https://img.freepik.com/free-photo/courage-man-jump-through-gap-hill-business-concept-idea_1323-262.jpg?semt=ais_hybrid&w=740&q=80",
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                      child: CircularProgressIndicator.adaptive()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
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
              SizedBox(width: double.infinity,),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 7,
                runSpacing: 4,
                children: [
                  GradientMask(
                    child: Text(
                      "Sadid Ahammed!",
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
                    "Welcome back",
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
                "I'm Mercury, your AI reading companion. Today we'll practice reading together with some exciting challenges. Are you ready to unlock your potential?"
                    .tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text("Presentation".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 18), fontWeight: FontWeight.w600),),
            GradientMask(child: Text(" Tasks".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 18), fontWeight: FontWeight.w600)))
          ],
        ),
        Text("Complete each task to improve your presentation skill".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 12),),),
        SizedBox(height: 10,),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TransparentGradientBorder(
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
                      Text(
                        'Power Words Pulse',
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(context, 18),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Helping children learn powerful words through games, sounds, and playful daily practice.',
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(context, 14),
                        ),
                      ),
                      SizedBox(height: 10),
                      ButtonGradient(text: 'Task ${index+1}'),
                    ],
                  ),
                ),
              ),
            );
          }
        )


      ],
    );
  }
}

Widget _progressCard({
  Color? color1,
  Color? color2,
  String? imagePath,
  String? leftTitle,
  Widget? leftSubtitle,
  String? rightTitle,
  String? rightSubtitle,
  required BuildContext context,
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
                      fontSize: ScreenResponsive.responsiveFont(context, 16),
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
