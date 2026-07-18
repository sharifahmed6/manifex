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
import '../../TracingScreen/Controller/Controller.dart';
import '../../TracingScreen/View/TracingScreen.dart';
import '../Controller/Controller.dart';

class AFHandwriting extends GetView<AFHandwritingController> {
  var latter = <String>[].obs;
  var currentIndex = 0.obs;
  String title;
  String description;
  int taskNumber;

  final controller = Get.find<AFHandwritingController>();
  final tracingController = Get.put(TracingController());

  AFHandwriting({
    super.key,
    required List<String> latter,
    required int currentIndex,
    required this.title,
    required this.description,
    required this.taskNumber,
  }) {
    this.latter.assignAll(latter);
    this.currentIndex.value = currentIndex;
  }

  void nextLatter() {
    if (currentIndex.value < latter.length - 1) {
      currentIndex.value++;
      tracingController.clearCanvas();
    } else {
      AppSnackbar.show("No more letters left.");
    }
  }

  void previousLatter() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      tracingController.clearCanvas();
    } else {
      AppSnackbar.show("No more letters left.");
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
                    gradientText: ' Handwriting',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
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
                        Obx(
                          () => GradientMask(
                            child: Text(
                              "Letter ${currentIndex.value + 1} of ${latter.length}",
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
                      ],
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

                    const SizedBox(height: 20),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx(
                          () => TracingScreen(word: latter[currentIndex.value]),
                        ),
                      ),
                    ),

                    Obx(
                      () => GestureDetector(
                        onTap: tracingController.isLoading.value
                            ? null
                            : () async {
                                final word = latter[currentIndex.value];
                                String? pngPath = await tracingController
                                    .saveSignaturePng(
                                  controller:
                                      tracingController.signatureController,
                                  fileName: 'traced_word_$word',
                                  word: word,
                                );

                                if (pngPath == null) {
                                  AppSnackbar.show(
                                    "Failed to save image. Please draw something.",
                                  );
                                  return;
                                }

                                tracingController.imagePath.value = pngPath;

                                final handwritingController =
                                    Get.find<HandwritingPracticeController>();

                                print("PNG saved at: $pngPath");
                                bool isCorrect = await tracingController.submit(
                                    imagePath: pngPath, word: word);

                                if (isCorrect) {
                                  if (currentIndex.value < latter.length - 1) {
                                    currentIndex.value++;
                                  } else {
                                    // When task is completed
                                    handwritingController.unLockTask(taskNumber);
                                    if (taskNumber == 1) {
                                      MusicService().stop();
                                    }
                                  }
                                  tracingController.clearCanvas();
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
                              if (tracingController.isLoading.value) ...[
                                const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Checking...".tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ] else ...[
                                const SizedBox(width: 5),
                                Text(
                                  "Check with Mercury".tr,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
