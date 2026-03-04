 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/custom_back_button.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/all_course/native_speaking/views/native_speaking_skill_progress.dart';
import 'package:manifex/Presentation/all_course/interactive_reading/widget/interactive_border_color_gradient.dart';
import 'package:manifex/Presentation/all_course/practices/controller/toggle_tab_controller.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import '../../../Share/gradient_toggle_tabs.dart';
import 'native_speaking_skill_screen.dart';

class NativeSpeakingScreen extends StatelessWidget {
  const NativeSpeakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ToggleTabController>();

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
            CustomBackButton(text: 'Native Speaking'),
            SizedBox(height: 18.h),

            InteractiveBorderColor(child: GradientToggleTabs()),
            SizedBox(height: 18.h),
            Expanded(
              child: Obx(() {
                return IndexedStack(
                  index: c.selectedIndex.value,
                  children: [
                    NativeSpeakingSkillScreen(),
                    NativeSpeakingSkillProgress(),
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
