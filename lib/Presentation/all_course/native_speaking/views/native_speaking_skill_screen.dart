import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/single_skill_card.dart';
import '../../../progress/widget/achievment_gradient_border.dart';
import '../../practices/widget/skill_welcome_card.dart';
import '../controller/native_speaking_skill_controller.dart';

class NativeSpeakingSkillScreen extends StatelessWidget {
  NativeSpeakingSkillScreen({super.key});

  final controller = Get.find<NativeSpeakingSkillController>();

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
              normalText: 'Speaking ',
              gradientText: 'Tasks',
            ),
            CustomText(
              text: 'Complete each task to improve your English speaking skill',
              color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
            ),
            SizedBox(height: 8.h),

            // Task 1 — always unlocked
            SingleSkillCard(
              imagePath: 'assets/icons/pronunctation_icon.png',
              title: 'Pronunciation Practice',
              subTitle: 'Word Level Training',
              buttonText: 'Task 1',
              onTap: () {
                Get.toNamed(routes.nativeOneScreen);
              },
              isComplete: controller.t1Complete.value,
              lock: controller.t1Done.value,
            ),
            SizedBox(height: 16.h),

            // Task 2 — locked until task 1 done
            SingleSkillCard(
              imagePath: 'assets/icons/microphone_icon.png',
              title: 'Phrase Repeat',
              subTitle: 'Follow Mercury\'s Lead',
              buttonText: 'Task 2',
              onTap: () {
                Get.toNamed(routes.nativeTwoScreen);
              },
              isComplete: controller.t2Complete.value,
              lock: controller.t2Done.value,
            ),
            SizedBox(height: 16.h),

            // Task 3 — locked until task 2 done
            SingleSkillCard(
              imagePath: 'assets/icons/listen_&_speak_icon.png',
              title: 'Listen & Speak',
              subTitle: 'Sentence Repetition',
              buttonText: 'Task 3',
              onTap: () {
                Get.toNamed(routes.nativeThreeScreen);
              },
              isComplete: controller.t3Complete.value,
              lock: controller.t3Done.value,
            ),
            SizedBox(height: 16.h),

            // Task 4 — locked until task 3 done
            SingleSkillCard(
              imagePath: 'assets/icons/vocabulary.png',
              title: 'Vocabulary Challenge',
              subTitle: 'Daily Word Practice',
              buttonText: 'Task 4',
              onTap: () {
                Get.toNamed(routes.nativeFourScreen);
              },
              isComplete: controller.t4Complete.value,
              lock: controller.t4Done.value,
            ),
            SizedBox(height: 16.h),

            // Submit button — only when all 4 tasks are done
            controller.allTasksDone.value
                ? GestureDetector(
                    onTap: () {
                      // TODO: add native speaking submit API call
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
