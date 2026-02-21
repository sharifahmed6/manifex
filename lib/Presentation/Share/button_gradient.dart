import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../App/AppColors.dart';

class ButtonGradient extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? borderRadius;
  final VoidCallback? onTap;
  final String text;

  const ButtonGradient({
    super.key,
    this.child,
    this.height,
    this.borderRadius,
    this.onTap,
    this.text = "Button",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 48.h,
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 38.h.clamp(40, 60),
        ), // Ensure minimum usable height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          gradient: LinearGradient(
            colors: [AppColors.yellow, AppColors.pink, AppColors.sky],
          ),
        ),
        child: Center(
          child:
              child ??
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
        ),
      ),
    );
  }
}
