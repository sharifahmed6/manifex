import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../App/AppColors.dart';

class CustomCircleProgressIndicator extends StatelessWidget {
  const CustomCircleProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.blue,
        size: 50.sp,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
