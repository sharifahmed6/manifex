import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';

class CustomBackButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        GestureDetector(
          onTap: onTap ?? () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32.sp,
          ),
        ),
        CustomText(
          text: text ?? '',
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
