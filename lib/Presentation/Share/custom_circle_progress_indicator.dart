import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCircleProgressIndicator extends StatelessWidget {
  final double? size;
  final Color? color;

  const CustomCircleProgressIndicator({super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: color ?? Colors.white,
        size: size ?? 30.sp,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
