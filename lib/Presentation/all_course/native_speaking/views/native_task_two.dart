import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/all_course/native_speaking/controller/native_task_two_controller.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';

class NativeTaskTwo extends StatelessWidget {
  NativeTaskTwo({super.key});

  final controller = Get.find<NativeTaskTwoController>();

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
            _buildFeedbackBanner(),
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
        CustomBackButton(text: 'Task 2'),
        SizedBox(height: 16.h),
        GradientTitle(
          normalText: 'Phrase ',
          gradientText: 'Repeat',
          fontSize: 20,
        ),
        SizedBox(height: 16.h),
        CustomText(
          text: 'Listen first, then repeat after Mercury',
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
                  // Phrase Display
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(10),
                      border: Border.all(color: Colors.white.withAlpha(127)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            colors: [
                              Color(0xFFFFBC6F),
                              Color(0xFFF176B7),
                              Color(0xFF3797CD),
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          controller.currentWord.value.isEmpty
                              ? 'Loading...'
                              : '"${controller.currentWord.value}"',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 22.h),

                  // Instruction text
                  CustomText(
                    text: 'Listen first, then repeat after Mercury',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 48.h),

                  // Control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Headphone button (play phrase)
                      _buildControlButton(
                        icon: Icons.headphones,
                        onTap: controller.playWordPronunciation,
                        isActive: false,
                      ),

                      SizedBox(width: 32.w),

                      // Microphone button (record)
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

                      // Reset button (next phrase)
                      _buildControlButton(
                        icon: Icons.refresh,
                        onTap: controller.loadNextWord,
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
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFBC6F),
              const Color(0xFFF176B7),
              const Color(0xFF3797CD),
            ],
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

  /// Feedback banner with Fluency Score progress bar
  Widget _buildFeedbackBanner() {
    return Obx(() {
      if (!controller.showFeedback.value) {
        return const SizedBox.shrink();
      }

      final score = controller.fluencyScore.value;
      final percent = (score * 100).round();

      return Column(
        children: [
          // ── Fluency Score card ──────────────────────────────────────
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
                // Label + percentage
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fluency Score',
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
                // Progress bar track
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Stack(
                    children: [
                      // Track background
                      Container(
                        height: 10.h,
                        width: double.infinity,
                        color: Colors.white.withAlpha(30),
                      ),
                      // Filled portion
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

          // ── Feedback message ────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 22.w,
                height: 22.w,
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
                  size: 13.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  controller.feedbackMessage.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: controller.isSuccess.value
                        ? const Color(0xFFFFBC6F)
                        : Colors.red,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // ── Go to Next Challenge button ──────────────────────────────
          GestureDetector(
            onTap: () => Get.back(),
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
                'Go to Next Challenge',
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
