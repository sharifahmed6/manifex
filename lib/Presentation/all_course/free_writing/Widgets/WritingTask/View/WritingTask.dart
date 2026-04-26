import 'package:flutter/material.dart';
import 'package:manifex/Core/MusicService.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/GradientMask.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import '../../../../../Share/custom_circle_progress_indicator.dart';
import '../../../Controller/Controller.dart';
import '../../WritingArea/Controller/Controller.dart';
import '../../WritingArea/View/WritingArea.dart';
import '../Controller/Controller.dart';

class WritingTask extends StatefulWidget {
  final String title;
  final String description;
  final int taskNumber;
  final bool isCursive;

  WritingTask({
    super.key,
    required this.title,
    required this.description,
    required this.taskNumber,
    this.isCursive = false,
  });

  @override
  State<WritingTask> createState() => _WritingTaskState();
}

class _WritingTaskState extends State<WritingTask> {
  final controller = Get.put(WritingTaskController());
  final areaController = Get.put(WritingAreaController());

  @override
  void initState() {
    super.initState();
    controller.reset();
    controller.fetchWords();
  }

  @override
  void dispose() {
    // Delete controllers to ensure next task starts fresh
    Get.delete<WritingTaskController>();
    Get.delete<WritingAreaController>();
    super.dispose();
  }

  void next() {
    if (!controller.isStepTwo.value) {
      // Transition from Step 1 to Step 2 for the same word
      controller.isStepTwo.value = true;
      areaController.clearCanvas();
    } else {
      // Transition to Step 1 of the next word
      if (controller.currentIndex.value < controller.words.length - 1) {
        controller.currentIndex.value++;
        controller.isStepTwo.value = false;
        areaController.clearCanvas();
      } else {
        // Task complete
        Get.find<FreeWritingController>().unLockTask(widget.taskNumber);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CustomCircleProgressIndicator());
        }

        if (controller.words.isEmpty) {
          return Center(child: Text("No words found.", style: TextStyle(color: Colors.white)));
        }

        final currentWord = controller.words[controller.currentIndex.value];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        "Task ${widget.taskNumber}".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenResponsive.responsiveFont(context, 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientTitle(
                      fontSize: 20,
                      normalText: widget.title,
                      gradientText: ' Writing',
                    ),
                    // Obx(() {
                    //   final music = MusicService();
                    //   return IconButton(
                    //     onPressed: () {
                    //       music.toggleMusic();
                    //     },
                    //     icon: Icon(
                    //       music.isPlayingRx.value
                    //           ? Icons.volume_up_sharp
                    //           : Icons.volume_off,
                    //       color: Colors.white70,
                    //     ),
                    //   );
                    // }),
                  ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientMask(
                            child: Text(
                              "Word ${controller.currentIndex.value + 1} of ${controller.words.length}",
                              style: TextStyle(
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  18,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: controller.isStepTwo.value ? Colors.orange.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              controller.isStepTwo.value ? "Step 2: Independent" : "Step 1: Tracing",
                              style: TextStyle(
                                color: controller.isStepTwo.value ? Colors.orange : Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.isStepTwo.value 
                          ? "Now try writing it again without the watermark!".tr 
                          : "Trace the word to practice its shape.".tr,
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(context, 17),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 400,
                          child: WritingArea(
                            word: currentWord,
                            isCursive: widget.isCursive,
                            showWatermark: !controller.isStepTwo.value,
                            isTaskTwo: widget.taskNumber == 2,
                          ),
                        ),
                      ),

                      Obx(() => GestureDetector(
                        onTap: areaController.isLoading.value ? null : () async {
                          String? pngPath = await areaController.saveSignaturePng(
                            fileName: 'free_writing_$currentWord',
                          );

                          if (pngPath != null) {
                            bool isCorrect = await areaController.checkWriting(
                              imagePath: pngPath,
                              word: currentWord,
                            );
                            
                            if (isCorrect) {
                              next();
                            }
                          } else {
                            AppSnackbar.show("Please write something first.");
                          }
                        },
                        child: Container(
                          height: 55,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.yellow,
                                AppColors.pink,
                                AppColors.sky,
                              ],
                            ),
                          ),
                          child: Center(
                            child: areaController.isLoading.value 
                              ? CircularProgressIndicator(color: Colors.white)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 5),
                                    Text(
                                      "Submit and Check".tr,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Image.asset(
                                      'assets/icons/ai_icon.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ],
                                ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
