import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Share/text_title_small.dart';
import '../../practices/widget/transperent_gradient_border.dart';
import '../controllers/progress_controller.dart';
import 'gradient_linear_progress.dart';

class LearningProgressCard extends StatelessWidget {
   LearningProgressCard({super.key});
  final controller = Get.find<ProgressController>();
  @override
  Widget build(BuildContext context) {
    return TransparentGradientBorder(
      strokeWidth: 0.5,
      radius: 16.r,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: [
              const Color(0xff111217).withAlpha(50),
              const Color(0xffCFDBFF).withAlpha(30),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: 'Learning Progress',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                Obx(
                      () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffFFBC6F),
                          Color(0xffF176B7),
                          Color(0xff3797CD),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedDay.value,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                        dropdownColor: const Color(0xFF1E2030),
                        borderRadius: BorderRadius.circular(12.r),

                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                        items: controller.progressDays.map((level) {
                          return DropdownMenuItem<String>(
                            value: level,
                            child: CustomText(
                              text: level,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),

                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedDay.value = value;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Reading Comprehension'),
                CustomText(text: '50%')
              ],
            ),
            SizedBox(height: 8.h,),
            GradientLinearProgress(
              value: 0.5,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFBAA81),
                  Color(0xffF27CB1),
                  Color(0xff001925),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Writing Skills'),
                CustomText(text: '70%')
              ],
            ),
            SizedBox(height: 8.h,),
            GradientLinearProgress(
              value: 0.7,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFBAA81),
                  Color(0xffF27CB1),
                  Color(0xff001925),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Pronunciation'),
                CustomText(text: '85%')
              ],
            ),
            SizedBox(height: 8.h,),
            GradientLinearProgress(
              value: 0.8,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFBAA81),
                  Color(0xffF27CB1),
                  Color(0xff001925),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Vocabulary'),
                CustomText(text: '35%')
              ],
            ),
            SizedBox(height: 8.h,),
            GradientLinearProgress(
              value: 0.35,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFBAA81),
                  Color(0xffF27CB1),
                  Color(0xff001925),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Today\'s Goal',fontWeight: FontWeight.w500,),
                CustomText(text: '75%',fontWeight: FontWeight.w500,),
              ],),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: '4 Lessons Completed',fontWeight: FontWeight.w600,fontSize: 18,),
                CustomText(text: '3/4',fontWeight: FontWeight.w600,fontSize: 18,),
              ],),
            SizedBox(height: 8.h,),
            GradientLinearProgress(
              value: 0.75,
              height: 7.h,
              backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 15).toInt()),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFBAA81),
                  Color(0xffF27CB1),
                  Color(0xff001925),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

