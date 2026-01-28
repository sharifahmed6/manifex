import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientBorderAvatar extends StatelessWidget {
  final double size;
  final double borderWidth;
  final ImageProvider image;

  const GradientBorderAvatar({
    super.key,
    required this.image,
    this.size = 80,
    this.borderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    final double s = size.w;
    final double bw = borderWidth.w;

    return Container(
      width: s,
      height: s,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 22.86,
            spreadRadius: 0,
            offset: Offset(0, 6.53),
            color: Color(0xff9894CF).withAlpha((2.56 * 45).toInt()),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(bw),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xffFFBC6F),
              Color(0xffF176B7),
              Color(0xff3797CD),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF050816),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1,
            ),
          ),
          child: ClipOval(
            child: Image(
              image: image,
              width: 64.w,
              height: 68.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
