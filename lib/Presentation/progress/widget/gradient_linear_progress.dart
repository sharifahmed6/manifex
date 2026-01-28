import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientLinearProgress extends StatelessWidget {
  final double value;
  final Gradient gradient;
  final double height;
  final Color backgroundColor;

  const GradientLinearProgress({
    super.key,
    required this.value,
    required this.gradient,
    this.height = 6,
    this.backgroundColor = const Color(0xffFFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: Stack(
        children: [
          Container(
            height: height,
            color: backgroundColor,
          ),
          FractionallySizedBox(
            widthFactor: v,
            alignment: Alignment.centerLeft,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(16.r)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
