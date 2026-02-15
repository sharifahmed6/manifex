import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Features/Subcription/View/Subcription.dart';
import 'package:manifex/Presentation/Share/GradientMask.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../Share/gradient_title.dart';
import '../Controller/Controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ContextSpin extends StatelessWidget {
  ContextSpin({super.key});
  final controller = Get.find<ContextSpinController>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                  "Task 3".tr,
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
            normalText: 'Context ',
            gradientText: 'Spin',
          ),
          const SizedBox(height: 10),



          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withAlpha(30),
                border: Border.all(
                    color: Colors.grey
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Senario : ${controller.scenario}",
                  style: TextStyle(
                    fontSize: ScreenResponsive.responsiveFont(context, 15),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                GradientMask(child: Text("Words to include".tr, style: TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenResponsive.responsiveFont(context, 16)),),),
                SizedBox(height: 10),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: controller.words.map((word) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        // color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        word,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withAlpha(30),
                      border: Border.all(
                          color: Colors.grey
                      )
                  ),
                  child: Column(
                    children: [
                      Obx(() => Center(
                        child: GestureDetector(
                          onTap: () {
                            controller.isRunning.value ? controller.stopRecording() : controller.startRecording();
                          },
                          child: Container(
                            height: ScreenResponsive.h(context, 70),
                            width: ScreenResponsive.w(context, 70),
                            decoration: BoxDecoration(
                              color: controller.isRunning.value
                                  ?  Colors.red
                                  : null,
                              gradient: controller.isRunning.value
                                  ? null
                                  : LinearGradient(
                                colors: [
                                  AppColors.yellow,
                                  AppColors.pink,
                                  AppColors.sky,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              controller.isRunning.value ? Icons.mic_off : Icons.mic,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),),
                      const SizedBox(height: 10,),
                      Text("Record a Context Spin".tr)
                    ],
                  ),
                ),



              ],
            ),
          ),

          const SizedBox(height: 50),


          Container(
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
        ],
      ),
    ));
  }
}
