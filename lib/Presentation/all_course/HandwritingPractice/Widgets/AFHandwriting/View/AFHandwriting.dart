import 'package:flutter/material.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/GradientMask.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import '../../TracingScreen/Controller/Controller.dart';
import '../../TracingScreen/View/TracingScreen.dart';

class AFHandwriting extends StatelessWidget {
  var latter = <String>[].obs;
  var currentIndex = 0.obs;
  String title;
  String description;
  int taskNumber;

  AFHandwriting({super.key, required List<String> latter, required int currentIndex, required this.title, required this.description, required this.taskNumber}) {
    this.latter.assignAll(latter);
    this.currentIndex.value = currentIndex;
  }

  void nextLatter() {
    if (currentIndex.value < latter.length - 1) {
      currentIndex.value++;
      Get.put(TracingController()).clearCanvas();
    } else {
      AppSnackbar.show("No more latter left.");
    }
  }

  void previousLatter() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      Get.put(TracingController()).clearCanvas();
    } else {
      AppSnackbar.show("No more latter left.");
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
              GradientTitle(
                fontSize: 20,
                normalText: title,
                gradientText: ' Handwriting',
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
                    Obx(() => GradientMask(
                      child: Text(
                        "Latter ${currentIndex.value + 1} of ${latter.length}",
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(context, 18),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: previousLatter,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(15),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 0.7),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back, color: Colors.white, size: 18),
                                const SizedBox(width: 5),
                                Text(
                                  "Previous",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenResponsive.responsiveFont(context, 16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: nextLatter,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(15),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 0.7),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenResponsive.responsiveFont(context, 16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 500,
                        child: Obx(
                              () => TracingScreen(word: latter[currentIndex.value]),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
