import 'package:flutter/material.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../App/assets_path.dart';
import '../../../../Core/responsive.dart';
import '../../../Share/button_gradient.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Share/manifex_logo.dart';
import '../Controller/Controller.dart';

class login extends StatelessWidget {
  login({super.key});
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<login_controller>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context,12)),
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(assets_path.splash_image),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email".tr,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context,16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (GetUtils.isEmail(value) == false) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter your email".tr),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password".tr,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context,16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => TextFormField(
                    obscureText: controller.password.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your password".tr,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.password.value =
                              !controller.password.value;
                        },
                        child: Icon(
                          controller.password.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.isRemeber.value,
                        activeColor: AppColors.sky,
                        onChanged: (value) {
                          controller.isRemeber.value =
                              !controller.isRemeber.value;
                        },
                      ),
                    ),
                    Text("Remember me".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context,16)),),
                    const Spacer(),
                    TextButton(
                      onPressed: () => controller.route_forget_password(),
                      child: Text(
                        "Forgot password?".tr,
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(context , 16),
                          color: AppColors.sky,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ButtonGradient(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print("validated");
                    }
                  },
                  text: "Login".tr,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "New here? ",
                            style: TextStyle(
                              fontSize: ScreenResponsive.responsiveFont(context, 16),
                              color: Colors.white,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: GestureDetector(
                              onTap: () => Get.toNamed(routes.signup_screen),
                              child: Text(
                                "Create your account",
                                style: TextStyle(
                                  color: AppColors.sky,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenResponsive.responsiveFont(context, 16),
                                ),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: " to get started.",
                            style: TextStyle(
                              fontSize: ScreenResponsive.responsiveFont(context, 16),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
