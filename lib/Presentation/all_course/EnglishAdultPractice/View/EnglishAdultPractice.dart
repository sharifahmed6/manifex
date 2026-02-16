import 'package:flutter/material.dart';
import '../../../../App/routes.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/gradient_toggle_tabs.dart';
import '../../../Share/scafold_background.dart';
import '../../../Share/single_skill_card.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../interactive_reading/widget/interactive_border_color_gradient.dart';
import '../../practices/widget/skill_welcome_card.dart';
import '../Controller/Controller.dart';
import 'package:get/get.dart';

class EnglishAdultPractice extends StatelessWidget {
  EnglishAdultPractice({super.key});
  final controller = Get.find<EnglishAdultPracticeController>();


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
            Expanded(
              child: Obx(() {
                return IndexedStack(
                  index: controller.selectedIndex.value,
                  children: [
                    _skillScreen(),
                    _skillScreen(),
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
  final controller = Get.find<EnglishAdultPracticeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkillWelcomeCard(),
          const SizedBox(height: 10,),
          GradientTitle(
            fontSize: 20,
            normalText: 'Adult Language Learning ',
            gradientText: 'Tasks',
          ),
          Text("Complete each task to improve your English.".tr, style: TextStyle(color: Colors.grey),),

          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Auditory Discrimination'.tr,
            subTitle: 'Helping children learn powerful words through games, sounds, and playful daily practice.'.tr,
            buttonText: 'Task 1',
            onTap: (){
              Get.toNamed(routes.auditoryDiscrimination_screen);
            },
            isComplete: controller.listComplete[0],
            lock: controller.listLock[0],
          ),
          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Phoneme-Grapheme Mapping'.tr,
            subTitle: 'Focused practice drills designed to improve accuracy, speed, and skill through repetition.'.tr,
            buttonText: 'Task 2',
            onTap: (){
              Get.toNamed(routes.phonemeGraphemeMapping_screen);
            },
            isComplete: controller.listComplete[1],
            lock: controller.listLock[2],
          ),
          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Word Flash'.tr,
            subTitle: 'Engaging exercises that help learners understand context, meaning, and usage effectively.'.tr,
            buttonText: 'Task 3',
            onTap: (){
              Get.toNamed(routes.wordFlash_screen);
            },
            isComplete: controller.listComplete[2],
            lock: controller.listLock[2],
          ),
          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Word Parts Workshop'.tr,
            subTitle: 'Practice in sequence to strengthen skills, memory, and confident performance flow.'.tr,
            buttonText: 'Task 4',
            onTap: (){
              Get.toNamed(routes.wordPartsWorkshop_screen);
            },
            isComplete: controller.listComplete[3],
            lock: controller.listLock[3],
          ),

          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Phrase Maker'.tr,
            subTitle: 'Practice in sequence to strengthen skills, memory, and confident performance flow.'.tr,
            buttonText: 'Task 5',
            onTap: (){
              Get.toNamed(routes.phraseMaker_screen);
            },
            isComplete: controller.listComplete[3],
            lock: controller.listLock[3],
          ),

          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Sentence Builder'.tr,
            subTitle: 'Practice in sequence to strengthen skills, memory, and confident performance flow.'.tr,
            buttonText: 'Task 6',
            onTap: (){
              Get.toNamed(routes.sentenceBuilder_screen);
            },
            isComplete: controller.listComplete[3],
            lock: controller.listLock[3],
          ),
        ],
      ),
    );
  }
}
