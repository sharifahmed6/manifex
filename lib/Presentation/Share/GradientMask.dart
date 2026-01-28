import 'package:flutter/material.dart';

import '../../App/AppColors.dart';

class GradientMask extends StatelessWidget {
  Widget child;
  GradientMask({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            AppColors.yellow,
            AppColors.pink,
            AppColors.sky,
          ],
        ).createShader(bounds);
      },
      child: child
    );
  }
}
