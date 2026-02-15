import 'package:flutter/material.dart';
import 'package:manifex/App/routes.dart';
import '../../../../App/assets_path.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/progress_card.dart';
import '../../../Share/scafold_background.dart';
import '../../../Share/single_skill_card.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../progress/widget/gradient_linear_progress.dart';
import 'package:get/get.dart';
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
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
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
                    _progress()
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkillWelcomeCard(),
          const SizedBox(height: 10,),
          GradientTitle(
            fontSize: 20,
            normalText: 'Presentation ',
            gradientText: 'Tasks',
          ),
          Text("Complete each task to improve your presentation skill".tr, style: TextStyle(color: Colors.grey),),

          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Power Words Pulse'.tr,
            subTitle: 'Helping children learn powerful words through games, sounds, and playful daily practice.'.tr,
            buttonText: 'Task 1',
            onTap: (){
              Get.toNamed(routes.powerWordsPlus_screen);
            },
            isComplete: controller.listComplete[0],
            lock: controller.listLock[0],
          ),
          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Precision Drill'.tr,
            subTitle: 'Focused practice drills designed to improve accuracy, speed, and skill through repetition.'.tr,
            buttonText: 'Task 2',
            onTap: (){
              Get.toNamed(routes.PrecisionDrill_screen);
            },
            isComplete: controller.listComplete[1],
            lock: controller.listLock[2],
          ),
          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Context Spin'.tr,
            subTitle: 'Engaging exercises that help learners understand context, meaning, and usage effectively.'.tr,
            buttonText: 'Task 3',
            onTap: (){
              Get.toNamed(routes.ContextSpin_screen);
            },
            isComplete: controller.listComplete[2],
            lock: controller.listLock[2],
          ),
          const SizedBox(height: 15,),

          SingleSkillCard(
            title: 'Flow Chain'.tr,
            subTitle: 'Practice in sequence to strengthen skills, memory, and confident performance flow.'.tr,
            buttonText: 'Task 4',
            onTap: (){
              Get.toNamed(routes.flowChain_screen);
            },
            isComplete: controller.listComplete[3],
            lock: controller.listLock[3],
          ),
        ],
      ),
    );
  }
}

class _progress extends StatelessWidget {
  const _progress({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SkillWelcomeCard(),
          SizedBox(height: 16.h,),
          ProgressCard(
            color1: Color(0xffFFD6B7),
            color2: Color(0xffE07C2F),
            imagePath: assets_path.fire,
            leftTitle: 'Streak',
            leftSubtitle: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [Color(0xffFFD6B7), Color(0xffE07C2F)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: Text(
                "Keep it up!",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            rightTitle: '6',
            rightSubtitle: 'Days Streak!',
          ),
          SizedBox(height: 10.h),
          // Obx((){
          //   controller.tick.value;
          //   final elapsed = controller.currentTime;
          //   return ProgressCard(
          //     color1: Color(0xffFFA6C8),
          //     color2: Color(0xffB920ED),
          //     imagePath: 'assets/icons/watch_icon.png',
          //     leftTitle: 'Session Timer',
          //     rightTitle: controller.format(elapsed),
          //     rightSubtitle: 'Remaining',
          //   );
          // }),
          SizedBox(height: 10.h),
          ProgressCard(
            color1: Color(0xffB2DEFF),
            color2: Color(0xff3BA3F2),
            imagePath: 'assets/icons/progress.png',
            leftTitle: 'Progress',
            rightTitle: '2/4',
            rightSubtitle: 'Remaining',
            leftSubtitle: GradientLinearProgress(
              value: 0.5,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffB2DEFF),
                  Color(0xff3BA3F2),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          ProgressCard(
            color1: Color(0xff11D067),
            color2: Color(0xff01803A),
            imagePath: 'assets/icons/champion.png',
            leftTitle: 'Today’s Goal',
            rightTitle: '75%',
            rightSubtitle: 'Accuracy',
            leftSubtitle: GradientLinearProgress(
              value: 0.5,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xff11D067),
                  Color(0xff01803A),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
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