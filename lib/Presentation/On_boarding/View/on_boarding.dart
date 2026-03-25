import 'package:flutter/material.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Core/MusicService.dart';
import 'package:manifex/Core/responsive.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../Core/AssetHelper.dart';
import '../../Share/intro_video_dialog.dart';
import '../../../App/assets_path.dart';
import '../../Share/manifex_logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Controller/Controller.dart';

class on_borading extends StatelessWidget {
  on_borading({super.key});
  final controller = Get.put(on_boarding_controller());

  @override
  Widget build(BuildContext context) {
    final pages = [
      _build_onBoarding1(controller: controller),
      _build_onBoarding2(controller: controller),
      _build_onBoarding3(controller: controller),
      _build_onBoarding4(controller: controller),
    ];

    return scaffold_background(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Obx(() => pages[controller.page_index.value]),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Obx(() {
              final music = MusicService();
              return IconButton(
                onPressed: () {
                  if (music.isPlaying) {
                    music.stop();
                  } else {
                    music.play(AssetsPath.homeMusic);
                  }
                },
                icon: Icon(
                  music.isPlaying ? Icons.volume_up_sharp : Icons.volume_off,
                  color: Colors.white70,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _build_onBoarding4 extends StatelessWidget {
  const _build_onBoarding4({super.key, required this.controller});

  final on_boarding_controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(AssetsPath.logo, width: 62, height: 62),
                logo_manifex(),
                Text(
                  "Welcome to MANIFEX! Let’s start your language learning journey today"
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenResponsive.responsiveFont(context, 12),
                  ),
                ),
                CircleAvatar(
                  radius: 110,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(AssetsPath.splashImage),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please select your language".tr,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.languages.length,
                  itemBuilder: (context, index) {
                    final lang = controller.languages[index];
                    return Obx(
                      () {
                        final isSelected =
                            controller.languageIndex.value == index;
                        return GestureDetector(
                          onTap: () => controller.changeLanguage(index),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    lang.flag,
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  lang.title,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      15,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "( ${lang.country.tr} )",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Spacer(),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        ButtonGradient(
          onTap: () {
            MusicService().stop();
            final videoPath = AssetHelper.getIntroVideoPath();
            Get.dialog(
              IntroVideoDialog(
                videoPath: videoPath,
                showSkip: true,
                onComplete: () => Get.offAllNamed(routes.login_screen),
              ),
              barrierDismissible: true,
            );
          },
          text: "Next".tr,
        ),
      ],
    );
  }
}

class _build_onBoarding3 extends StatelessWidget {
  const _build_onBoarding3({super.key, required this.controller});

  final on_boarding_controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsPath.logo, width: 62, height: 62),
              logo_manifex(),
              Text(
                "Track your growth".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 24),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "See how your mindset evolves over time with clear insights."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 12),
                ),
              ),
            ],
          ),
        ),
        ButtonGradient(
          onTap: () => controller.change_page(3),
          text: "Continue".tr,
        ),
      ],
    );
  }
}

class _build_onBoarding2 extends StatelessWidget {
  const _build_onBoarding2({super.key, required this.controller});

  final on_boarding_controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsPath.logo, width: 62, height: 62),
              logo_manifex(),
              Text(
                "Train your mindset".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 24),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Strengthen focus, discipline, and self-belief with consistency."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 12),
                ),
              ),
            ],
          ),
        ),
        ButtonGradient(onTap: () => controller.change_page(2), text: "Next".tr),
      ],
    );
  }
}

class _build_onBoarding1 extends StatelessWidget {
  const _build_onBoarding1({super.key, required this.controller});

  final on_boarding_controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsPath.logo, width: 62, height: 62),
              logo_manifex(),
              Text(
                "Set your intention".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 24),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Define what truly matters to you every single day.".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 12),
                ),
              ),
            ],
          ),
        ),
        ButtonGradient(onTap: () => controller.change_page(1), text: "Next".tr),
      ],
    );
  }
}
