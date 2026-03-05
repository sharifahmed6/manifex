import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      if (music.isPlaying) {
                        music.stop();
                      } else {
                        music.play();
                      }
                    },
                    icon: Icon(
                      music.isPlaying
                          ? Icons.volume_off
                          : Icons.volume_up_sharp,
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
        final age = controller.userAgeGroup.value;

        if (age == '14-17' || age == '18-40') {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                "Free Writing is not available for your age category. Please use Smart Writing.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          );
        }

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
              "Express your thoughts and improve your writing.".tr,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 15),

            if (age == '6-9') ...[
              SingleSkillCard(
                title: 'Letters'.tr,
                subTitle:
                    'Practice writing uppercase and lowercase letters.'.tr,
                buttonText: 'Task 1',
                onTap: () {
                  Get.to(
                    WritingTask(
                      words: [' '],
                      currentIndex: 0,
                      title: 'Letters',
                      description:
                          'Practice writing uppercase and lowercase letters.',
                      taskNumber: 1,
                    ),
                  );
                },
                isComplete: controller.listComplete.isNotEmpty
                    ? controller.listComplete[0]
                    : false,
                lock: controller.listLock.isNotEmpty
                    ? controller.listLock[0]
                    : false,
              ),
              const SizedBox(height: 15),
              SingleSkillCard(
                title: 'Words'.tr,
                subTitle: 'Practice writing short words.'.tr,
                buttonText: 'Task 2',
                onTap: () {
                  Get.to(
                    WritingTask(
                      words: controller.getRandomWords(controller.allWords),
                      currentIndex: 0,
                      title: 'Words',
                      description: 'Practice writing short words.',
                      taskNumber: 2,
                    ),
                  );
                },
                isComplete: controller.listComplete.length > 1
                    ? controller.listComplete[1]
                    : false,
                lock: controller.listLock.length > 1
                    ? controller.listLock[1]
                    : false,
              ),
            ] else ...[
              SingleSkillCard(
                title: 'Write Independently'.tr,
                subTitle: 'Write independently letters and short words.'.tr,
                buttonText: 'Task 1',
                onTap: () {
                  Get.to(
                    WritingTask(
                      words: [' '],
                      currentIndex: 0,
                      title: 'Write Letters & Words',
                      description: 'Write independently letters and short words.',
                      taskNumber: 1,
                      isCursive: false,
                    ),
                  );
                },
                isComplete: controller.listComplete.isNotEmpty
                    ? controller.listComplete[0]
                    : false,
                lock: controller.listLock.isNotEmpty
                    ? controller.listLock[0]
                    : false,
              ),
              const SizedBox(height: 15),
              SingleSkillCard(
                title: 'Cursive Letters'.tr,
                subTitle: 'Practice writing cursive letters.'.tr,
                buttonText: 'Task 2',
                onTap: () {
                  Get.to(
                    WritingTask(
                      words: controller.getRandomWords(controller.allWords),
                      currentIndex: 0,
                      title: 'Cursive Words',
                      description:
                      'Practice writing complete words in cursive.',
                      taskNumber: 2,
                      isCursive: true,
                    ),
                  );
                },
                isComplete: controller.listComplete.length > 1
                    ? controller.listComplete[1]
                    : false,
                lock: controller.listLock.length > 1
                    ? controller.listLock[1]
                    : false,
              ),
            ],
          ],
        );
      }),
    );
  }
}
