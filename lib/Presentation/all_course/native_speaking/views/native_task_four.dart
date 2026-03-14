import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/all_course/native_speaking/controller/native_speaking_skill_controller.dart';
import 'package:manifex/Presentation/all_course/native_speaking/controller/native_task_four_controller.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';

class NativeTaskFour extends StatelessWidget {
  NativeTaskFour({super.key});

  final controller = Get.find<NativeTaskFourController>();

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
            _buildWordsTargetSection(),
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
        CustomBackButton(text: 'Task 4'.tr),
        SizedBox(height: 16.h),
        GradientTitle(
          normalText: 'Vocabulary '.tr,
          gradientText: 'Challenge'.tr,
          fontSize: 20,
        ),
        SizedBox(height: 8.h),
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
            // Instruction
            Text(
              'Read each word aloud'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),

            // 2x2 Word Cards Grid
            _buildWordGrid(),

            SizedBox(height: 20.h),

            // Bottom controls row: main mic + reset
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gradient mic button — listens and matches against all 4 words
                Obx(
                  () => _buildControlButtonGradient(
                    icon: controller.isListening.value
                        ? Icons.mic
                        : Icons.mic_off,
                    onTap: controller.toggleListeningAll,
                  ),
                ),
                SizedBox(width: 32.w),
                // Reset / Shuffle button
                _buildControlButton(
                  icon: Icons.refresh_rounded,
                  onTap: controller.shuffleWords,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  /// 2x2 grid of word cards
  Widget _buildWordGrid() {
    return Obx(() {
      final words = controller.displayedWords;
      if (words.isEmpty) {
        return SizedBox(
          height: 140.h,
          child: Center(
            child: Text(
              'No words loaded'.tr,
              style: TextStyle(color: Colors.white54),
            ),
          ),
        );
      }

      // Build 2 rows of 2
      final rows = <Widget>[];
      for (int row = 0; row < 2; row++) {
        final cols = <Widget>[];
        for (int col = 0; col < 2; col++) {
          final idx = row * 2 + col;
          if (idx < words.length) {
            cols.add(Expanded(child: _buildWordCard(idx, words[idx])));
            if (col == 0) cols.add(SizedBox(width: 12.w));
          }
        }
        rows.add(Row(children: cols));
        if (row == 0) rows.add(SizedBox(height: 12.h));
      }

      return Column(children: rows);
    });
  }

  /// Single word card — tap plays TTS for that word
  Widget _buildWordCard(int index, String word) {
    return Obx(() {
      final checkState = controller.wordCheckState[index];
      final isChecked = checkState == true;

      return GestureDetector(
        onTap: () => controller.playWord(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 90.h,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(isChecked ? 25 : 15),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isChecked
                  ? const Color(0xFF35EDE5)
                  : Colors.white.withAlpha(80),
              width: isChecked ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Word text
              Text(
                word,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              // Always show mic icon, replace with check when matched
              isChecked
                  ? ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF35EDE5), Color(0xFF3797CD)],
                      ).createShader(bounds),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    )
                  : Icon(
                      controller.currentlySpeakingIndex.value == index
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white.withAlpha(150),
                      size: 20.sp,
                    ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
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

  /// Words Target progress bar section (+ Finish button when all done)
  Widget _buildWordsTargetSection() {
    return Obx(() {
      final score = controller.wordsTarget.value;
      final max = controller.maxTarget;
      final fraction = score / max;
      final allDone = (score >= max);

      return Column(
        children: [
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
                      'Words target'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      '$score/$max',
                      style: TextStyle(
                        fontSize: 14.sp,
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
                            width: constraints.maxWidth * fraction,
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

          // "Complete Task 4" button — appears when all 4 words matched
          if (allDone) ...[
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                try {
                  final skillCtrl = Get.find<NativeSpeakingSkillController>();
                  skillCtrl.t4Complete.value = false; // hide task 4 button/logo
                  skillCtrl.t4Done.value = false; // mark task 4 as done
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
                  'Complete Task 4'.tr,
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
        ],
      );
    });
  }
}
