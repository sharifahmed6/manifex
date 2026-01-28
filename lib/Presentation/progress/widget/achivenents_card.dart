 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/progress/controllers/progress_controller.dart';

import '../../practices/widget/transperent_gradient_border.dart';
import 'achievment_gradient_border.dart';

class AchivenentsCard extends StatelessWidget {
    AchivenentsCard({super.key, this.imagePath, this.title, this.lock = false, this.subTitle});
final controller = Get.find<ProgressController>();
final String? imagePath;
final String? title;
final String? subTitle;
final bool lock;
   @override
   Widget build(BuildContext context) {
     return  AchievmentGradientBorder(
       strokeWidth: 0.5,
       radius: 16.r,
       lock: lock,
       child: Container(
         padding: EdgeInsets.all(16.w),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(16.r),
          color: Color(0xffFFFFFF).withAlpha((2.56 * 12).toInt())
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Container(
                   padding: EdgeInsets.all(16.w),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: lock ? null: Color(0xffFFFFFF).withAlpha((2.56 * 50).toInt()),
                     gradient: lock ? LinearGradient(
                         colors:[
                           Color(0xffFFBC6F),
                           Color(0xffF176B7),
                           Color(0xff3797CD),
                         ]
                     ): null,
                   ),
                   child: Image.asset(imagePath ?? '',width: 20.w,height: 20.w,color: lock ? Color(0xffFFFFFF): Color(0xff232339),),
                 ),
                 Container(
                   padding: EdgeInsets.all(8.w),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: lock ? null: Color(0xffFFFFFF).withAlpha((2.56 * 50).toInt()),
                     gradient: lock ? LinearGradient(
                         colors:[
                           Color(0xffFFBC6F),
                           Color(0xffF176B7),
                           Color(0xff3797CD),
                         ]
                     ): null,
                   ),
                   child: Icon(Icons.check,color: Colors.white,size: 12.sp,),
                 ),
               ],
             ),
             SizedBox(height: 8.h,),
             CustomText(text: title ?? '',fontSize: 24,fontWeight: FontWeight.w600,),
             CustomText(text: subTitle ?? '',fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),),
             SizedBox(height: 16.h,),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 6.h),
               decoration: BoxDecoration(
                 color: lock ? null : Color(0xffFFFFFF).withAlpha((2.56 * 50).toInt()),
                 gradient: lock ? LinearGradient(
                     colors: [
                       Color(0xff11D067),
                       Color(0xff01803A)
                     ],
                 ): null,
                 borderRadius: BorderRadius.circular(8.r)
               ),
               child: lock ? CustomText(text: 'Unlocked',fontSize: 16,fontWeight: FontWeight.w600,) : CustomText(text: 'Keep Practicing to Unlock',color: Color(0xff05051E),fontSize: 16,fontWeight: FontWeight.w600),
             )
           ],
         ),
       ),
     );
   }
 }