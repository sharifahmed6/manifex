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
                    Icon(Icons.arrow_back, color: Colors.white),
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
                normalText: 'Precision ',
                gradientText: 'Drill',
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
                      final wp = controller.wordParts.value;
                      final total = wp?.suffix.length ?? 0; // safe if null

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

                    Text("Combine prefixes, roots, and suffixes to expand vocabulary.".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 17), fontWeight: FontWeight.w600),),
                    const SizedBox(height: 15),
                    Obx(() {
                      final wp = controller.wordParts.value;
                      if (wp == null) return CircularProgressIndicator.adaptive();

                      final word =
                          "${wp.prefix[controller.currentIndex.value]}"
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

                    const SizedBox(height: 15),

                    Obx(() {
                      final wp = controller.wordParts.value;
                      final index = controller.currentIndex.value;

                      if (wp == null) return CircularProgressIndicator.adaptive();

                      // Safety check to avoid out-of-range errors
                      if (index >= wp.prefix.length ||
                          index >= wp.root.length ||
                          index >= wp.suffix.length) {
                        return Center(child: Text("No data available"));
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          // Prefix Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Prefix",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenResponsive.responsiveFont(context, 16),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  child: _interestChip(
                                    text: wp.prefix[index],
                                    isSelected: false,
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Meaning:",
                                  style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(context, 16)),
                                ),
                                Text(
                                  wp.prefixMeaning[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenResponsive.responsiveFont(context, 16),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Root Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Root",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenResponsive.responsiveFont(context, 16),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  child: _interestChip(
                                    text: wp.root[index],
                                    isSelected: false,
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Meaning:",
                                  style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(context, 16)),
                                ),
                                Text(
                                  wp.rootMeaning[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenResponsive.responsiveFont(context, 16),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Suffix Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Suffix",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenResponsive.responsiveFont(context, 16),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  child: _interestChip(
                                    text: wp.suffix[index],
                                    isSelected: false,
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Meaning:",
                                  style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(context, 16)),
                                ),
                                Text(
                                  wp.suffixMeaning[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenResponsive.responsiveFont(context, 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => controller.previousWord(),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(15),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 0.7),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back, color: Colors.white, size: 18,),
                                const SizedBox(width: 5),
                                Text("Previous", style: TextStyle(color: Colors.white, fontSize: ScreenResponsive.responsiveFont(context, 16), fontWeight: FontWeight.w600),)
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () => controller.nextWord(),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(15),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 0.7),
                            ),
                            child: Row(
                              children: [
                                Text("Next", style: TextStyle(color: Colors.white, fontSize: ScreenResponsive.responsiveFont(context, 16), fontWeight: FontWeight.w600),),
                                const SizedBox(width: 5),
                                Icon(Icons.arrow_forward, color: Colors.white, size: 18,),
                              ],
                            ),
                          ),
                        )
                      ],
                    )


                  ],
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  controller.submit();
                },
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
                        "Completed".tr,
                        style: TextStyle(fontWeight: FontWeight.w600),
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
        padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
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
          textAlign: TextAlign.center,
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
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}