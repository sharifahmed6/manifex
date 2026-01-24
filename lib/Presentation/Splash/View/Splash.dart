import 'package:flutter/material.dart';
import 'package:manifex/App/assets_path.dart';
import '../../Share/manifex_logo.dart';
import '../../Share/scafold_background.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Controller/Controller.dart';

class splash extends StatelessWidget {
  splash({super.key});
  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: double.infinity, height: 0.1.sh,),
              Image.asset(assets_path.logo, width: 62, height: 62),
              logo_manifex(),
              Text(
                "Welcome to MANIFEX! Let’s start your language learning journey today"
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              SizedBox(height: 20),
              Obx(() {
                final r = controller.radius.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.bounceOut,
                  width: r * 2,
                  height: r * 2,
                  child: CircleAvatar(
                    radius: r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(assets_path.splash_image),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
