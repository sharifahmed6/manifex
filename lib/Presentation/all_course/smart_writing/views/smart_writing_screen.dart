import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../controller/smart_writing_controller.dart';
import 'package:manifex/Presentation/all_course/smart_writing/views/smart_writing_skill_progress.dart';
import 'package:manifex/Presentation/all_course/smart_writing/views/smart_writing_skill_screen.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_toggle_tabs.dart';
import '../../interactive_reading/widget/interactive_border_color_gradient.dart';
import '../../practices/controller/toggle_tab_controller.dart';

class SmartWritingScreen extends StatelessWidget {
  const SmartWritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ToggleTabController>();
    final controller = Get.find<SmartWritingController>();

    return scaffold_background(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(
              text: 'Smart Writing',
              onTap: () {
                Get.back(result: controller.inProgress.value);
              },
            ),
            SizedBox(height: 18.h),

            InteractiveBorderColor(
                child: GradientToggleTabs()
            ),
            SizedBox(height: 18.h),
            Expanded(
              child: Obx(() {
                return IndexedStack(
                  index: c.selectedIndex.value,
                  children: [
                    SmartWritingSkillScreen(),
                    SmartWritingSkillProgress()
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
