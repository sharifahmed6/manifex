import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/all_course/native_speaking/controller/native_speaking_skill_controller.dart';
import 'package:manifex/Presentation/all_course/native_speaking/controller/native_task_three_controller.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';

class NativeTaskThree extends StatelessWidget {
  NativeTaskThree({super.key});

  final controller = Get.find<NativeTaskThreeController>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            _buildTitleSection(),
            SizedBox(height: 20.h),
            _buildPracticeCard(),
            SizedBox(height: 20.h),
            _buildFeedbackSection(),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBackButton(text: 'Task 3'.tr),
        SizedBox(height: 16.h),
        GradientTitle(
          normalText: 'Listen & '.tr,
          gradientText: 'Speak'.tr,
          fontSize: 20,
        ),
        SizedBox(height: 16.h),
        CustomText(
          text: 'Word Level Training'.tr,
          color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  /// Main practice card
  Widget _buildPracticeCard() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Container(
          padding: EdgeInsets.all(48.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                const Color(0xFF111217),
                const Color(0xFFCFDBFF).withAlpha(100),
              ],
            ),
            border: Border.all(color: Colors.white.withAlpha(76)),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: const Center(child: CustomCircleProgressIndicator()),
        );
      }

      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((2.56 * 5).toInt()),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: Colors.white.withAlpha((2.56 * 14).toInt()),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(10),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  // ── Sentence box with Listen + Slow buttons inside ──
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(10),
                      border: Border.all(color: Colors.white.withAlpha(127)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        // Sentence text
                        Text(
                          controller.currentSentence.value.isEmpty
                              ? 'Loading...'.tr
                              : controller.currentSentence.value,
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 14.h),

                        // Listen + Slow buttons — inside the border box
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTextButton(
                              label: 'Listen'.tr,
                              icon: Icons.volume_up_rounded,
                              onTap: controller.playSentence,
                            ),
                            SizedBox(width: 10.w),
                            _buildTextButton(
                              label: 'Slow'.tr,
                              icon: null,
                              onTap: controller.playSentenceSlow,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 22.h),

                  // Instruction text
                  CustomText(
                    text: 'Now repeat the sentence'.tr,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32.h),

                  // Control buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Headphone button
                      _buildControlButton(
                        icon: Icons.headphones,
                        onTap: controller.playSentence,
                        isActive: false,
                      ),

                      SizedBox(width: 32.w),

                      // Microphone button
                      Obx(
                        () => _buildControlButtonGradient(
                          icon: controller.isListening.value
                              ? Icons.mic
                              : Icons.mic_off,
                          onTap: controller.toggleListening,
                          isActive: controller.isListening.value,
                        ),
                      ),

                      SizedBox(width: 32.w),

                      // Refresh button
                      _buildControlButton(
                        icon: Icons.refresh,
                        onTap: controller.loadNextSentence,
                        isActive: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  /// Plain text button (Listen / Slow)
  Widget _buildTextButton({
    required String label,
    required IconData? icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          border: Border.all(color: Colors.white.withAlpha(60)),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 16.sp),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72.w,
        height: 72.w,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(30),
          border: Border.all(color: Colors.white.withAlpha(50)),
          borderRadius: BorderRadius.circular(9999.r),
        ),
        child: Icon(icon, color: Colors.white, size: 32.sp),
      ),
    );
  }

  Widget _buildControlButtonGradient({
    required IconData icon,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72.w,
        height: 72.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFBC6F), Color(0xFFF176B7), Color(0xFF3797CD)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: Border.all(color: Colors.white.withAlpha(50)),
          borderRadius: BorderRadius.circular(9999.r),
        ),
        child: Icon(icon, color: Colors.white, size: 32.sp),
      ),
    );
  }

  /// Feedback section — same as native_task_one + Fluency Score progress bar
  Widget _buildFeedbackSection() {
    return Obx(() {
      if (!controller.showFeedback.value) {
        return const SizedBox.shrink();
      }

      final score = controller.fluencyScore.value;
      final percent = (score * 100).round();

      return Column(
        children: [
          // ── Fluency Score progress bar card ─────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1C24),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fluency Score'.tr,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$percent%',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Stack(
                    children: [
                      Container(
                        height: 10.h,
                        width: double.infinity,
                        color: Colors.white.withAlpha(30),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            height: 10.h,
                            width: constraints.maxWidth * score,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFBC6F),
                                  Color(0xFFF176B7),
                                  Color(0xFF3797CD),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // ── Feedback card — same as native_task_one ─────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              border: Border.all(
                width: 2,
                color: controller.isSuccess.value
                    ? const Color(0xFFFFBC6F)
                    : Colors.red,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tick / Cross circle
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        gradient: controller.isSuccess.value
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFFFFBC6F),
                                  Color(0xFFF176B7),
                                  Color(0xFF3797CD),
                                ],
                              )
                            : null,
                        color: controller.isSuccess.value ? null : Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.isSuccess.value ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Feedback message
                          CustomText(
                            text: controller.feedbackMessage.value,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: controller.isSuccess.value
                                ? const Color(0xFFFFBC6F)
                                : Colors.red,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4.h),
                          // Score display — e.g. 85/100 or 00/100
                          Text(
                            controller.isSuccess.value
                                ? '$percent/100'
                                : '00/100',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: controller.isSuccess.value
                                  ? const Color(0xFFFFBC6F)
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // ── "Perfect! Go to Next Challenge" button ───────────────
          GestureDetector(
            onTap: () {
              try {
                final skillCtrl = Get.find<NativeSpeakingSkillController>();
                skillCtrl.t3Complete.value = false; // hide task 3 button/logo
                skillCtrl.t4Done.value = false;
                skillCtrl.checkAllComplete();
              } catch (_) {}
              Get.back();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFBC6F),
                    Color(0xFFF176B7),
                    Color(0xFF3797CD),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                controller.isSuccess.value
                    ? 'Perfect! Go to Next Challenge'.tr
                    : 'Go to Next Challenge'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
