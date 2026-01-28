import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.fontSize,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.inter(
        fontSize: (fontSize ?? 14).sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: Get.isDarkMode
            ? (color ?? Colors.white)
            : (color ?? const Color(0xffFFFFFF)),
      ),
    );
  }
}
