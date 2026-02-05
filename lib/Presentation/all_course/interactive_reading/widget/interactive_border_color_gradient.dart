import 'package:flutter/material.dart';

class InteractiveBorderColor extends StatelessWidget {
  final double strokeWidth;
  final double radius;
  final Widget child;

  const InteractiveBorderColor({
    super.key,
    required this.child,
    this.strokeWidth = 0.5,
    this.radius = 8,
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
        colors: [const Color(0xff21B5FF),const Color(0xff21B5FF )],
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
