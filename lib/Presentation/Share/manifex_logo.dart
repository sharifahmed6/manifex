import 'package:flutter/material.dart';

import '../../App/AppColors.dart';

class logo_manifex extends StatelessWidget {
  const logo_manifex({
    super.key,
  });

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
      child: const Text(
        "MANIFEX",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white, // required
        ),
      ),
    );
  }
}