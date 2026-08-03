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
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (showWatermark)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              word,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              softWrap: false,
                              style: isCursive
                                  ? GoogleFonts.dancingScript(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        180,
                                      ),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.withOpacity(isTaskTwo ? 0.3 : 0.15),
                                    )
                                  : GoogleFonts.poppins(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        180,
                                      ),
                                      fontWeight: FontWeight.w200,
                                      color: Colors.grey.withOpacity(isTaskTwo ? 0.3 : 0.15),
                                    ),
                            ),
                          ),
                        ),
                      Signature(
                        controller: controller.signatureController,
                        backgroundColor: Colors.transparent,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white54,
                    size: 28,
                  ),
                  onPressed: controller.clearCanvas,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
