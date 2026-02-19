import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/all_course/interactive_reading/controller/interactive_reading_controller.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/text_title_small.dart';
import '../../practices/widget/transperent_gradient_border.dart';
import '../controller/task_four_controller.dart';
import '../widget/gradient_radio_option.dart';

class InteractiveTaskFourScreen extends StatelessWidget {
  InteractiveTaskFourScreen({super.key});

  final controller = Get.find<TaskFourController>();
  final interactiveController = Get.find<InteractiveReadingController>();
  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(text: 'Task 4'),
              SizedBox(height: 16.h),
              GradientTitle(
                normalText: 'Reading ',
                gradientText: 'Quiz',
                fontSize: 20,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: 'Read the story and answer the questions',
                color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
              SizedBox(height: 16.h),

              /// ✅ FULL UI (All questions at once + Next -> score -> Finish)
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CustomCircleProgressIndicator());
                }
                if (controller.error.value.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Column(
                          children: [
                            Text(
                              controller.error.value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withAlpha(220),
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            GestureDetector(
                              onTap: () => controller.load(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  "Retry",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                final d = controller.data.value;
                if (d == null) {
                  return const Center(child: Text("No data"));
                }

                final questions = d.questions;

                return TransparentGradientBorder(
                  strokeWidth: 0.5,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff111217).withAlpha(30),
                          const Color(0xffCFDBFF).withAlpha(20),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        _StoryCard(
                          title: d.passageName,
                          storyText: d.text,
                          imagePath: d.image,
                        ),
                        SizedBox(height: 14.h),

                        /// ✅ All questions visible at once
                        ...List.generate(questions.length, (qIndex) {
                          final q = questions[qIndex];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Obx(() {
                              final selected =
                                  controller.selectedAnswers[qIndex];

                              return _QuestionCard(
                                questionNo: (qIndex + 1).toString(),
                                question: q.question,
                                options: q.options,
                                selectedIndex: selected,
                                enabled: !controller.isSubmitted.value,
                                onSelect: (optIndex) =>
                                    controller.selectOption(qIndex, optIndex),
                              );
                            }),
                          );
                        }),

                        SizedBox(height: 14.h),

                        /// ✅ Bottom row: progress + Next/Finish
                        Obx(() {
                          final total = controller.total;
                          final selectedCount =
                              controller.selectedAnswers.length;

                          final canNext = controller.allAnswered;
                          final showScore = controller.isSubmitted.value;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (showScore)
                                Expanded(
                                  child: Center(
                                    child: ShaderMask(
                                      shaderCallback: (bounds) {
                                        return const LinearGradient(
                                          colors: [
                                            Color(0xffFFBC6F),
                                            Color(0xffF176B7),
                                            Color(0xff3797CD),
                                          ],
                                        ).createShader(
                                          Rect.fromLTWH(
                                            0,
                                            0,
                                            bounds.width,
                                            bounds.height,
                                          ),
                                        );
                                      },
                                      child: CustomText(
                                        text: controller.scoreText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Expanded(
                                  child: Center(
                                    child: CustomText(
                                      text: "$selectedCount/$total selected",
                                      fontSize: 18,
                                      color: Colors.white.withAlpha(
                                        (2.56 * 85).toInt(),
                                      ),
                                    ),
                                  ),
                                ),
                              GestureDetector(
                                onTap: controller.isSubmitted.value
                                    ? () {
                                        interactiveController.t4Done.value =
                                            false;
                                        interactiveController
                                                .t4SkillLock
                                                .value =
                                            false;
                                        interactiveController
                                            .checkAllComplete();
                                        interactiveController.stop();
                                        Get.back();
                                      }
                                    : (canNext ? controller.submitNext : null),
                                child: Opacity(
                                  opacity:
                                      (controller.isSubmitted.value || canNext)
                                      ? 1
                                      : 0.5,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 12.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    child: CustomText(
                                      text: controller.isSubmitted.value
                                          ? "Finish"
                                          : "Next",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.title,
    required this.storyText,
    required this.imagePath,
  });

  final String title;
  final String storyText;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xffFFFFFF).withAlpha((2.56 * 8).toInt()),
        border: Border.all(
          color: const Color(0xffFFFFFF).withAlpha((2.56 * 14).toInt()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Color(0xffFFBC6F),
                  Color(0xffF176B7),
                  Color(0xff3797CD),
                ],
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
            },
            child: Center(
              child: CustomText(
                text: title,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          CustomText(
            text: storyText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(imagePath, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.questionNo,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.onSelect,
    required this.enabled,
  });

  final String questionNo;
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final void Function(int optionIndex) onSelect;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xffFFFFFF).withAlpha((2.56 * 8).toInt()),
        border: Border.all(
          color: const Color(0xffFFFFFF).withAlpha((2.56 * 14).toInt()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Question $questionNo",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xffFFFFFF).withAlpha((2.56 * 95).toInt()),
          ),
          SizedBox(height: 10.h),
          // Question text — wraps naturally, no overflow
          Text(
            question,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
            ),
            softWrap: true,
          ),
          SizedBox(height: 12.h),
          ...List.generate(options.length, (i) {
            final isSelected = selectedIndex == i;

            return IgnorePointer(
              ignoring: !enabled,
              child: Opacity(
                opacity: enabled ? 1 : 0.6,
                child: GradientRadioOption(
                  text: options[i],
                  isSelected: isSelected,
                  onTap: () => onSelect(i),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
