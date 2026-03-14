import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import 'package:manifex/Presentation/language/controller/language_controller.dart';

import '../../Share/text_title_small.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});
  final c = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8.w,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
                CustomText(
                  text: 'Language',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _gradientTitle(
              normalText: 'Please select ',
              gradientText: 'your language',
            ),
            Expanded(
              child: ListView.separated(
                itemCount: c.languages.length,
                itemBuilder: (context, index) {
                  final item = c.languages[index];
                  final isSelected = c.selectedIndex.value == index;
                  return GestureDetector(
                    onTap: () => c.selectLanguage(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withAlpha((2.56 * 12).toInt())
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.white.withAlpha((2.56 * 22).toInt())
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(item.flag, width: 32.w, height: 32.h),
                          SizedBox(width: 12),
                          CustomText(
                            text: item.title,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(text: "(${item.country})", fontSize: 14),
                          Spacer(),
                          if (isSelected)
                            const Icon(Icons.check, color: Colors.white)
                          else
                            const SizedBox(width: 24),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16.h);
                },
              ),
            ),
            ButtonGradient(text: 'Next'),
          ],
        ),
      ),
    );
  }

  Widget _gradientTitle({String? normalText, String? gradientText}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
        children: [
          TextSpan(
            text: normalText ?? '',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xffFFFFFF),
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFFFBC6F), // pink
                    Color(0xFFF176B7), // orange
                    Color(0xFF3797CD), // blue
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: Text(
                gradientText ?? '',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
