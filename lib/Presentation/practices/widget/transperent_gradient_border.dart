import 'package:flutter/material.dart';

class TransparentGradientBorder extends StatelessWidget {
  final double strokeWidth;
  final double radius;
  final Widget child;

  const TransparentGradientBorder({
    super.key,
    required this.child,
    this.strokeWidth = 2,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TransparentGradientBorderPainter(
        strokeWidth: strokeWidth,
        radius: radius,
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

  _TransparentGradientBorderPainter({
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = LinearGradient(
        colors: [const Color(0xffFFFFFF),Color(0xffFFFFFF).withAlpha((2.56 * 16).toInt())],
      ).createShader(rect);

    final rRect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(radius),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
