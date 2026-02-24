
import 'dart:io';

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


          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
