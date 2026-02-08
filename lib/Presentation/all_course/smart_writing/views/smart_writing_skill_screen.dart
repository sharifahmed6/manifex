import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/all_course/practices/widget/skill_welcome_card.dart';
import 'package:manifex/Presentation/all_course/smart_writing/controller/smart_writing_controller.dart';
import 'package:manifex/Presentation/all_course/smart_writing/widget/topic_border.dart';

import '../../../Share/gradient_title.dart';
import '../widget/custom_progress_indicator.dart';

class SmartWritingSkillScreen extends StatelessWidget {
  SmartWritingSkillScreen({super.key});

  final controller = Get.put(SmartWritingController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkillWelcomeCard(),
          SizedBox(height: screenHeight * 0.02),

          GradientTitle(
            fontSize: 20,
            normalText: 'Choose Your Writing ',
            gradientText: 'Topic',
          ),
          SizedBox(height: screenHeight * 0.01),
          CustomText(
            text: 'Pick a topic that sparks your creativity and imagination',
            color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
          ),
          SizedBox(height: screenHeight * 0.02),

          /// ✅ Categories (items) from API
          Obx(() {
            if (controller.isLoadingItem.value) {
              return Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: const Center(child: CustomCircleProgressIndicator()),
              );
            }

            final selected = controller.selectedValue.value;

            return Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: controller.items.map((t) {
                final isSelected = selected == t;
                return _interestChip(
                  text: t,
                  isSelected: isSelected,
                  onTap: () => controller.select(t), // ✅ topic select + related api
                );
              }).toList(),
            );
          }),

          /// ✅ Related Words (empty হলে hide)
          Obx(() {
            if (controller.isLoadingRelated.value) {
              return Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: const Center(child: CustomCircleProgressIndicator()),
              );
            }

            if (!controller.relatedWord.value ||
                controller.relatedWords.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                GradientTitle(
                  fontSize: 20,
                  normalText: 'Related ',
                  gradientText: 'Words',
                ),
                SizedBox(height: screenHeight * 0.01),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: controller.relatedWords.map((t) {
                    return Container(
                      padding: EdgeInsets.all(16.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      child: CustomText(text: t),
                    );
                  }).toList(),
                ),
              ],
            );
          }),

          SizedBox(height: screenHeight * 0.02),

          CustomText(
            text: 'Your Writing Space',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: screenHeight * 0.01),
          CustomText(
            text:
            'Express your thoughts clearly and creatively. Aim for at least 3-4 sentence',
            fontSize: 16,
            color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
          ),
          SizedBox(height: screenHeight * 0.02),

          /// ✅ Writing OR Result (same GradientScoreRing design)
          Obx(() {
            if (controller.inProgress.value) {
              return Center(
                child: Column(
                  children: [
                    CustomText(
                      text: 'Great Job Sharif',
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    /// ✅ keep your original ring design
                    GradientScoreRing(
                      score: controller.score.value,
                      total: 10,
                      stroke: 14,
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    /// ✅ motivation replace previous text
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Color(0xFFFFBC6F),
                            Color(0xFFF176B7),
                            Color(0xFF3797CD),
                          ],
                        ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        );
                      },
                      child: CustomText(
                        text: controller.motivation.value.isEmpty
                            ? 'Your writing progress is amazing! Keep it up...'
                            : controller.motivation.value,
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 30,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0xff00C06D)),
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xff00C06D),
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                          SizedBox(height: 16.h),
                          CustomText(
                            text:
                            '“Great job Sharif! You finished today’s writing session.',
                            color: const Color(0xff00C06D),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            final hintTopic = controller.selectedValue.value.isEmpty
                ? "Sports"
                : controller.selectedValue.value;

            return TextFormField(
              controller: controller.writingController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText:
                'Write about "$hintTopic" here. Try to describe your thoughts clearly in at least 3-4 sentences...',
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: Colors.white.withAlpha(40)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: Colors.white.withAlpha(40)),
                ),
              ),
            );
          }),

          SizedBox(height: screenHeight * 0.02),

          Obx(() {
            if (controller.inProgress.value) return const SizedBox.shrink();

            final loading = controller.isSubmitting.value;

            return GestureDetector(
              onTap: loading ? null : controller.submitFinalWriting,
              child: Opacity(
                opacity: loading ? 0.7 : 1,
                child: ButtonGradient(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: loading
                            ? 'Checking...'
                            : 'Check My Writing with AI',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 8.w),
                      if (!loading)
                        Image.asset(
                          'assets/icons/ai_icon.png',
                          width: 24.w,
                          height: 24.h,
                        )
                      else
                        SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child:
                          const CircularProgressIndicator(strokeWidth: 2),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),

          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }

  Widget _interestChip({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
    double strokeWidth = 1,
    double? radius,
    EdgeInsetsGeometry? padding,
  }) {
    final r = radius ?? 16.r;

    const fillGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFFFFBC6F), Color(0xFFF176B7), Color(0xFF3797CD)],
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: TopicBorder(
        strokeWidth: strokeWidth,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.ease,
          padding:
          padding ?? EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(r),
            gradient: isSelected ? fillGradient : null,
            color: isSelected
                ? null
                : const Color(0xffFFFFFF).withAlpha((2.56 * 12).toInt()),
          ),
          child: isSelected
              ? CustomText(
            text: text,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          )
              : ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return fillGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              );
            },
            child: CustomText(
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
