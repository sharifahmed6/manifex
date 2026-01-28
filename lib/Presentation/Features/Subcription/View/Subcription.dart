import 'package:flutter/material.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../Core/responsive.dart';
import '../../../Share/GradientMask.dart';

class subscription extends StatelessWidget {
  const subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold_background(child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 7,
            runSpacing: 4,
            children: [
              Text(
                "Choose Your",
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(
                    context,
                    20,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              GradientMask(
                child: Text(
                  "Learning Path",
                  style: TextStyle(
                    fontSize: ScreenResponsive.responsiveFont(
                      context,
                      20,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Start your journey with our free trial, then choose the plan that fits your learning goals"
                .tr,
            style: TextStyle(
              fontSize: ScreenResponsive.responsiveFont(context, 16),
            ),
          ),

        ],
      ),
    ));
  }
}
