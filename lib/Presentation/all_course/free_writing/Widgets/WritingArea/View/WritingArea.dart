import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import '../../../../../../Core/responsive.dart';
import '../Controller/Controller.dart';

class WritingArea extends StatelessWidget {
  final String word;
  final bool isCursive;
  final bool showWatermark;
  final bool isTaskTwo;
  
  WritingArea({
    super.key, 
    required this.word, 
    this.isCursive = false, 
    this.showWatermark = true,
    this.isTaskTwo = false,
  });

  final WritingAreaController controller = Get.find<WritingAreaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (showWatermark)
                        Text(
                          word,
                          textAlign: TextAlign.center,
                          style: isCursive
                              ? GoogleFonts.dancingScript(
                                  fontSize: ScreenResponsive.responsiveFont(
                                    context,
                                    150,
                                  ),
                                  height: 1,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.withOpacity(isTaskTwo ? 0.4 : 0.1),
                                )
                              : GoogleFonts.poppins(
                                  fontSize: ScreenResponsive.responsiveFont(
                                    context,
                                    150,
                                  ),
                                  height: 1,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey.withOpacity(isTaskTwo ? 0.4 : 0.1),
                                ),
                        ),
                      Signature(
                        controller: controller.signatureController,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.grey,
                      size: 28,
                    ),
                    onPressed: controller.clearCanvas,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
