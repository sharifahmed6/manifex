import 'package:flutter/material.dart';
import 'package:manifex/Presentation/Share/GradientMask.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../Share/gradient_title.dart';
import '../../../../../app_bar/views/custom_app_bar.dart';
import '../Controller/Controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class flowChain extends StatelessWidget {
  flowChain({super.key});
  final controller = Get.find<flowChainController>();

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
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    Text(
                      "Task 4".tr,
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
                normalText: 'Flow ',
                gradientText: 'Chain',
              ),
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withAlpha(30),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientMask(child: Text("Select scenarios to connect (1-3):", style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context, 15)),),),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: controller.words.map((word) {

                        return Obx(() {

                          final isSelected = controller.isSelected(word);

                          return GestureDetector(
                            onTap: () => controller.toggleWord(word),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                ),
                              ),
                              child: Text(
                                word,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  color: isSelected ? Colors.white : Colors.white,
                                ),
                              ),
                            ),
                          );
                        });

                      }).toList(),
                    ),


                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withAlpha(30),
                          border: Border.all(
                              color: Colors.grey
                          )
                      ),
                      child: Column(
                        children: [
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
                                  controller.isRunning.value ? Icons.mic_off : Icons.mic,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),),
                          const SizedBox(height: 10,),
                          Text("Record a Flow Chain".tr)
                        ],
                      ),
                    )

                  ],
                ),
              ),

              const SizedBox(height: 40),

              Container(
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



            ],
          ),
        ),
      ),
    );
  }
}
