import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:manifex/Core/TTSService.dart';
import 'package:manifex/Presentation/Features/Subcription/View/Subcription.dart';
import 'package:manifex/Presentation/Share/GradientMask.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import '../Controller/Controller.dart';

class auditoryDiscrimination extends StatelessWidget {
  auditoryDiscrimination({super.key});
  final controller = Get.find<auditoryDiscriminationController>();

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
                normalText: 'Auditory ',
                gradientText: 'Discrimination',
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
                    Obx(() => GradientMask(child: Text("Word ${controller.currentIndex.value + 1} of ${controller.word_pairs.length}", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 18), fontWeight: FontWeight.w600),)),),
                    const SizedBox(height: 10),
                    Text("Listen carefully and select if both are same or different".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 17), fontWeight: FontWeight.w600),),
                    const SizedBox(height: 10),
                    Text("Click the play button to hear the word, then select if both are similar or different.".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 12)),),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  TTSService.speak(controller.word_pairs[controller.currentIndex.value]['word1']!);
                                },
                                child: Container(
                                  height: ScreenResponsive.h(context, 70),
                                  width: ScreenResponsive.w(context, 70),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.yellow,
                                        AppColors.pink,
                                        AppColors.sky,
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.volume_up_sharp,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Word 1", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 16), fontWeight: FontWeight.w600),),
                          ],
                        ),

                        Column(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  TTSService.speak(controller.word_pairs[controller.currentIndex.value]['word2']!);

                                },
                                child: Container(
                                  height: ScreenResponsive.h(context, 70),
                                  width: ScreenResponsive.w(context, 70),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.yellow,
                                        AppColors.pink,
                                        AppColors.sky,
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.volume_up_sharp,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Word 2", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 16), fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GradientButton(text: "Similar",
                          onPressed: () => controller.finalAnswer.value = "same",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: GradientButton(text: "Different",
                          onPressed: () => controller.finalAnswer.value = "different",
                        ),

                        )
                      ],
                    ),
                    const SizedBox(height: 10),

                    Obx(() => controller.finalAnswer.value.isNotEmpty ? Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Colors.green
                          ),
                        ),
                        child: Text("You have selected : ${controller.finalAnswer.value}".tr, style: TextStyle(color: Colors.green),),
                      ),
                    ) : SizedBox.shrink(),),
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
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  if(controller.finalAnswer.value.isNotEmpty && controller.currentIndex.value == controller.word_pairs.length - 1){
                    // Get.back();
                    controller.submit();
                    AppSnackbar.show("Auditory discrimination task completed.");
                  } else if(controller.finalAnswer.value.isNotEmpty){
                    controller.submit();
                  }else{
                    AppSnackbar.show("Please select answer.");
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
