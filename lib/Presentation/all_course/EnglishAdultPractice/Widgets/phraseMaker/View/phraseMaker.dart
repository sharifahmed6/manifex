import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../Share/GradientMask.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../Share/scafold_background.dart';
import '../../../../../Share/text_title_small.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import '../../../../smart_writing/widget/topic_border.dart';
import '../Controller/Controller.dart';

class phraseMaker extends StatelessWidget {
   phraseMaker({super.key});
   final controller = Get.find<phraseMakerController>();

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
                    Icon(Icons.arrow_back, color: Colors.white),
                    Text(
                      "Task 5".tr,
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
                normalText: 'Phrase ',
                gradientText: 'Maker',
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(15),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 0.7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final total = controller.phrases.length;

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

                    Text("Arrange the words in correct order".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 17), fontWeight: FontWeight.w600),),
                    const SizedBox(height: 5),
                    Text("Click each word in sequence to build the phrase.".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 12)),),
                    const SizedBox(height: 10),
                    Text("Available Words:".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 12), fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10),
                    Obx(() => Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: controller.words.map((word) {
                        final isSelected = controller.isSelected(word);

                        return _interestChip(
                          text: word,
                          isSelected: isSelected,
                          onTap: () {
                            controller.toggleWord(word);
                          },
                        );
                      }).toList(),
                    )),

                    const SizedBox(height: 20),
                    Text("Your phrase:".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 12), fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10),
                    // Display selected words
                    Obx(() {
                      if (controller.selectedWords.isEmpty) {
                        return Center(
                          child: Text(
                            "No words selected",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      } else {
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: controller.selectedWords.map((word) {
                            return _interestChip(
                              text: word,
                              isSelected: false,
                              onTap: () => controller.toggleWord(word),
                            );
                          }).toList(),
                        );
                      }
                    }),
                    const SizedBox(height: 20),

                    // Previous / Next Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => controller.previousPhrase(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(15),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 0.7),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                                const SizedBox(width: 5),
                                Text(
                                  "Previous",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenResponsive.responsiveFont(context, 16),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () => controller.nextPhrase(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(15),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 0.7),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenResponsive.responsiveFont(context, 16),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                              ],
                            ),
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),


              GestureDetector(
                onTap: () => controller.submit(),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [AppColors.yellow, AppColors.pink, AppColors.sky],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      Text(
                        "Check with AI".tr,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Image.asset(
                        'assets/icons/ai_icon.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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