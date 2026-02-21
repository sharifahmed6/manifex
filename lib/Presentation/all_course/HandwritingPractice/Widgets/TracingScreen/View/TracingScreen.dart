
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import '../../../../../../App/AppColors.dart';
import '../../../../../../Core/responsive.dart';
import '../../../../../../Core/snakbar.dart';
import '../../../Controller/Controller.dart';
import '../Controller/Controller.dart';

class TracingScreen extends StatelessWidget {
  final String word;
  TracingScreen({super.key, required this.word});

  final TracingController controller = Get.put(TracingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ✏️ Tracing Area
          Expanded(
            child: Stack(
              children: [
                SizedBox.expand(),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Thin letter guide
                      Text(
                        word,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: ScreenResponsive.responsiveFont(context, 350),
                          height: 1,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      // Drawing layer
                      Signature(
                        controller: controller.signatureController,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),

                // Clear button
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey, size: 28),
                    onPressed: controller.clearCanvas,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ✅ Check with AI button
          GestureDetector(
            onTap: () async {
              String? pngPath = await controller.saveSignaturePng(controller: controller.signatureController, fileName: 'traced_word_$word', word: word);

              if (pngPath != null) {
                final HController = Get.find<HandwritingPracticeController>();
                word == 'F' ? HController.unLockTask(1) : word == 'L' ? HController.unLockTask(2) : word == 'R' ? HController.unLockTask(3) : word == 'Z' ? HController.unLockTask(4) :
                word == 'f' ? HController.unLockTask(5) : word == 'l' ? HController.unLockTask(6) : word == 'r' ? HController.unLockTask(7) : word == 'z' ? HController.unLockTask(8) :
                word == '9' ? HController.unLockTask(10) : null;
                print("PNG saved at: $pngPath");
                controller.submit(imagePath: pngPath!, word: word);

              } else {
                AppSnackbar.show("Please draw something to check.");
              }
            },
            child: Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [AppColors.yellow, AppColors.pink, AppColors.sky],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  Text(
                    "Check with AI".tr,
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

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
