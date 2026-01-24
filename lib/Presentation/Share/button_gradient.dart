import 'package:flutter/material.dart';
import '../../App/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonGradient extends StatelessWidget {
  final Widget? child;
  final double height;
  final double borderRadius;
  final VoidCallback? onTap;
  final String text;

  const ButtonGradient({
    super.key,
    this.child,
    this.height = 52,
    this.borderRadius = 16,
    this.onTap,
    this.text = "Button",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            colors: [
              AppColors.yellow,
              AppColors.pink,
              AppColors.sky,
            ],
          ),
        ),
        child: Center(
          child: child ?? Text(
            text,
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
