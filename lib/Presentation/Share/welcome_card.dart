import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key, this.describe, this.name});
  final String? describe;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final titleSize = isLandscape ? 24.sp : 24.sp;
    final bodySize = isLandscape ? 16.sp : 16.sp;

    final topPad = isLandscape ? 100.h : 40.h;
    final bottomPad = isLandscape ? 10.h : 24.h;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/welcome_shape.svg',
              fit: BoxFit.fill,
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(24.w, topPad, 24.w, bottomPad),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  fontSize: titleSize,
                  name: name ?? '',
                ),
                SizedBox(height: 6.h),

                CustomText(
                  text: describe ?? '',
                  fontSize: bodySize,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class GradientText extends StatelessWidget {
  final double fontSize;
  final String name;
  final String welcomeText;

  const GradientText({
    super.key,
    required this.fontSize,
    this.name = "Afsar",
    this.welcomeText = "Welcome Back!",
  });

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      colors: [Color(0xFFFFBC6F), Color(0xFFF176B7), Color(0xFF3797CD)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final shader = gradient.createShader(
          Rect.fromLTWH(0, 0, constraints.maxWidth, 0),
        );

        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Hi $name! ",
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  foreground: Paint()..shader = shader,
                ),
              ),
              TextSpan(
                text: welcomeText,
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffFFFFFF),
                ),
              ),
            ],
          ),
          softWrap: true,
        );
      },
    );
  }
}
