import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Presentation/Features/home/controller/home_controller.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/single_skill_card.dart';
import '../../../progress/widget/achievment_gradient_border.dart';
import '../../practices/widget/skill_welcome_card.dart';
import '../controller/interactive_reading_controller.dart';

class SkillScreen extends StatelessWidget {
  SkillScreen({super.key});
  final controller = Get.find<InteractiveReadingController>();
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkillWelcomeCard(),
            SizedBox(height: 12.h),
            GradientTitle(
              fontSize: 20,
              normalText: 'Reading ',
              gradientText: 'Tasks',
            ),
            CustomText(
              text: 'Complete each task to improve your English reading skill',
              color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
            ),
            SizedBox(height: 8.h),
            SingleSkillCard(
              imagePath: 'assets/icons/phoneme_icon.png',
              title: 'Phoneme Flashcards',
              subTitle: 'Click the cards to hear the sound',
              buttonText: 'Task 1',
              onTap: () {
                controller.currentTask.value = 1;
                Get.toNamed(routes.interactive_reading_task1);
                print('Phoneme Flash cards');
              },
              isComplete: controller.t1SkillLock.value,
              lock: controller.t1Done.value,
            ),
            SizedBox(height: 16.h),
            SingleSkillCard(
              imagePath: 'assets/icons/sight_words.png',
              title: 'Sight Word Practice',
              subTitle:
                  'Click on all the sight words you see. Some words may appear more than once.',
              buttonText: 'Task 2',
              onTap: () {
                controller.currentTask.value = 2;
                Get.toNamed(routes.sight_word_scrren);
                print('Sight Word Practice');
              },
              isComplete: controller.t2SkillLock.value,
              lock: controller.t2Done.value,
            ),
            SizedBox(height: 16.h),
            SingleSkillCard(
              imagePath: 'assets/icons/phoneme_icon.png',
              title: 'Phoneme Flashcards',
              subTitle: 'Drag words to their matching pictures',
              buttonText: 'Task 3',
              onTap: () {
                controller.currentTask.value = 3;
                Get.toNamed(routes.interactive_task3_screen);
                print('Phoneme Flashcards');
              },
              isComplete: controller.t3SkillLock.value,
              lock: controller.t3Done.value,
            ),
            SizedBox(height: 16.h),
            SingleSkillCard(
              imagePath: 'assets/icons/reading_comprehension_icon.png',
              title: 'Reading Comprehension',
              subTitle: 'Read the passage and answer the questions',
              buttonText: 'Task 4',
              onTap: () {
                controller.currentTask.value = 4;
                print('Reading Comprehension');
                Get.toNamed(routes.interactive_task4_screen);
              },
              isComplete: controller.t4SkillLock.value,
              lock: controller.t4Done.value,
            ),
            SizedBox(height: 16.h),
            controller.allAnswerSubmit.value
                ? GestureDetector(
                    onTap: () async {
                    await  controller.interactiveReadingAnsSubmit();
                      homeController.fetchProfileInfo();
                    },
                    child: AchievmentGradientBorder(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [
                                Color(0xffFFBC6F),
                                Color(0xffF176B7),
                                Color(0xff3797CD),
                              ],
                            ).createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            );
                          },
                          child: CustomText(
                            text: 'Submit All Answers',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        );
      }),
    );
  }
}
