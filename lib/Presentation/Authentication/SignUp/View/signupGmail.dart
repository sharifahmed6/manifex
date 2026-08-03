import 'package:flutter/material.dart';
import 'package:manifex/Presentation/Authentication/SignUp/View/signupVerification.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../App/assets_path.dart';
import '../../../../App/routes.dart';
import '../../../../Core/responsive.dart';
import '../../../../Core/snakbar.dart';
import '../../../Share/button_gradient.dart';
import '../../../Share/manifex_logo.dart';
import '../Controller/Controller.dart';

class signupGmail extends StatelessWidget {
  signupGmail({super.key});
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<signup_controller>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
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
                radius: 80,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(AssetsPath.splashImage),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email Address".tr,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address'.tr;
                  } else if (GetUtils.isEmail(value) == false) {
                    return 'Please enter a valid email address'.tr;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(hintText: "Enter your email".tr),
              ),
              const SizedBox(height: 10),
              ButtonGradient(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    controller.emailAddress.value = emailController.text.trim();
                    Get.toNamed(routes.signup_screen);
                  }
                },
                text: "Continue".tr,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
