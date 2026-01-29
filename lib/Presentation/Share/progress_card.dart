import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';

import '../all_course/practices/widget/transperent_gradient_border.dart';
class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    this.color1,
    this.color2,
    this.imagePath,
    this.leftTitle,
    this.leftSubtitle,
    this.rightTitle,
    this.rightSubtitle,
    this.radius,
    this.strokeWidth = 0.5,
  });

  final Color? color1;
  final Color? color2;
  final String? imagePath;
  final String? leftTitle;
  final Widget? leftSubtitle;
  final String? rightTitle;
  final String? rightSubtitle;

  final double? radius;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final r = radius ?? 16.r;

    return TransparentGradientBorder(
      strokeWidth: strokeWidth,
      radius: r,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r),
          gradient: LinearGradient(
            colors: [
              const Color(0xff111217).withAlpha(30),
              const Color(0xffCFDBFF).withAlpha(20),
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
                // Left side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _IconCircle(
                      color1: color1,
                      color2: color2,
                      imagePath: imagePath,
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      text: leftTitle ?? '',
                      color: const Color(0xffFFFFFF)
                          .withAlpha((2.56 * 90).toInt()),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),

                // Right side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      color: const Color(0xffFFFFFF)
                          .withAlpha((2.56 * 90).toInt()),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),

            leftSubtitle ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({
    this.color1,
    this.color2,
    this.imagePath,
  });

  final Color? color1;
  final Color? color2;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ).copyWith(
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
    );
  }
}
