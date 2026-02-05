import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientTitle extends StatelessWidget {
  final String normalText;
  final String gradientText;
  final double? fontSize;

  const GradientTitle({
    super.key,
    this.normalText = '',
    this.gradientText = '',
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final fs = (fontSize ?? 24).sp;

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fs,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
        children: [
          TextSpan(
            text: normalText,
            style: GoogleFonts.inter(
              fontSize: fs,
              fontWeight: FontWeight.w500,
              color: const Color(0xffFFFFFF),
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFFFBC6F),
                    Color(0xFFF176B7),
                    Color(0xFF3797CD),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: Text(
                gradientText,
                style: TextStyle(
                  fontSize: fs,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
