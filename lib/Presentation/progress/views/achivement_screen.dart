import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/progress/controllers/progress_controller.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';

import '../widget/achivenents_card.dart';

class AchivementScreen extends StatelessWidget {
  AchivementScreen({super.key});
  final controller = Get.find<ProgressController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isBadgeLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CustomCircleProgressIndicator(),
          ),
        );
      }

      if (controller.userBadges.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "No achievements found",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        );
      }

      return Column(
        children: controller.userBadges.map((badge) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: AchivenentsCard(
              lock: badge.isUnlocked,
              imagePath: badge.icon,
              title: badge.name,
              subTitle: badge.description,
            ),
          );
        }).toList(),
      );
    });
  }
}
