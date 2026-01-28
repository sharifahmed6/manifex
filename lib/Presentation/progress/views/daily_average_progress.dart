import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../App/assets_path.dart';
import '../../Share/text_title_small.dart';
import '../../practices/widget/transperent_gradient_border.dart';
import '../widget/gradient_linear_progress.dart';

class DailyAverageProgress extends StatelessWidget {
  const DailyAverageProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
