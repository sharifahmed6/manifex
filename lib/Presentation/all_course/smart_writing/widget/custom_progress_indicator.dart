import 'dart:math' as math;
import 'package:flutter/material.dart';

class GradientScoreRing extends StatelessWidget {
  final int score;
  final int total;
  final double size;
  final double stroke;

  const GradientScoreRing({
    super.key,
    required this.score,
    required this.total,
    this.size = 180,
    this.stroke = 14,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (total == 0) ? 0.0 : (score / total).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          progress: progress,
          stroke: stroke,
        ),
        child: Center(
          child: Text(
            '$score/$total',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final double stroke;

  _RingPainter({
    required this.progress,
    required this.stroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) / 2) - stroke / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..color = const Color(0xffFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final gradient = SweepGradient(
      colors: const [
        Color(0xff3797CD),
        Color(0xffF176B7),
        Color(0xffFFBC6F),
        Color(0xffF176B7),
        Color(0xff3797CD),
      ],
      transform: const GradientRotation(-math.pi / 2),
    );

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    final startAngle = -math.pi / 2;

    const gapRadians = 0.22;
    final sweepAngle = (2 * math.pi * progress) - (progress > 0 ? gapRadians : 0);

    if (sweepAngle > 0) {
      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.stroke != stroke;
  }
}
