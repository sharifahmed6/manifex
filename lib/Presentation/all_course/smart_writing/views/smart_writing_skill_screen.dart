import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/all_course/practices/widget/skill_welcome_card.dart';
import 'package:manifex/Presentation/all_course/smart_writing/controller/smart_writing_controller.dart';
import 'package:manifex/Presentation/all_course/smart_writing/widget/topic_border.dart';

import '../../../Share/gradient_title.dart';

class SmartWritingSkillScreen extends StatelessWidget {
   SmartWritingSkillScreen({super.key});
  final controller = Get.find<SmartWritingController>();
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
          CustomText(text: 'Pick a topic that sparks your creativity and imagination',color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),),
          SizedBox(height: screenHeight * 0.02),
          Obx(() {
            final selected = controller.selectedValue.value;
            return Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: controller.items.map((t) {
                final isSelected = selected == t;
                return _interestChip(
                  text: t,
                  isSelected: isSelected,
                  onTap: () => controller.select(t),
                );
              }).toList(),
            );
          }),
          SizedBox(height: screenHeight * 0.03),
          CustomText(text: 'Your Writing Space',fontSize: 20,fontWeight: FontWeight.w600,),
          SizedBox(height: screenHeight * 0.01),
          CustomText(text: 'Express your thoughts clearly and creatively. Aim for at least 3-4 sentence',fontSize: 16,color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),),
          SizedBox(height: screenHeight * 0.02),
          TextFormField(
            maxLines: 8,
            decoration: InputDecoration(
              hint: CustomText(text: 'Write about "Sports" here. Try to describe your thoughts clearly in at least 3-4 sentences...',fontSize: 16,fontWeight: FontWeight.w300,color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),)
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          ButtonGradient(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8.h,
              children: [
                CustomText(text: 'Check My Writing with AI',fontSize: 16,fontWeight: FontWeight.w600,),
                Image.asset('assets/icons/ai_icon.png',width: 24.w,height: 24.h,)
              ],
            ),
          ),
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
       colors: [
         Color(0xFFFFBC6F),
         Color(0xFFF176B7),
         Color(0xFF3797CD),
       ],
     );

     return GestureDetector(
       behavior: HitTestBehavior.opaque,
       onTap: onTap,
       child: TopicBorder(
         strokeWidth: strokeWidth,
         child: AnimatedContainer(
           duration: const Duration(milliseconds: 180),
           curve: Curves.ease,
           padding: padding ?? EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
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
               color: Colors.white, // ShaderMask এর জন্য
             ),
           ),
         ),
       ),
     );
   }
}