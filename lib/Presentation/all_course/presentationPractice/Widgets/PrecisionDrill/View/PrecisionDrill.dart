import 'package:flutter/material.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/GradientMask.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Controller/Controller.dart';
import '../Controller/Controller.dart';

class PrecisionDrill extends StatelessWidget {
  PrecisionDrill({super.key});
  final controller = Get.find<PrecisionDrillController>();

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
                      "Task 2".tr,
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
                normalText: 'Precision  ',
                gradientText: 'Drill',
              ),
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withAlpha(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("Speed: ${controller.currentSpeed.value}"),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withAlpha(30),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Current Word".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.currentWord.value.isEmpty
                                  ? "Start Recording"
                                  : controller.currentWord.value,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: controller.currentWord.value.isNotEmpty
                                    ? AppColors.pink
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withAlpha(30),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.isRunning.value
                                    ? controller.stopDrill()
                                    : controller.startDrill();
                              },
                              child: Container(
                                height: ScreenResponsive.h(context, 70),
                                width: ScreenResponsive.w(context, 70),
                                decoration: BoxDecoration(
                                  color: controller.isRunning.value
                                      ? Colors.red
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
                                  controller.isRunning.value
                                      ? Icons.mic_off
                                      : Icons.mic,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            Obx(
                              () => controller.AudioFilePath.value.isNotEmpty
                                  ? Row(
                                      spacing: 5,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 18,
                                        ),
                                        Text(
                                          "Precision Drill completed successfully."
                                              .tr,
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ],
                                    )
                                  : Text("Record a Precision Drill".tr),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  if (controller.AudioFilePath.value.isNotEmpty) {
                    if (controller.feedback.value.isEmpty) {
                      controller.submit();
                    }else{
                      Get.find<presentationPracticeController>().unlocktask(2);
                      Get.back();
                      AppSnackbar.show("Finished Task 2");
                    }
                  } else {
                    AppSnackbar.show("Please record audio file.");
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
                  child: controller.feedback.value.isEmpty ?  Row(
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
                        "Complete".tr,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),)
              ),
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
                                        value: (controller.score.value / 100),
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
                                fontSize: ScreenResponsive.responsiveFont(
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
      ),
    );
  }
}
