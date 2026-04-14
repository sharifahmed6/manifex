import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifex/Presentation/all_course/HandwritingPractice/Widgets/AFHandwriting/Controller/Controller.dart';
import '../../../../Core/MusicService.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/scafold_background.dart';
import '../../../Share/single_skill_card.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import '../../ShareProgress/View/ShareProgress.dart';
import '../../ShareProgress/View/Tab.dart';
import '../../interactive_reading/widget/interactive_border_color_gradient.dart';
import 'package:get/get.dart';
import '../../practices/widget/skill_welcome_card.dart';
import '../Controller/Controller.dart';
import '../Widgets/WritingTask/View/WritingTask.dart';

class FreeWriting extends StatelessWidget {
  FreeWriting({super.key});
  final controller = Get.put(FreeWritingController());

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(text: 'Free Writing'),
                Obx(() {
                  final music = MusicService();
                  return IconButton(
                    onPressed: () {
                      music.toggleMusic();
                    },
                    icon: Icon(
                      music.isPlayingRx.value
                          ? Icons.volume_up_sharp
                          : Icons.volume_off,
                      color: Colors.white70,
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 18.h),

            InteractiveBorderColor(
              child: Obx(
                () => GradientToggle(
                  selectedIndex: controller.selectedIndex.value,
                  onTabChanged: (index) {
                    controller.selectedIndex.value = index;
                  },
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Expanded(
              child: Obx(() {
                int falseCount = controller.listLock.where((e) => !e).length;
                return IndexedStack(
                  index: controller.selectedIndex.value,
                  children: [
                    _skillScreen(),
                    ShareProgress(
                      timer: controller.formattedTime,
                      currentTask: falseCount,
                      totalTask: controller.listLock.length,
                    ),
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
  final controller = Get.find<FreeWritingController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkillWelcomeCard(),
            const SizedBox(height: 10),
            GradientTitle(
              fontSize: 20,
              normalText: 'Free ',
              gradientText: 'Writing',
            ),
            Text(
              "Practice writing letters and numbers independently.".tr,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 15),

            SingleSkillCard(
              title: 'Cursive Letters'.tr,
              subTitle: 'Practice writing cursive letters A to z independently.'.tr,
              buttonText: 'Task 1',
              onTap: () {
                Get.to(
                  WritingTask(
                    words: [
                      'A', 'a', 'B', 'b', 'C', 'c', 'D', 'd', 'E', 'e', 'F', 'f', 'G', 'g', 'H', 'h', 'I', 'i', 'J', 'j', 'K', 'k', 'L', 'l', 'M', 'm', 'N', 'n', 'O', 'o', 'P', 'p', 'Q', 'q', 'R', 'r', 'S', 's', 'T', 't', 'U', 'u', 'V', 'v', 'W', 'w', 'X', 'x', 'Y', 'y', 'Z', 'z'
                    ],
                    currentIndex: 0,
                    title: 'Cursive Letters',
                    description: 'Practice writing uppercase and lowercase cursive letters.',
                    taskNumber: 1,
                    isCursive: true,
                  ),
                );
              },
              isComplete: controller.listComplete[0],
              lock: controller.listLock[0],
            ),
            const SizedBox(height: 15),

            SingleSkillCard(
              title: 'Print Letters'.tr,
              subTitle: 'Practice writing print letters A to z independently.'.tr,
              buttonText: 'Task 2',
              onTap: () {
                Get.to(
                  WritingTask(
                    words: [
                      'A', 'a', 'B', 'b', 'C', 'c', 'D', 'd', 'E', 'e', 'F', 'f', 'G', 'g', 'H', 'h', 'I', 'i', 'J', 'j', 'K', 'k', 'L', 'l', 'M', 'm', 'N', 'n', 'O', 'o', 'P', 'p', 'Q', 'q', 'R', 'r', 'S', 's', 'T', 't', 'U', 'u', 'V', 'v', 'W', 'w', 'X', 'x', 'Y', 'y', 'Z', 'z'
                    ],
                    currentIndex: 0,
                    title: 'Print Letters',
                    description: 'Practice writing uppercase and lowercase print letters.',
                    taskNumber: 2,
                    isCursive: false,
                  ),
                );
              },
              isComplete: controller.listComplete[1],
              lock: controller.listLock[1],
            ),
            const SizedBox(height: 15),

            SingleSkillCard(
              title: 'Numbers 0-9'.tr,
              subTitle: 'Practice writing numbers 0 to 9 independently.'.tr,
              buttonText: 'Task 3',
              onTap: () {
                Get.to(
                  WritingTask(
                    words: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
                    currentIndex: 0,
                    title: 'Numbers',
                    description: 'Practice writing numbers 0 to 9 independently.',
                    taskNumber: 3,
                    isCursive: false,
                  ),
                );
              },
              isComplete: controller.listComplete[2],
              lock: controller.listLock[2],
            ),
          ],
        );
      }),
    );
  }
}
