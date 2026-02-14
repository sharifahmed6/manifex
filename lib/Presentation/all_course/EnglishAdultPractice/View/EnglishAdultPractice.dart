import 'package:flutter/material.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_toggle_tabs.dart';
import '../../../Share/scafold_background.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../interactive_reading/widget/interactive_border_color_gradient.dart';

class EnglishAdultPractice extends StatelessWidget {
  const EnglishAdultPractice({super.key});

  @override
  Widget build(BuildContext context) {
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
            CustomBackButton(text: 'English for Adult Practice'),
            SizedBox(height: 18.h),

            InteractiveBorderColor(
                child: GradientToggleTabs()
            ),
            SizedBox(height: 18.h),
            // Expanded(
            //   child: Obx(() {
            //     return IndexedStack(
            //       index: c.selectedIndex.value,
            //       children: [
            //         SkillScreen(),
            //         SkillProgressScreen()
            //       ],
            //     );
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
