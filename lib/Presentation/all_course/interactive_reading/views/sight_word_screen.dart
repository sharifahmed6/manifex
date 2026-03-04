import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import '../controller/interactive_reading_controller.dart';
import '../controller/sight_word_controller.dart';
import '../../../Share/scafold_background.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/text_title_small.dart';
import '../../../progress/widget/achievment_gradient_border.dart';
import '../../../app_bar/views/custom_app_bar.dart';

class SightWordPracticeScreen extends StatelessWidget {
  SightWordPracticeScreen({super.key});
  final c = Get.put(SightWordController());
  final interactiveReading = Get.find<InteractiveReadingController>();
  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(text: 'Task 2'.tr),
              SizedBox(height: 16.h),
              GradientTitle(
                normalText: 'Sight '.tr,
                gradientText: 'Word Practice'.tr,
                fontSize: 20,
              ),
              SizedBox(height: 16.h),

              Obx(() {
                if (c.isLoading.value) {
                  return const Center(child: CustomCircleProgressIndicator());
                }
                if (c.error.value.isNotEmpty) {
                  return Center(child: Text(c.error.value));
                }
                if (c.items.isEmpty) {
                  return Center(child: Text("No data found".tr));
                }

                final q = c.current;
                final correctI = q.correctIndexSafe();
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((2.56 * 8).toInt()),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withAlpha((2.56 * 16).toInt()),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Sight Word :'.tr, fontSize: 18),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          CustomText(
                            text: q.word,
                            color: Colors.yellow,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () => FlutterTts().speak(q.word),
                            child: Icon(
                              Icons.volume_up_rounded,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      CustomText(text: 'Definition :'.tr, fontSize: 18),
                      SizedBox(height: 8.h),
                      ...q.definition.map((text) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: '•  '),
                              Expanded(child: CustomText(text: text)),
                            ],
                          ),
                        );
                      }).toList(),

                      SizedBox(height: 10.h),
                      CustomText(text: 'Example Sentence :'.tr, fontSize: 18),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: '"${q.sentence}"',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),

                      SizedBox(height: 18.h),
                      CustomText(
                        text: 'Choose the correct sentence:'.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 10.h),

                      Column(
                        children: List.generate(q.quiz.length, (i) {
                          final selected = c.selectedIndex.value == i;
                          final correct = (correctI != -1 && correctI == i);

                          Color borderColor = Colors.white.withAlpha(
                            (2.56 * 16).toInt(),
                          );
                          Color fillColor = Colors.white.withAlpha(
                            (2.56 * 8).toInt(),
                          );

                          if (c.isAnswered.value) {
                            if (correct) {
                              borderColor = Colors.green;
                              fillColor = Colors.green.withAlpha(
                                (2.56 * 40).toInt(),
                              );
                            } else if (selected && !correct) {
                              borderColor = Colors.red;
                              fillColor = Colors.red.withAlpha(
                                (2.56 * 35).toInt(),
                              );
                            }
                          }

                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: GestureDetector(
                              onTap: () => c.selectOption(i),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 14.h,
                                ),
                                decoration: BoxDecoration(
                                  color: fillColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: borderColor,
                                    width: 1.2,
                                  ),
                                ),
                                child: CustomText(
                                  text: q.quiz[i],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      if (c.isAnswered.value) ...[
                        SizedBox(height: 6.h),
                        AchievmentGradientBorder(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  c.selectedIndex.value == correctI
                                      ? Icons.check_circle
                                      : Icons.info,
                                  color: c.selectedIndex.value == correctI
                                      ? Colors.green
                                      : Colors.red,
                                  size: 24.sp,
                                ),
                                SizedBox(width: 8.w),
                                CustomText(
                                  text: c.selectedIndex.value == correctI
                                      ? "Correct! Great job!".tr
                                      : "Incorrect!".tr,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: 14.h),

                      // ✅ Bottom: index/total + progress + next/finish
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: ShaderMask(
                                shaderCallback: (bounds) {
                                  return LinearGradient(
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
                                  text:
                                      "${c.currentIndex.value + 1}" +
                                      " of ".tr +
                                      "${c.total}",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          /*                        CustomText(
                            text: "${c.progressText}/100",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),*/
                          GestureDetector(
                            onTap: () {
                              if (c.isLast) {
                                interactiveReading.t3Done.value = false;
                                interactiveReading.t2SkillLock.value = false;
                                interactiveReading.checkAllComplete();
                              }
                              c.nextOrFinish();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  CustomText(
                                    text: c.isLast ? "Finish".tr : "Next".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6.w),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text:
                              "Correct Answers: ".tr +
                              "${c.correctCount.value}/${c.total}",
                          fontSize: 16,
                        ),
                      ),
                    ],
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
