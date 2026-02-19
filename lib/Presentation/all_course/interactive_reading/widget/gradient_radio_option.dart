import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientRadioOption extends StatelessWidget {
  const GradientRadioOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.size = 20,
    this.strokeWidth = 4,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            SizedBox(
              width: size.w,
              height: size.w,
              child: CustomPaint(
                painter: _GradientRadioPainter(
                  isSelected: isSelected,
                  strokeWidth: strokeWidth.w,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: Colors.white.withOpacity(isSelected ? 1 : 0.9),
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientRadioPainter extends CustomPainter {
  _GradientRadioPainter({required this.isSelected, required this.strokeWidth});

  final bool isSelected;
  final double strokeWidth;

  static const _gradient = LinearGradient(
    colors: [Color(0xFFFFBC6F), Color(0xFFF176B7), Color(0xFF3797CD)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    if (isSelected) {
      paint.shader = _gradient.createShader(rect);
      canvas.drawCircle(center, radius, paint);
    } else {
      paint.shader = null;
      paint.color = Colors.white.withOpacity(0.55);
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GradientRadioPainter oldDelegate) {
    return oldDelegate.isSelected != isSelected ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
