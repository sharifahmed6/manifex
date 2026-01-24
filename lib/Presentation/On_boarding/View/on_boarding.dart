import 'package:flutter/material.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../App/assets_path.dart';
import '../../Share/manifex_logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Controller/Controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class on_borading extends StatelessWidget {
  on_borading({super.key});
  final controller = Get.find<on_boarding_controller>();

  @override
  Widget build(BuildContext context) {

    final pages = [
      _build_onBoarding1(controller: controller),
      _build_onBoarding2(controller: controller),
      _build_onBoarding3(controller: controller),
      _build_onBoarding4(controller: controller),
    ];

    return scaffold_background(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Obx(() => pages[controller.page_index.value])
    ));
  }
}

//  _build_onBoarding4(controller: controller),

class _build_onBoarding4 extends StatelessWidget {
  const _build_onBoarding4({
    super.key,
    required this.controller,
  });

  final on_boarding_controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(assets_path.logo, width: 62, height: 62),
              logo_manifex(),
              Text(
                "Welcome to MANIFEX! Let’s start your language learning journey today"
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              CircleAvatar(
                radius: 110,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(assets_path.splash_image),
              ),
              const SizedBox(height: 5),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Please select your language".tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),)),
              Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: "https://img.freepik.com/premium-vector/flag-united-states-flag-nation_979270-2661.jpg?semt=ais_hybrid&w=740&q=80",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                            child: CircularProgressIndicator.adaptive()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("English", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),),
                  const SizedBox(width: 5),
                  Text("(United Kingdom)"),
                  Spacer(),
                  Icon(Icons.check, color: Colors.white, size: 20,)
                ],
              ),
              Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Flag_of_Poland.svg/1280px-Flag_of_Poland.svg.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                            child: CircularProgressIndicator.adaptive()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Polish", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),),
                  const SizedBox(width: 5),
                  Text("(Poland)")

                ],
              ),
            ],
          ),
        ),
        ButtonGradient(
          onTap: () => Get.toNamed(routes.login_screen),
          text: "Next".tr,
        )
      ],
    );
  }
}

// _build_onBoarding3(controller: controller)
class _build_onBoarding3 extends StatelessWidget {
  const _build_onBoarding3({
    super.key,
    required this.controller,
  });

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
              Image.asset(assets_path.logo, width: 62, height: 62),
              logo_manifex(),
              Text("Track your growth".tr, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),),
              Text(
                "See how your mindset evolves over time with clear insights."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            ],
          ),
        ),
        ButtonGradient(
          onTap: () => controller.change_page(3),
          text: "Continue".tr,
        )
      ],
    );
  }
}

// _build_onBoarding2(controller: controller)
class _build_onBoarding2 extends StatelessWidget {
  const _build_onBoarding2({
    super.key,
    required this.controller,
  });

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
              Image.asset(assets_path.logo, width: 62, height: 62),
              logo_manifex(),
              Text("Train your mindset".tr, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),),
              Text(
                "Strengthen focus, discipline, and self-belief with consistency."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            ],
          ),
        ),
        ButtonGradient(
          onTap: () => controller.change_page(2),
          text: "Next".tr,
        )
      ],
    );
  }
}

// _build_onBoarding1(controller: controller),
class _build_onBoarding1 extends StatelessWidget {
  const _build_onBoarding1({
    super.key,
    required this.controller,
  });

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
              Image.asset(assets_path.logo, width: 62, height: 62),
              logo_manifex(),
              Text("Set your intention".tr, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),),
              Text(
                "Define what truly matters to you every single day."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            ],
          ),
        ),
        ButtonGradient(
          onTap: () => controller.change_page(1),
          text: "Next".tr,
        )
      ],
    );
  }
}
