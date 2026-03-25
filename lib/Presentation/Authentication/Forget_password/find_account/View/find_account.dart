import 'package:flutter/material.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:get/get.dart';
import '../../../../../App/assets_path.dart';
import '../../../../../Core/responsive.dart';
import '../../../../Share/manifex_logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Controller/Controller.dart';

class find_account extends StatelessWidget {
  find_account({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  final controller = Get.find<find_account_controller>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsPath.logo, width: 62, height: 62),
            logo_manifex(),
            Text(
              "Forgot Password?"
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context,22),
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Enter your registered email. We'll send you an OTP to reset your password."
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenResponsive.responsiveFont(context,16),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email Address".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context,14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email here.';
                } else if (GetUtils.isEmail(value) == false) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "Enter your email".tr),
            ),
            const SizedBox(height: 15),
            ButtonGradient(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  controller.find_account(email.text);
                }
              },
              text: "Send OTP",
            )
          ],
        ),
      ),
    ));
  }
}
