import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';

import '../all_course/practices/widget/transperent_gradient_border.dart';
import 'button_gradient.dart';

class SingleSkillCard extends StatelessWidget {
  const SingleSkillCard({
    super.key,
    this.imagePath,
    this.title,
    this.subTitle,
    this.onTap,
    this.isComplete = false,
    this.buttonText,
    this.lock = false,
  });
  final String? imagePath;
  final String? title;
  final String? subTitle;
  final VoidCallback? onTap;
  final bool isComplete;
  final String? buttonText;
  final bool lock;
  @override
  Widget build(BuildContext context) {
    return TransparentGradientBorder(
      strokeWidth: 0.5,
      child: Container(
        width: double.infinity,
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
        child: _SkillCard(
          imagePath: imagePath,
          title: title,
          subTitle: subTitle,
          buttonText: buttonText,
          onTap: onTap,
          isComplete: isComplete,
          lock: lock,
        ),
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({
    this.imagePath,
    this.title,
    this.subTitle,
    this.onTap,
    required this.isComplete,
    this.buttonText,
    required this.lock
  });
  final String? imagePath;
  final String? title;
  final String? subTitle;
  final VoidCallback? onTap;
  final bool isComplete;
  final String? buttonText;
  final bool lock;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF).withAlpha((2.56 * 17).toInt()),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: isComplete
              ? Image.asset(imagePath ?? '', width: 32.w, height: 32.h)
              : CustomText(
                  text: buttonText ?? '',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
        ),
        SizedBox(height: 16.h),
        CustomText(
          text: title ?? '',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        CustomText(
          text: subTitle ?? '',
          color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
        ),
        SizedBox(height: 16.h),
        if (isComplete)
          ButtonGradient(
            onTap: lock? onTap : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
              lock ? SizedBox.shrink() : Icon(Icons.lock_outline,color: Colors.white,),
                CustomText(text: buttonText ?? '',fontSize: 16,fontWeight: FontWeight.w600,)],
            ),
          ),
      ],
    );
  }
}
