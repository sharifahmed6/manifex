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
                      music.isPlaying ? Icons.volume_off : Icons.volume_up_sharp,
                      color: Colors.white70,
                    ),
                  );
                })
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
              title: 'A-F'.tr,
              subTitle: 'Practice tracing uppercase letters A to F to improve handwriting skills.'.tr,
              buttonText: 'Task 1',
              onTap: (){
                // print("${PrefHelper.getAccessToken()}");
                Get.to(AFHandwriting(latter: ['A', 'B', 'C', 'D', 'E', 'F'], currentIndex: 0, title: 'A-F', description: 'Practice tracing uppercase letters A to F to improve handwriting skills.', taskNumber: 1,));
              },
              isComplete: controller.listComplete[0],
              lock: controller.listLock[0],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'G-L'.tr,
              subTitle: 'Practice tracing uppercase letters G to L to strengthen letter formation.'.tr,
              buttonText: 'Task 2',
              onTap: (){
                Get.to(AFHandwriting(latter: ['G', 'H', 'I', 'J', 'K', 'L'], currentIndex: 0, title: 'G-L', description: 'Practice tracing uppercase letters G to L to strengthen letter formation.', taskNumber: 2,));
              },
              isComplete: controller.listComplete[1],
              lock: controller.listLock[1],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'M-R'.tr,
              subTitle: 'Practice tracing uppercase letters M to R for consistent handwriting.'.tr,
              buttonText: 'Task 3',
              onTap: (){
                Get.to(AFHandwriting(latter: ['M', 'N', 'O', 'P', 'Q', 'R'], currentIndex: 0, title: 'M-R', description: 'Practice tracing uppercase letters M to R for consistent handwriting.', taskNumber: 3,));
              },
              isComplete: controller.listComplete[2],
              lock: controller.listLock[2],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'S-Z'.tr,
              subTitle: 'Practice tracing uppercase letters S to Z to master letter shapes.'.tr,
              buttonText: 'Task 4',
              onTap: (){
                Get.to(AFHandwriting(latter: ['S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'], currentIndex: 0, title: 'S-Z', description: 'Practice tracing uppercase letters S to Z to master letter shapes.', taskNumber: 4,));
              },
              isComplete: controller.listComplete[3],
              lock: controller.listLock[3],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'a-f'.tr,
              subTitle: 'Practice tracing lowercase letters a to f to improve fine motor control.'.tr,
              buttonText: 'Task 5',
              onTap: (){
                Get.to(AFHandwriting(latter: ['a', 'b', 'c', 'd', 'e', 'f'], currentIndex: 0, title: 'a-f', description: 'Practice tracing lowercase letters a to f to improve fine motor control.', taskNumber: 5,));
              },
              isComplete: controller.listComplete[4],
              lock: controller.listLock[4],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'g-l'.tr,
              subTitle: 'Practice tracing lowercase letters g to l to strengthen handwriting fluency.'.tr,
              buttonText: 'Task 6',
              onTap: (){
                Get.to(AFHandwriting(latter: ['g', 'h', 'i', 'j', 'k', 'l'], currentIndex: 0, title: 'g-l', description: 'Practice tracing lowercase letters g to l to strengthen handwriting fluency.', taskNumber: 6,));
              },
              isComplete: controller.listComplete[5],
              lock: controller.listLock[5],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 'm-r'.tr,
              subTitle: 'Practice tracing lowercase letters m to r for smooth and accurate writing.'.tr,
              buttonText: 'Task 7',
              onTap: (){
                Get.to(AFHandwriting(latter: ['m' , 'n', 'o', 'p', 'q', 'r'], currentIndex: 0, title: 'm-r', description: 'Practice tracing lowercase letters m to r for smooth and accurate writing.', taskNumber: 7,));
              },
              isComplete: controller.listComplete[6],
              lock: controller.listLock[6],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: 's-z'.tr,
              subTitle: 'Practice tracing lowercase letters s to z to master handwriting consistency.'.tr,
              buttonText: 'Task 8',
              onTap: (){
                Get.to(AFHandwriting(latter: ['s', 't', 'u', 'v', 'w', 'x', 'y', 'z'], currentIndex: 0, title: 's-z', description: 'Practice tracing lowercase letters s to z to master handwriting consistency.', taskNumber: 8,));
              },
              isComplete: controller.listComplete[7],
              lock: controller.listLock[7],
            ),
            const SizedBox(height: 15,),

            SingleSkillCard(
              title: '0-9'.tr,
              subTitle: 'Practice tracing numbers 0 to 9 to improve number writing skills.'.tr,
              buttonText: 'Task 9',
              onTap: (){
                Get.to(AFHandwriting(latter: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'], currentIndex: 0, title: '0-9', description: 'Practice tracing numbers 0 to 9 to improve number writing skills.', taskNumber: 9,));
              },
              isComplete: controller.listComplete[8],
              lock: controller.listLock[8],
            ),


          ],
        ),)
    );
  }
}

//
// class TracingController extends GetxController {
//   final SignatureController signatureController = SignatureController(
//     penStrokeWidth: 6,
//     penColor: Colors.blue,
//     exportBackgroundColor: Colors.transparent,
//   );
//
//   void clearCanvas() => signatureController.clear();
// }
//
// class TracingScreen extends StatelessWidget {
//   final String word;
//   TracingScreen({super.key, required this.word});
//
//   final TracingController controller = Get.put(TracingController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Center(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Text(
//                   word,
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                     fontSize: ScreenResponsive.responsiveFont(context, 350),
//                     height: 1,
//                     fontWeight: FontWeight.w200,
//                     color: Colors.grey.withOpacity(0.3),
//                   ),
//                 ),
//                 Signature(
//                   controller: controller.signatureController,
//                   backgroundColor: Colors.transparent,
//                 ),
//               ],
//             ),
//           ),
//
//           Positioned(
//             top: 16,
//             right: 16,
//             child: IconButton(
//               icon: Icon(Icons.clear, color: Colors.grey, size: 28),
//               onPressed: controller.clearCanvas,
//             ),
//           ),
//
//
//           Positioned(
//             bottom: 0,
//             right: 0,
//             left: 0,
//             child: GestureDetector(
//               onTap: () async {
//
//                 String? pngPath = await Get.find<HandwritingPracticeController>().saveSignaturePng(controller.signatureController, "traced_word");
//
//                 if (pngPath != null) {
//                   print("PNG saved at: $pngPath");
//                 } else {
//                   AppSnackbar.show("Please draw something to check.");
//                 }
//               },
//               child: Container(
//                 height: 55,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   gradient: LinearGradient(
//                     colors: [AppColors.yellow, AppColors.pink, AppColors.sky],
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   spacing: 5,
//                   children: [
//                     Text(
//                       "Check with AI".tr,
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     Image.asset(
//                       'assets/icons/ai_icon.png',
//                       width: 24.w,
//                       height: 24.h,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }