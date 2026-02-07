import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/custom_back_button.dart';
import 'package:manifex/Presentation/Share/gradient_title.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import '../../../Share/custom_circle_progress_indicator.dart';
import '../../../progress/widget/achievment_gradient_border.dart';
import '../controller/interactive_reading_controller.dart';
import '../controller/task_one_controller.dart';

class TaskOne extends StatelessWidget {
  TaskOne({super.key});

  final c = Get.find<TaskOneController>();
  final interactiveReading = Get.find<InteractiveReadingController>();
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final tileSize = isLandscape ? 62.w : 85.w;

    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(text: 'Task 1'),
                SizedBox(height: 16.h),
                GradientTitle(
                  normalText: 'Phoneme ',
                  gradientText: 'Flashcards',
                  fontSize: 20,
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text: 'Click the cards to hear the sound',
                  color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                ),
                SizedBox(height: 16.h),

                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 420.w),
                      child: Obx(() {
                        if (c.isLoading.value) {
                          return const Center(child: CustomCircleProgressIndicator());
                        }

                        if (c.error.isNotEmpty) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: c.error.value,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 12.h),
                                GestureDetector(
                                  onTap: c.fetchWord,
                                  child: ButtonGradient(
                                    text: 'Retry',
                                    height: 50,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (c.shuffledLetters.isEmpty || c.selected.isEmpty) {
                          return const Center(child: CustomCircleProgressIndicator());
                        }

                        return Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha((2.56 * 3).toInt()),
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(
                              color: Colors.white.withAlpha((2.56 * 14).toInt()),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ✅ shuffled letters show here
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 30.w,
                                runSpacing: 10.h,
                                children: List.generate(c.shuffledLetters.length, (i) {
                                  final letter = c.shuffledLetters[i];

                                  final gradients = [
                                    const LinearGradient(
                                      colors: [Color(0xffFFD6B7), Color(0xffE07C2F)],
                                    ),
                                    const LinearGradient(
                                      colors: [Color(0xffFFA6C8), Color(0xffB920ED)],
                                    ),
                                    const LinearGradient(
                                      colors: [Color(0xffB2DEFF), Color(0xff3BA3F2)],
                                    ),
                                  ];

                                  return GestureDetector(
                                    onTap: () => c.toggleLetter(i),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 160),
                                      width: tileSize,
                                      height: tileSize,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.r),
                                        gradient: gradients[i % gradients.length],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: letter,
                                            fontWeight: FontWeight.w700,
                                            fontSize: isLandscape ? 24 : 32,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 6.h),
                                          Icon(
                                            Icons.volume_up_rounded,
                                            color: Colors.white,
                                            size: isLandscape ? 18.sp : 24.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),

                              SizedBox(height: 16.h),

                              _selectedPhonemeCard(isLandscape),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _selectedPhonemeCard(bool isLandscape) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((2.56 * 12).toInt()),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          CustomText(
            text: 'Now spell the word:',
            fontSize: isLandscape ? 16 : 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 12.h),

          Container(
            width: isLandscape ? 200.w : 230.w,
            padding: EdgeInsets.all(12.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha((2.56 * 8).toInt()),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withAlpha((2.56 * 30).toInt()),
              ),
            ),
            child: Obx(() => CustomText(
              text: c.typed.value,
              fontSize: isLandscape ? 20 : 25,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )),
          ),

          SizedBox(height: 14.h),

          // ✅ Submit/Reset (before submit)
          Obx(() {
            if (c.isSubmitted.value) return const SizedBox.shrink();

            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: c.canReset ? c.resetSelection : null,
                    child: Opacity(
                      opacity: c.canReset ? 1 : 0.5,
                      child: ButtonGradient(text: 'Reset', height: 50),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: c.canSubmit ? (){
                      c.submit();
                      interactiveReading.t2Done.value = true;
                      interactiveReading.t1SkillLock.value = false;
                    } : null,
                    child: Opacity(
                      opacity: c.canSubmit ? 1 : 0.5,
                      child: ButtonGradient(
                          text: 'Submit',
                          height: 50,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),

          // ✅ After submit -> AchievmentGradientBorder show (tap => back)
          Obx(() {
            if (!c.isSubmitted.value) return const SizedBox.shrink();

            return Column(
              children: [
                SizedBox(height: 14.h),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: AchievmentGradientBorder(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
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
                          text: c.resultLabel.value,
                          fontSize: isLandscape ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
