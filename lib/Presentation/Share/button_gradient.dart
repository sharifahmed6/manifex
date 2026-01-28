import 'package:flutter/material.dart';
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

  double _responsiveFont(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / 375; // base width (iPhone X design standard)
    final value = size * scale;
    return value.clamp(size * 0.85, size * 1.2); // prevent too small/large text
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.065, // responsive height
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius ?? MediaQuery.of(context).size.width * 0.04, // responsive radius
          ),
          gradient: LinearGradient(
            colors: [
              AppColors.yellow,
              AppColors.pink,
              AppColors.sky,
            ],
          ),
        ),
        child: Center(
          child: child ??
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: _responsiveFont(context, 16), // responsive font
                ),
              ),
        ),
      ),
    );
  }
}
