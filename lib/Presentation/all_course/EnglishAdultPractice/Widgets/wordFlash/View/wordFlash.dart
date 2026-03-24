import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/GradientMask.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../Share/scafold_background.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import '../Controller/Controller.dart';

class wordFlash extends StatelessWidget {
  wordFlash({super.key});
  final controller = Get.find<wordFlashController>();

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
                normalText: 'Word ',
                gradientText: 'Flash',
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(15),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 0.7),
                ),
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => GradientMask(child: Text("Word ${controller.currentIndex.value + 1} of ${controller.words.length}", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 18), fontWeight: FontWeight.w600),)),),
                    const SizedBox(height: 10),
                    Text("Read the word aloud before it vanishes".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 17), fontWeight: FontWeight.w600),),
                    const SizedBox(height: 10),
                    Text("This text should appear for 1-3 seconds and then blur out or disappear.".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 12)),),
                    if (controller.isCounting.value)
                      Text(
                        "You have ${controller.countdown.value} seconds to read the word.",
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(context, 12),
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    const SizedBox(height: 20),
                    Obx(() => Center(child: Text("\"${controller.words[controller.currentIndex.value]}\"", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 24), fontWeight: FontWeight.w600),)),),
                    const SizedBox(height: 10),
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
                                : controller.AudioFilePath.value.isNotEmpty ? Colors.green : null,
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
                    const SizedBox(height: 10),

                    if(controller.AudioFilePath.value.isNotEmpty)
                      Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Icon(Icons.check, color: Colors.green, size: 18,),
                          Text("Word Flash recorded", style: TextStyle(color: Colors.green),),
                        ],
                      )),

                    const SizedBox(height: 10),


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
                ),)
              ),
              const SizedBox(height: 20),

              
              GestureDetector(
                onTap: () {
                  if(controller.AudioFilePath.value.isNotEmpty){
                    controller.submit();
                  }else{
                    AppSnackbar.show("Please record the word flash");
                  }
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
                        "Check with Mercury".tr,
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



