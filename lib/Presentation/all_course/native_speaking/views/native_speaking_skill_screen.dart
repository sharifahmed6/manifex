import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/single_skill_card.dart';
import '../../practices/widget/skill_welcome_card.dart';

class NativeSpeakingSkillScreen extends StatelessWidget {
  const NativeSpeakingSkillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            imagePath: 'assets/icons/pronunctation_icon.png',
            title: 'Pronunciation Practice',
            subTitle: 'Word Level Training',
            buttonText: 'Task 1',
            onTap: () {
              Get.toNamed(routes.nativeOneScreen);
            },
            isComplete: true,
          ),
          SizedBox(height: 16.h),
          SingleSkillCard(
            imagePath: 'assets/icons/microphone_icon.png',
            title: 'Phrase Repeat',
            subTitle: 'Follow Mercury\'s Lead',
            buttonText: 'Task 2',
            onTap: () {
              Get.toNamed(routes.nativeTwoScreen);
            },
            isComplete: true,
          ),
          SizedBox(height: 16.h),
          SingleSkillCard(
            imagePath: 'assets/icons/listen_&_speak_icon.png',
            title: 'Listen & Speak',
            subTitle: 'Sentence Repetition',
            buttonText: 'Task 3',
            onTap: () {
              Get.toNamed(routes.nativeThreeScreen);
            },
            isComplete: true,
          ),
          SizedBox(height: 16.h),
          SingleSkillCard(
            imagePath: 'assets/icons/vocabulary.png',
            title: 'Vocabulary Challenge',
            subTitle: 'Daily Word Practice',
            buttonText: 'Task 4',
            onTap: () {
              print('Vocabulary Challenge');
            },
            isComplete: true,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
