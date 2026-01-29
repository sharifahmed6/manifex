import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../all_course/practices/controller/toggle_tab_controller.dart';

class GradientToggleTabs extends StatelessWidget {
   GradientToggleTabs({super.key});
  final controller = Get.find<ToggleTabController>();
  @override
  Widget build(BuildContext context) {
    final radius = 14.r;
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: LayoutBuilder(
        builder: (context, box) {
          final w = box.maxWidth;
          return Obx(() {
            final selected = controller.selectedIndex.value;

            return Stack(
              children: [
                // Selected gradient pill
                AnimatedAlign(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  alignment: selected == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    width: (w - 12) / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((radius - 4).clamp(0, 100)),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFFFBC6F),
                          Color(0xFFF176B7),
                          Color(0xFF3797CD),
                        ],
                      ),
                    ),
                  ),
                ),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: _TabBtn(
                        text: "Practices",
                        isSelected: selected == 0,
                        onTap: () => controller.changeTab(0),
                      ),
                    ),
                    Expanded(
                      child: _TabBtn(
                        text: "Progress",
                        isSelected: selected == 1,
                        onTap: () => controller.changeTab(1),
                      ),
                    ),
                  ],
                ),
              ],
            );
          });
        },
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabBtn({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}