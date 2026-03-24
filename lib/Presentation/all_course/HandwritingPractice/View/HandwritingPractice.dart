import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifex/Presentation/all_course/HandwritingPractice/Widgets/AFHandwriting/View/AFHandwriting.dart';
import '../../../../Core/MusicService.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/scafold_background.dart';
import '../../../Share/single_skill_card.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import '../../ShareProgress/View/ShareProgress.dart';
import '../../ShareProgress/View/Tab.dart';
import '../../interactive_reading/widget/interactive_border_color_gradient.dart';
import 'package:get/get.dart';
import '../../practices/widget/skill_welcome_card.dart';
import '../Controller/Controller.dart';
import '../Widgets/AFHandwriting/Controller/Controller.dart';

class HandwritingPractice extends StatelessWidget {
  HandwritingPractice({super.key});
  final controller = Get.find<HandwritingPracticeController>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(text: 'Handwriting Practice'),
              ],
            ),
            SizedBox(height: 18.h),

            InteractiveBorderColor(
                child: Obx(() => GradientToggle(
                  selectedIndex: controller.selectedIndex.value,
                  onTabChanged: (index) {
                    controller.selectedIndex.value = index;
                  },
                )),
            ),
            SizedBox(height: 18.h),
            Expanded(
              child: Obx(() {
                int falseCount = controller.listLock.where((e) => !e).length;
                return IndexedStack(
                  index: controller.selectedIndex.value,
                  children: [
                    _skillScreen(),
                    ShareProgress(
                      timer: controller.formattedTime,
                      currentTask: falseCount,
                      totalTask: controller.listLock.length,
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}


class _skillScreen extends StatelessWidget {
  _skillScreen({super.key});
  final controller = Get.find<HandwritingPracticeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkillWelcomeCard(),
            const SizedBox(height: 10,),
            GradientTitle(
              fontSize: 20,
              normalText: 'Handwriting ',
              gradientText: 'Practice',
            ),
            Text("Learn to write letters the fun way.".tr, style: TextStyle(color: Colors.grey),),

            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'Cursive Letters'.tr,
              subTitle: 'Practice tracing uppercase and lowercase cursive letters A to z.'.tr,
              buttonText: 'Task 1',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = true;
                Get.to(AFHandwriting(
                  latter: [
                    'A', 'a', 'B', 'b', 'C', 'c', 'D', 'd', 'E', 'e', 'F', 'f', 'G', 'g', 'H', 'h', 'I', 'i', 'J', 'j', 'K', 'k', 'L', 'l', 'M', 'm', 'N', 'n', 'O', 'o', 'P', 'p', 'Q', 'q', 'R', 'r', 'S', 's', 'T', 't', 'U', 'u', 'V', 'v', 'W', 'w', 'X', 'x', 'Y', 'y', 'Z', 'z'
                  ],
                  currentIndex: 0,
                  title: 'Cursive Letters',
                  description: 'Practice tracing cursive letters uppercase and lowercase separately.',
                  taskNumber: 1,
                ));
              },
              isComplete: controller.listComplete[0],
              lock: controller.listLock[0],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'A-F'.tr,
              subTitle: 'Practice tracing uppercase letters A to F to improve handwriting skills.'.tr,
              buttonText: 'Task 2',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['A', 'B', 'C', 'D', 'E', 'F'], currentIndex: 0, title: 'A-F', description: 'Practice tracing uppercase letters A to F to improve handwriting skills.', taskNumber: 2,));
              },
              isComplete: controller.listComplete[1],
              lock: controller.listLock[1],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'G-L'.tr,
              subTitle: 'Practice tracing uppercase letters G to L to strengthen letter formation.'.tr,
              buttonText: 'Task 3',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['G', 'H', 'I', 'J', 'K', 'L'], currentIndex: 0, title: 'G-L', description: 'Practice tracing uppercase letters G to L to strengthen letter formation.', taskNumber: 3,));
              },
              isComplete: controller.listComplete[2],
              lock: controller.listLock[2],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'M-R'.tr,
              subTitle: 'Practice tracing uppercase letters M to R for consistent handwriting.'.tr,
              buttonText: 'Task 4',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['M', 'N', 'O', 'P', 'Q', 'R'], currentIndex: 0, title: 'M-R', description: 'Practice tracing uppercase letters M to R for consistent handwriting.', taskNumber: 4,));
              },
              isComplete: controller.listComplete[3],
              lock: controller.listLock[3],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'S-Z'.tr,
              subTitle: 'Practice tracing uppercase letters S to Z to master letter shapes.'.tr,
              buttonText: 'Task 5',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'], currentIndex: 0, title: 'S-Z', description: 'Practice tracing uppercase letters S to Z to master letter shapes.', taskNumber: 5,));
              },
              isComplete: controller.listComplete[4],
              lock: controller.listLock[4],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'a-f'.tr,
              subTitle: 'Practice tracing lowercase letters a to f to improve fine motor control.'.tr,
              buttonText: 'Task 6',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['a', 'b', 'c', 'd', 'e', 'f'], currentIndex: 0, title: 'a-f', description: 'Practice tracing lowercase letters a to f to improve fine motor control.', taskNumber: 6,));
              },
              isComplete: controller.listComplete[5],
              lock: controller.listLock[5],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'g-l'.tr,
              subTitle: 'Practice tracing lowercase letters g to l to strengthen handwriting fluency.'.tr,
              buttonText: 'Task 7',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['g', 'h', 'i', 'j', 'k', 'l'], currentIndex: 0, title: 'g-l', description: 'Practice tracing lowercase letters g to l to strengthen handwriting fluency.', taskNumber: 7,));
              },
              isComplete: controller.listComplete[6],
              lock: controller.listLock[6],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'm-r'.tr,
              subTitle: 'Practice tracing lowercase letters m to r for smooth and accurate writing.'.tr,
              buttonText: 'Task 8',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['m' , 'n', 'o', 'p', 'q', 'r'], currentIndex: 0, title: 'm-r', description: 'Practice tracing lowercase letters m to r for smooth and accurate writing.', taskNumber: 8,));
              },
              isComplete: controller.listComplete[7],
              lock: controller.listLock[7],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 's-z'.tr,
              subTitle: 'Practice tracing lowercase letters s to z to master handwriting consistency.'.tr,
              buttonText: 'Task 9',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['s', 't', 'u', 'v', 'w', 'x', 'y', 'z'], currentIndex: 0, title: 's-z', description: 'Practice tracing lowercase letters s to z to master handwriting consistency.', taskNumber: 9,));
              },
              isComplete: controller.listComplete[8],
              lock: controller.listLock[8],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: '0-9'.tr,
              subTitle: 'Practice tracing numbers 0 to 9 to improve number writing skills.'.tr,
              buttonText: 'Task 10',
              onTap: (){
                final afController = Get.put(AFHandwritingController());
                afController.isCursive.value = false;
                Get.to(AFHandwriting(latter: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'], currentIndex: 0, title: '0-9', description: 'Practice tracing numbers 0 to 9 to improve number writing skills.', taskNumber: 10,));
              },
              isComplete: controller.listComplete[9],
              lock: controller.listLock[9],
            ),


          ],
        ),)
    );
  }
}
