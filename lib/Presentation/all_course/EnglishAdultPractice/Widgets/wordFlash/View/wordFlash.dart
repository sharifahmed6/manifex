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
import '../../../../../Share/record_button.dart';
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
                    GradientMask(child: Text("Word ${controller.currentIndex.value + 1} of ${controller.words.length}", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 18), fontWeight: FontWeight.w600),)),
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
                    Center(child: Text("\"${controller.words[controller.currentIndex.value]}\"", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 24), fontWeight: FontWeight.w600),)),
                    RecordButton(
                      title: "Record a Word Flash".tr,
                      isRecording: controller.isRunning,
                      audioFile: controller.AudioFilePath,
                      onTap: () {
                        controller.isRunning.value
                            ? controller.stopRecording()
                            : controller.startRecording();
                      },
                      recordedText: "Word Flash recorded".tr,
                      recordDuration: controller.recordDuration,
                      formatDuration: controller.formatDuration,
                    ),

                    if (controller.showResult.value) ...[
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.sky.withAlpha(100)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Score:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text("${controller.currentScore.value}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.yellow)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text("Feedback:", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(controller.evaluationFeedback.value, style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ]
                  ],
                ),)
              ),
              const SizedBox(height: 20),

              Obx(() => GestureDetector(
                onTap: () {
                  if (controller.showResult.value) {
                    controller.nextWord();
                  } else {
                    if(controller.AudioFilePath.value.isNotEmpty){
                      controller.submit();
                    }else{
                      AppSnackbar.show("Please record the word flash");
                    }
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
                        controller.showResult.value ? "Continue".tr : "Check with Mercury".tr,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (!controller.showResult.value)
                        Image.asset(
                          'assets/icons/ai_icon.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                    ],
                  ),
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
