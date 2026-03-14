import 'package:flutter/material.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/Core/SharepreferenceHelper.dart';
import 'package:manifex/Core/responsive.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:manifex/Presentation/Share/GradientMask.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../../../Core/TTSService.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Controller/Controller.dart';

class powerWordsPlus extends StatelessWidget {
  powerWordsPlus({super.key});
  final controller = Get.find<powerWordsPluseController>();

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
                      "Task 1".tr,
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
                normalText: 'Power ',
                gradientText: 'Words Pulse',
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GradientMask(
                          child: Obx(() => Text(
                            "Word ${controller.currentWord.value + 1} of ${controller.powerWords.length}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenResponsive.responsiveFont(
                                context,
                                18,
                              ),
                            ),
                          ),)
                        ),
                        GestureDetector(
                          onTap: () => controller.nextWord(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(30),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              "Skip".tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Text(
                      "\"${controller.powerWords[controller.currentWord.value]}\"".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenResponsive.responsiveFont(context, 22),
                      ),
                    ),),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: (){
                        TTSService.speak(controller.powerWords[controller.currentWord.value]);

                      },
                      child: Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.volume_up_sharp, color: AppColors.sky, size: 18,),
                          Text("Hear pronunciation".tr, style: TextStyle(color: AppColors.sky),)
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 150,
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.defineRecording.value) {
                                controller.stopRecording("define");
                                controller.defineRecording.value = false;
                              } else {
                                if (controller.sentenceRecording.value) {
                                  AppSnackbar.show(
                                    "You are recording sentence.",
                                  );
                                } else {
                                  controller.startRecording();
                                  controller.defineRecording.value = true;
                                }
                              }
                            },
                            child: Obx(
                              () => Container(
                                height: ScreenResponsive.h(context, 70),
                                width: ScreenResponsive.w(context, 70),
                                decoration: BoxDecoration(
                                  color: controller.defineRecording.value
                                      ?  Colors.red
                                      : null,
                                  gradient: controller.defineRecording.value
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
                                  controller.defineRecording.value
                                      ? Icons.mic_off
                                      : Icons.mic,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text("Define in your own words".tr),
                          Obx(
                            () => controller.defineAudioFile.value.isNotEmpty
                                ? Row(
                                    spacing: 5,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                      Text(
                                        "Definition is recorded".tr,
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 150,
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.sentenceRecording.value) {
                                controller.stopRecording("sentence");
                                controller.sentenceRecording.value = false;
                              } else {
                                if (controller.defineRecording.value) {
                                  AppSnackbar.show(
                                    "You are recording definition.",
                                  );
                                } else {
                                  controller.startRecording();
                                  controller.sentenceRecording.value = true;
                                }
                              }
                            },
                            child: Obx(
                              () => Container(
                                height: ScreenResponsive.h(context, 70),
                                width: ScreenResponsive.w(context, 70),
                                decoration: BoxDecoration(
                                  color: controller.sentenceRecording.value
                                      ? Colors.red
                                      : null,
                                  gradient: controller.sentenceRecording.value
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
                                  controller.sentenceRecording.value
                                      ? Icons.mic_off
                                      : Icons.mic,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text("Use in a sentence".tr),
                          Obx(
                            () => controller.sentenceAudioFile.value.isNotEmpty
                                ? Row(
                                    spacing: 5,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                      Text(
                                        "Sentence is recorded".tr,
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  if(controller.defineAudioFile.value.isNotEmpty && controller.sentenceAudioFile.value.isNotEmpty && controller.feedback.value.isEmpty){
                    controller.submit(
                      define: controller.defineAudioFile.value,
                      sentence: controller.sentenceAudioFile.value,
                      word: controller.powerWords[controller.currentWord.value],
                    );
                  }else if(controller.feedback.value.isNotEmpty){
                    controller.nextWord();
                  } else{
                    AppSnackbar.show("Please record both audio files.");
                  }
                },
                child: Obx(() => Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [AppColors.yellow, AppColors.pink, AppColors.sky],
                    ),
                  ),
                  child: controller.feedback.value.isEmpty ? Row(
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
                  ) : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.currentWord.value == controller.powerWords.length - 1 ? "Finish" : "Next Word".tr,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),)
              ),
              const SizedBox(height: 10),


              Obx(() => controller.feedback.value.isNotEmpty ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(15),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 0.7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Your Score"),
                            Spacer(),
                            Text("${controller.score.value}%"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GradientMask(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              color: Colors.white,
                              backgroundColor: Colors.black26,
                              value:(controller.score.value / 100),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),),
                  const SizedBox(height: 10),
                  GradientMask(child: Text("AI Feedback", style: TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenResponsive.responsiveFont(context, 18)),)),
                  Obx(() => Text(controller.feedback.value),)
                ],
              ) : SizedBox.shrink(),)
            ],
          ),
        ),
      ),
    );
  }
}
