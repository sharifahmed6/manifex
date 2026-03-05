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
import '../../../Controller/Controller.dart';
import '../../WritingArea/Controller/Controller.dart';
import '../../WritingArea/View/WritingArea.dart';
import '../Controller/Controller.dart';

class WritingTask extends GetView<WritingTaskController> {
  final words = <String>[].obs;
  final currentIndex = 0.obs;
  final String title;
  final String description;
  final int taskNumber;
  final bool isCursive;

  @override
  final controller = Get.put(WritingTaskController());

  WritingTask({
    super.key,
    required List<String> words,
    required int currentIndex,
    required this.title,
    required this.description,
    required this.taskNumber,
    this.isCursive = false,
  }) {
    this.words.assignAll(words);
    this.currentIndex.value = currentIndex;
  }

  void nextWord() {
    if (currentIndex.value < words.length - 1) {
      currentIndex.value++;
      Get.find<WritingAreaController>().clearCanvas();
    } else {
      AppSnackbar.show("Last word reached.");
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      Get.find<WritingAreaController>().clearCanvas();
    } else {
      AppSnackbar.show("First word reached.");
    }
  }

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
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      "Task $taskNumber".tr,
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
                    normalText: title,
                    gradientText: ' Writing',
                  ),
                  Obx(() {
                    final music = MusicService();
                    return IconButton(
                      onPressed: () {
                        if (music.isPlaying) {
                          music.stop();
                        } else {
                          music.play();
                        }
                      },
                      icon: Icon(
                        music.isPlaying
                            ? Icons.volume_off
                            : Icons.volume_up_sharp,
                        color: Colors.white70,
                      ),
                    );
                  }),
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
                    Obx(
                      () => GradientMask(
                        child: Text(
                          "Word ${currentIndex.value + 1} of ${words.length}",
                          style: TextStyle(
                            fontSize: ScreenResponsive.responsiveFont(
                              context,
                              18,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title.tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 17),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description.tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 12),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Visibility(
                      visible: words.length != 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: previousWord,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(15),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.7,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Previous",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        16,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: nextWord,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(15),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.7,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Next",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        16,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 400,
                        child: Obx(
                          () => WritingArea(
                            word: words[currentIndex.value],
                            isCursive: isCursive,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () async {
                        final areaController =
                            Get.find<WritingAreaController>();
                        final word = words[currentIndex.value];
                        String? pngPath = await areaController.saveSignaturePng(
                          controller: areaController.signatureController,
                          fileName: 'free_writing_$word',
                          word: word,
                        );

                        if (pngPath != null) {
                          await areaController.submit(
                            imagePath: pngPath,
                            word: word,
                            taskNumber: taskNumber,
                          );
                          if (currentIndex.value < words.length - 1) {
                            nextWord();
                          } else {
                            Get.find<FreeWritingController>().unLockTask(
                              taskNumber,
                            );
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
                        child: Row(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
