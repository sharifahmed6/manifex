import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../progress/widget/achievment_gradient_border.dart';
import '../controller/sight_word_controller.dart';
import '../model/sight_word_model.dart';

class SightWordPracticeScreen extends StatelessWidget {
  SightWordPracticeScreen({super.key});

  final c = Get.put(SightWordController());

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar()
      ),
        child: Padding(
      padding: const EdgeInsets.all(18),
      child: Obx(() {
        final found = c.foundOccurrences;
        final total = c.totalTargetOccurrences;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(text: 'Task 2'),
            SizedBox(height: 16.h,),
            GradientTitle(
              normalText: 'Sight ',
              gradientText: 'Word Practice',
              fontSize: 20,
            ),
            SizedBox(height: 16.h),
            CustomText(text: 'Click on all the sight words you see. Some words may appear more than once.',color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((2.56 * 8).toInt()),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withAlpha((2.56 * 16).toInt())),
              ),
              child: Column(
                spacing: 20.h,
                children: [
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    alignment: WrapAlignment.center,
                    children: c.words.map((w) {
                      Color bg;
                      if (w.state == WordState.correct) {
                        bg = const Color(0xff00C06D);
                      } else if (w.state == WordState.wrong) {
                        bg = const Color(0xffFF5959);
                      } else {
                        bg = Colors.transparent;
                      }
                      return GestureDetector(
                        onTap: () => c.onTapWord(w),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding:  EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: CustomText(text: w.text,fontSize: 16,fontWeight: FontWeight.w600,textAlign: TextAlign.center,),
                        ),
                      );
                    }).toList(),
                  ),
                  AchievmentGradientBorder(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            colors: [
                              Color(0xffFFBC6F),
                              Color(0xffF176B7),
                              Color(0xff3797CD),
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          );
                        },
                        child: CustomText(
                          text: 'Nice! You found $found of $total sight words!',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    ));
  }
}
