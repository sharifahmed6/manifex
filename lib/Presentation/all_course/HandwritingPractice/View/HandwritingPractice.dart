import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_toggle_tabs.dart';
import '../../../Share/scafold_background.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import '../../interactive_reading/widget/interactive_border_color_gradient.dart';
import 'package:get/get.dart';

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
            CustomBackButton(text: 'Handwriting Practice'),
            SizedBox(height: 18.h),

            InteractiveBorderColor(
                child: GradientToggleTabs()
            ),
            SizedBox(height: 18.h),
            Expanded(
              child: Obx(() {
                return IndexedStack(
                  index: controller.selectedIndex.value,
                  children: [
                    LetterTracing(letter: 'A',)
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}


class LetterTracing extends StatefulWidget {
  final String letter; // single letter
  const LetterTracing({required this.letter, super.key});

  @override
  State<LetterTracing> createState() => _LetterTracingState();
}

class _LetterTracingState extends State<LetterTracing> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1️⃣ Background letter
            CustomPaint(
              size: Size(200, 200),
              painter: LetterPainter(widget.letter),
            ),

            // 2️⃣ Gesture drawing
            Positioned(
              top: -170,
              child: GestureDetector(
                onPanUpdate: (details) {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  setState(() {
                    points.add(box.globalToLocal(details.globalPosition));
                  });
                },
                onPanEnd: (_) => points.add(null),
                child: CustomPaint(
                  size: Size(300, 300),
                  painter: DrawingPainter(points),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Paint the letter as a guide
class LetterPainter extends CustomPainter {
  final String letter;
  LetterPainter(this.letter);

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.grey.withOpacity(0.3),
      fontSize: 200,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(text: letter, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final offset = Offset((size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Paint the user’s strokes
class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
