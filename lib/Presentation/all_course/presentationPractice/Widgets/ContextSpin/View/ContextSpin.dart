import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/GradientMask.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import '../../../../../Share/record_button.dart';
import '../../../Controller/Controller.dart';
import '../Controller/Controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContextSpin extends StatelessWidget {
  ContextSpin({super.key});
  final controller = Get.find<ContextSpinController>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
        child: Obx(() => controller.isLoading.value
            ? Center(child: CustomCircleProgressIndicator())
            : Padding(
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
                                fontSize: ScreenResponsive.responsiveFont(
                                    context, 18),
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
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                "Scenario : ${controller.scenario}",
                                style: TextStyle(
                                  fontSize: ScreenResponsive.responsiveFont(
                                      context, 15),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GradientMask(
                              child: Text(
                                "Words to include".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenResponsive.responsiveFont(
                                        context, 16)),
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () => Wrap(
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
                            ),
                            SizedBox(height: 10),
                            RecordButton(
                              title: "Record a Context Spin".tr,
                              isRecording: controller.isRunning,
                              audioFile: controller.AudioFilePath,
                              onTap: () {
                                controller.isRunning.value
                                    ? controller.stopRecording()
                                    : controller.startRecording();
                              },
                              recordedText: "Recorded Context Spin".tr,
                              recordDuration: controller.recordDuration,
                              formatDuration: controller.formatDuration,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            if (controller.AudioFilePath.value.isNotEmpty) {
                              if (controller.feedback.value.isEmpty) {
                                controller.submit();
                              } else {
                                Get.find<presentationPracticeController>()
                                    .unlocktask(3);
                                Get.back();
                                AppSnackbar.show("Finished Task 3");
                              }
                            } else {
                              AppSnackbar.show("Please record audio file.");
                            }
                          },
                          child: Obx(
                            () => Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.yellow,
                                    AppColors.pink,
                                    AppColors.sky
                                  ],
                                ),
                              ),
                              child: controller.feedback.value.isEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 5,
                                      children: [
                                        Text(
                                          "Check with Mercury".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Image.asset(
                                          'assets/icons/ai_icon.png',
                                          width: 24.w,
                                          height: 24.h,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 5,
                                      children: [
                                        Text(
                                          "Complete".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                            ),
                          )),
                      const SizedBox(height: 20),
                      Obx(
                        () => controller.feedback.value.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Container(
                                      padding: EdgeInsets.all(15),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(15),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 0.7,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Your Score"),
                                              Spacer(),
                                              Text(
                                                  "${controller.score.value}%"),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          GradientMask(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: LinearProgressIndicator(
                                                minHeight: 8,
                                                color: Colors.white,
                                                backgroundColor: Colors.black26,
                                                value: (controller.score.value /
                                                    100),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GradientMask(
                                    child: Text(
                                      "AI Feedback",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            ScreenResponsive.responsiveFont(
                                          context,
                                          18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() => Text(controller.feedback.value)),
                                ],
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              )));

  }
}
