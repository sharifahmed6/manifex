import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/achivenents_card.dart';

class AchivementScreen extends StatelessWidget {
  const AchivementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AchivenentsCard(
          lock: true,
          imagePath: 'assets/icons/daily_streak.png',
          title: 'Word Wizard',
          subTitle: 'Learned 100 new words with perfect recall.',
        ),
        SizedBox(height: 16.h),
        AchivenentsCard(
          lock: true,
          imagePath: 'assets/icons/achievment_write_icon.png',
          title: 'Sentence Starter',
          subTitle: 'Wrote your first 3-line story successfully.',
        ),
        SizedBox(height: 16.h),
        AchivenentsCard(
          lock: true,
          imagePath: 'assets/icons/achievment_speaking_icon.png',
          title: 'Speaking Star',
          subTitle: 'Learned 100 new words with perfect recall.',
        ),
        SizedBox(height: 16.h),
        AchivenentsCard(
          lock: true,
          imagePath: 'assets/icons/achievment_word_wizard_icon.png',
          title: 'Word Wizard',
          subTitle: 'Learned 100 new words with perfect recall.',
        ),
        SizedBox(height: 16.h),
        AchivenentsCard(
          lock: false,
          imagePath: 'assets/icons/achievment_quick_learner.png',
          title: 'Quick Learner',
          subTitle: 'Finished all daily tasks in under 10 minutes.',
        ),
        SizedBox(height: 16.h),
        AchivenentsCard(
          lock: false,
          imagePath: 'assets/icons/achievment_phonics_icon.png',
          title: 'Phonics Pro',
          subTitle: 'Complete 50 phoneme flashcards.',
        ),
        SizedBox(height: 16.h),
        AchivenentsCard(
          lock: false,
          imagePath: 'assets/icons/avhievment_comprehension_icon.png',
          title: 'Comprehension Champ',
          subTitle: 'Answered 10 story questions correctly in a row.',
        ),
        SizedBox(height: 16.h),
        AchivenentsCard(
          lock: false,
          imagePath: 'assets/icons/avheivement_reward_icon.png',
          title: 'Reward Hunter',
          subTitle: 'Unlocked 20 reward videos.',
        ),
        SizedBox(height: 16.h),
        AchivenentsCard(
          lock: false,
          imagePath: 'assets/icons/acheivement_milestone_icon.png',
          title: 'Milestone Master',
          subTitle: 'Unlocked 5 achievements in one month.',
        ),
      ],
    );
  }
}
