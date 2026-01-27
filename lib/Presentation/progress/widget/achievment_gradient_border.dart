import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/progress_controller.dart';

class AchievmentGradientBorder extends StatelessWidget {
  final double strokeWidth;
  final double radius;
  final Widget child;
  final bool lock;

   AchievmentGradientBorder({
    super.key,
    required this.child,
    this.strokeWidth = 2,
    this.radius = 12,
     this.lock = true,
  });
  final controller = Get.find<ProgressController>();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TransparentGradientBorderPainter(
        strokeWidth: strokeWidth,
        radius: radius,
        lock: lock,
      ),
      child: Padding(
        padding: EdgeInsets.all(strokeWidth),
        child: child,
      ),
    );
  }
}
class _TransparentGradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double radius;
  final bool lock;

  _TransparentGradientBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.lock
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    if (lock) {
      paint.shader = const LinearGradient(
        colors: [
          Color(0xffFFBC6F),
          Color(0xffF176B7),
          Color(0xff3797CD),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    } else {
      paint.color = Color(0xffFFFFFF).withAlpha((2.56 * 12).toInt());
    }

    final rRect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(radius),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
