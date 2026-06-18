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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(AssetsPath.logo, width: 62, height: 62),
                  const SizedBox(height: 10),
                  logo_manifex(),
                  const SizedBox(height: 10),
                  Text(
                    "Welcome to MANIFEX!\n Let’s start your language learning journey today"
                        .tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context, 12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Responsive Avatar
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double radius = constraints.maxWidth * 0.25;
                      if (radius > 100) radius = 100;
                      return CircleAvatar(
                        radius: radius,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(AssetsPath.splashImage),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email".tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text'.tr;
                      } else if (GetUtils.isEmail(value) == false) {
                        return 'Please enter a valid email address'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Enter your email".tr),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password".tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => TextFormField(
                      controller: passwordController,
                      obscureText: controller.password.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text'.tr;
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters'.tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your password".tr,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.password.value =
                                !controller.password.value;
                          },
                          icon: Icon(
                            controller.password.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Row with overflow handling
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: controller.isRemeber.value,
                                  activeColor: AppColors.sky,
                                  onChanged: (value) {
                                    controller.isRemeber.value =
                                        !controller.isRemeber.value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                "Remember me".tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: ScreenResponsive.responsiveFont(
                                    context,
                                    14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: TextButton(
                          onPressed: () => controller.route_forget_password(),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Forgot Password?".tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenResponsive.responsiveFont(
                                context,
                                14,
                              ),
                              color: AppColors.sky,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ButtonGradient(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.Login(
                          emailController.text,
                          passwordController.text,
                        );
                      }
                    },
                    text: "Login".tr,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "New here? ".tr,
                              style: TextStyle(
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  16,
                                ),
                                color: Colors.white,
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: GestureDetector(
                                onTap: () =>
                                    Get.toNamed(routes.signupGmail_screen),
                                child: Text(
                                  "Create your account".tr,
                                  style: TextStyle(
                                    color: AppColors.sky,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextSpan(
                              text: " to get started.".tr,
                              style: TextStyle(
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  16,
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
