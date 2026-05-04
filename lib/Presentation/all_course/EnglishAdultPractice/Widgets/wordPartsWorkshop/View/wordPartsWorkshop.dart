import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/TTSService.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/GradientMask.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../Share/record_button.dart';
import '../../../../../Share/scafold_background.dart';
import '../../../../../Share/text_title_small.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import '../Controller/Controller.dart';

class wordPartsWorkshop extends StatelessWidget {
  wordPartsWorkshop({super.key});
  final controller = Get.find<wordPartsWorkshopController>();

  String capitalizeFirstLetter(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  spacing: 5,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white),
                    Text(
                      "Task 4".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenResponsive.responsiveFont(context, 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GradientTitle(
                fontSize: 20,
                normalText: 'Word Parts ',
                gradientText: 'Workshop',
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(15),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 0.7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final wp = controller.wordParts.value;
                      final total = wp?.suffix.length ?? 0;

                      return GradientMask(
                        child: Text(
                          "Word ${controller.currentIndex.value + 1} of $total",
                          style: TextStyle(
                            fontSize: ScreenResponsive.responsiveFont(context, 18),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                    Text(
                      "Combine prefixes, roots, and suffixes to expand vocabulary.".tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 17),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(() {
                      final wp = controller.wordParts.value;
                      if (wp == null) return const CircularProgressIndicator.adaptive();

                      final word = "${wp.prefix[controller.currentIndex.value]}"
                          "${wp.root[controller.currentIndex.value]}"
                          "${wp.suffix[controller.currentIndex.value]}";

                      return Center(
                        child: Text(
                          "\"${capitalizeFirstLetter(word)}\"",
                          style: TextStyle(
                            fontSize: ScreenResponsive.responsiveFont(context, 22),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 5),
                    Obx(() {
                      final wp = controller.wordParts.value;
                      if (wp == null) return const SizedBox.shrink();
                      final word = "${wp.prefix[controller.currentIndex.value]}"
                          "${wp.root[controller.currentIndex.value]}"
                          "${wp.suffix[controller.currentIndex.value]}";
                      return GestureDetector(
                        onTap: () {
                          TTSService.speak(word);
                        },
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.volume_up_sharp,
                              color: AppColors.sky,
                              size: 18,
                            ),
                            Text(
                              "Click to hear pronunciation".tr,
                              style: TextStyle(color: AppColors.sky),
                            )
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 15),
                    Obx(() {
                      final wp = controller.wordParts.value;
                      final index = controller.currentIndex.value;

                      if (wp == null) return const CircularProgressIndicator.adaptive();

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          _buildPartColumn(context, "Prefix", wp.prefix[index], wp.prefixMeaning[index]),
                          _buildPartColumn(context, "Root", wp.root[index], wp.rootMeaning[index]),
                          _buildPartColumn(context, "Suffix", wp.suffix[index], wp.suffixMeaning[index]),
                        ],
                      );
                    }),
                    const SizedBox(height: 20),
                    RecordButton(
                      title: "Say the full word".tr,
                      isRecording: controller.isRecording,
                      audioFile: controller.audioFile,
                      onTap: () {
                        if (controller.isRecording.value) {
                          controller.stopRecording();
                        } else {
                          controller.startRecording();
                        }
                      },
                      recordedText: "Word is recorded".tr,
                      recordDuration: controller.recordDuration,
                      formatDuration: controller.formatDuration,
                    ),
                    const SizedBox(height: 10),
                    _buildFeedbackBanner(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildMercuryButton(context),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPartColumn(BuildContext context, String title, String part, String meaning) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenResponsive.responsiveFont(context, 16))),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: _interestChip(text: part, isSelected: false, onTap: () => TTSService.speak(part)),
          ),
          const SizedBox(height: 10),
          Text("Meaning:", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 14))),
          Text(meaning, style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenResponsive.responsiveFont(context, 14))),
        ],
      ),
    );
  }

  Widget _buildMercuryButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.audioFile.value.isNotEmpty && !controller.showFeedback.value) {
          controller.submit();
        } else if (controller.showFeedback.value) {
          controller.nextWord();
        } else {
          AppSnackbar.show("Please record your pronunciation first");
        }
      },
      child: Obx(() => Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [AppColors.yellow, AppColors.pink, AppColors.sky]),
        ),
        child: controller.showFeedback.value 
            ? Center(child: Text("Next".tr, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Check with Mercy".tr, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/ai_icon.png', width: 24.w),
                ],
              ),
      )),
    );
  }

  Widget _buildFeedbackBanner() {
    return Obx(() {
      if (!controller.showFeedback.value) return const SizedBox.shrink();

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          border: Border.all(width: 1.5, color: controller.isSuccess.value ? AppColors.yellow : Colors.red),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: controller.isSuccess.value ? AppColors.yellow : Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(controller.isSuccess.value ? Icons.check : Icons.close, color: Colors.white, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: controller.feedbackMessage.value,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: controller.isSuccess.value ? AppColors.yellow : Colors.red,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Score: ${controller.score.value}/100",
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _interestChip({required String text, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : Colors.white.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? AppColors.yellow : Colors.grey.withAlpha(50), width: 1.5),
        ),
        child: Center(
          child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
