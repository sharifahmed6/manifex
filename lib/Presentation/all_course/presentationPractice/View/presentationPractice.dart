import 'package:flutter/material.dart';
import 'package:manifex/App/routes.dart';

import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/progress_card.dart';
import '../../../Share/scafold_background.dart';
import '../../../Share/single_skill_card.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../progress/widget/gradient_linear_progress.dart';
import 'package:get/get.dart';
import '../../ShareProgress/View/ShareProgress.dart';
import '../../practices/widget/skill_welcome_card.dart';
import '../Controller/Controller.dart';

class presentationPractice extends StatelessWidget {
  presentationPractice({super.key});
  final controller = Get.find<presentationPracticeController>();

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
            CustomBackButton(text: 'Presentation Practice'),
            SizedBox(height: 18.h),

            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue, width: 1),
              ),
              child: _GradientToggleTabs(),
            ),
            SizedBox(height: 18.h),
            Expanded(
              child: Obx(() {
                return IndexedStack(
                  index: controller.selectedIndex.value,
                  children: [
                    _skillScreen(),
                    Obx(() {
                      int trueCount = controller.listLock.where((e) => !e).length;

                      return ShareProgress(
                        timer: controller.formattedTime,
                        currentTask: trueCount,
                        totalTask: controller.listLock.length,
                      );
                    }),

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

class _skillScreen extends StatelessWidget {
  _skillScreen({super.key});
  final controller = Get.find<presentationPracticeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkillWelcomeCard(),
            const SizedBox(height: 10),
            GradientTitle(
              fontSize: 20,
              normalText: 'Presentation ',
              gradientText: 'Tasks',
            ),
            Text(
              "Complete each task to improve your presentation skill".tr,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 15),

            SingleSkillCard(
              title: 'Power Words Pulse'.tr,
              subTitle:
                  'Helping children learn powerful words through games, sounds, and playful daily practice.'
                      .tr,
              buttonText: 'Task 1',
              onTap: () {
                Get.toNamed(routes.powerWordsPlus_screen);
              },
              isComplete: controller.listComplete[0],
              lock: controller.listLock[0],
            ),
            const SizedBox(height: 15),

            SingleSkillCard(
              title: 'Precision Drill'.tr,
              subTitle:
                  'Focused practice drills designed to improve accuracy, speed, and skill through repetition.'
                      .tr,
              buttonText: 'Task 2',
              onTap: () {
                Get.toNamed(routes.PrecisionDrill_screen);
              },
              isComplete: controller.listComplete[1],
              lock: controller.listLock[1],
            ),
            const SizedBox(height: 15),

            SingleSkillCard(
              title: 'Context Spin'.tr,
              subTitle:
                  'Engaging exercises that help learners understand context, meaning, and usage effectively.'
                      .tr,
              buttonText: 'Task 3',
              onTap: () {
                Get.toNamed(routes.ContextSpin_screen);
              },
              isComplete: controller.listComplete[2],
              lock: controller.listLock[2],
            ),
            const SizedBox(height: 15),

            SingleSkillCard(
              title: 'Flow Chain'.tr,
              subTitle:
                  'Practice in sequence to strengthen skills, memory, and confident performance flow.'
                      .tr,
              buttonText: 'Task 4',
              onTap: () {
                Get.toNamed(routes.flowChain_screen);
              },
              isComplete: controller.listComplete[3],
              lock: controller.listLock[3],
            ),
          ],
        ),
      ),
    );
  }
}


class _GradientToggleTabs extends StatelessWidget {
  _GradientToggleTabs({super.key});

  final controller = Get.find<presentationPracticeController>();

  @override
  Widget build(BuildContext context) {
    final radius = 14.r;

    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth;

        return Obx(() {
          final selected = controller.selectedIndex.value;

          return Stack(
            children: [
              /// Selected Gradient Pill
              AnimatedAlign(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                alignment: selected == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(6), // spacing from edges
                  child: Container(
                    width: (w - 12) / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        (radius - 4).clamp(0, 100),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFFFBC6F),
                          Color(0xFFF176B7),
                          Color(0xFF3797CD),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: _TabBtn(
                      text: "Practices",
                      isSelected: selected == 0,
                      onTap: () => controller.changeTab(0),
                    ),
                  ),
                  Expanded(
                    child: _TabBtn(
                      text: "Progress",
                      isSelected: selected == 1,
                      onTap: () => controller.changeTab(1),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }
}

class _TabBtn extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabBtn({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
