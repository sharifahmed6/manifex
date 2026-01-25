import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/Presentation/home/view/home_screen.dart';
import 'package:manifex/Presentation/practices/views/practices_screen.dart';
import '../../progress/views/progress_screen.dart';
import '../controllers/bottom_navbar_controller.dart';

class BottomNavbarView extends GetView<BottomNavbarController> {
  BottomNavbarView({super.key});
  final List<Widget> screens = [
    HomeScreen(),
    PracticesScreen(),
    ProgressScreen(),
    const Text('Practice Screen'),
    const Text('Practice Screen'),
  ];

  final List<String> icons = [
    "assets/images/home_icon.svg",
    "assets/images/practice.svg",
    "assets/images/learning_progress.svg",
    "assets/images/choose_premium_plane_icon.svg",
    "assets/images/profile_icon.svg",
  ];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: LayoutBuilder(
        builder: (context,constraints) {
          final isWide = constraints.maxWidth > 500;
          return Padding(
            padding: EdgeInsets.all(14.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 15
                ),
                child: Container(
                  width: isWide ? 420.w : double.infinity,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: AppColors.white.withAlpha((2.56 * 12).toInt()),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(icons.length, (index) {
                        final isActive = controller.selectedIndex.value == index;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.changeIndex(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 52.w,
                              height: 52.h,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.white
                                    : AppColors.white.withAlpha((2.56 * 30).toInt()),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Center(
                                  child: SvgPicture.asset(
                                    icons[index],
                                    height: 24.h,
                                    width: 24.w,
                                    colorFilter: ColorFilter.mode(
                                      isActive ? Color(0xff141B34) : AppColors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
