import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../App/assets_path.dart';
import '../../../Share/welcome_card.dart';
import '../../../progress/widget/gradient_border_avater.dart' show GradientBorderAvatar;

class SkillWelcomeCard extends StatelessWidget {
  const SkillWelcomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GradientBorderAvatar(
            image: AssetImage(assets_path.splash_image),
          ),
        ),
        SizedBox(height: 8.h,),
        WelcomeCard(
          name: 'Sharif',
          describe: "I'm Mercury, your AI reading companion. Today we'll practice reading together with some exciting challenges. Are you ready to unlock your potential?",
        ),
      ],
    );
  }
}