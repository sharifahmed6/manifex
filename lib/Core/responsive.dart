import 'package:flutter/cupertino.dart';

class ScreenResponsive {
  /// Base design size (iPhone X)
  static const double baseWidth = 375;
  static const double baseHeight = 812;

  // -------- FONT --------
  static double responsiveFont(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / baseWidth;
    final value = size * scale;
    return value.clamp(size * 0.9, size * 1.3);
  }

  // -------- WIDTH --------
  static double w(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / baseWidth;
    final value = size * scale;
    return value.clamp(size * 0.9, size * 1.4);
  }

  // -------- HEIGHT --------
  static double h(BuildContext context, double size) {
    final height = MediaQuery.of(context).size.height;
    final scale = height / baseHeight;
    final value = size * scale;
    return value.clamp(size * 0.9, size * 1.4);
  }

  // -------- RADIUS --------
  static double r(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / baseWidth;
    final value = size * scale;
    return value.clamp(size * 0.85, size * 1.3);
  }

  // -------- ICON SIZE --------
  static double icon(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / baseWidth;
    final value = size * scale;
    return value.clamp(size * 0.9, size * 1.4);
  }

  // -------- PADDING --------
  static EdgeInsets padding(BuildContext context, double size) {
    final v = w(context, size);
    return EdgeInsets.all(v);
  }

  static EdgeInsets symmetric(BuildContext context,
      {double h = 0, double v = 0}) {
    return EdgeInsets.symmetric(
      horizontal: w(context, h),
      vertical: ScreenResponsive.h(context, v),
    );
  }
}
