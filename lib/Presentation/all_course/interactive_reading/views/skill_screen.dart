import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/single_skill_card.dart';
import '../../practices/widget/skill_welcome_card.dart';

class SkillScreen extends StatelessWidget {
  const SkillScreen({super.key});

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
          SizedBox(height: 8.h,),
          SingleSkillCard(
            imagePath: 'assets/icons/phoneme_icon.png',
            title: 'Phoneme Flashcards',
            subTitle: 'Click the cards to hear the sound',
            buttonText: 'Task 1',
            onTap: (){
              print('Phoneme Flash cards');
            },
            isComplete: true,
          ),
          SizedBox(height: 16.h,),
          SingleSkillCard(
            imagePath: 'assets/icons/sight_words.png',
            title: 'Sight Word Practice',
            subTitle: 'Click on all the sight words you see. Some words may appear more than once.',
            buttonText: 'Task 2',
            onTap: (){
              print('Sight Word Practice');
            },
            isComplete: true,
          ),
          SizedBox(height: 16.h,),
          SingleSkillCard(
            imagePath: 'assets/icons/phoneme_icon.png',
            title: 'Phoneme Flashcards',
            subTitle: 'Drag words to their matching pictures',
            buttonText: 'Task 3',
            onTap: (){
              print('Phoneme Flashcards');
            },
            isComplete: true,
          ),
          SizedBox(height: 16.h,),
          SingleSkillCard(
            imagePath: 'assets/icons/reading_comprehension_icon.png',
            title: 'Reading Comprehension',
            subTitle: 'Read the passage and answer the questions',
            buttonText: 'Task 4',
            onTap: (){
              print('Reading Comprehension');
            },
            isComplete: true,
          ),
          SizedBox(height: 16.h,),
        ],
      ),
    );
  }
}
