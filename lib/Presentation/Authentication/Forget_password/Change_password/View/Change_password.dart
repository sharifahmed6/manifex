import 'package:flutter/material.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../../../../../App/assets_path.dart';
import '../../../../../Core/responsive.dart';
import '../../../../Share/button_gradient.dart';
import '../../../../Share/manifex_logo.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Controller/Controller.dart';

class resent_password extends StatelessWidget {
  String email;
  resent_password({super.key, required this.email});
  final controller = Get.find<reset_password_controller>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return scaffold_background(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assets_path.logo, width: 62, height: 62),
            logo_manifex(),
            Text(
              "Reset Your Password"
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context,22),
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Create a new password for your account."
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenResponsive.responsiveFont(context,16),
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "New Password".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context,14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Obx(() => TextFormField(
              obscureText: controller.password.value,
              controller: password,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password here.';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: "Enter your password".tr,
                  suffixIcon: GestureDetector(
                      onTap: (){
                        controller.password.value = !controller.password.value;
                      },
                      child: Icon(controller.password.value ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey,))
              ),
            ),),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm Password".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context,14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Obx(() => TextFormField(
              obscureText: controller.confirm_password.value,
              controller: confirm_password,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password here.';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters long.';
                } else if(password.text != confirm_password.text){
                  return 'Password does not match';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: "Enter your password".tr,
                  suffixIcon: GestureDetector(
                      onTap: (){
                        controller.confirm_password.value = !controller.confirm_password.value;
                      },
                      child: Icon(controller.confirm_password.value ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey,))
              ),
            ),),
            const SizedBox(height: 10),
            ButtonGradient(
              onTap: () {

              },
              text: "Reset Password".tr,
            )
          ],
        ),
      ),
    ));
  }
}
