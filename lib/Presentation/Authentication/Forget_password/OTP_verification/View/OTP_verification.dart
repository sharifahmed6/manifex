import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifex/Core/snakbar.dart';
import '../../../../../App/AppColors.dart';
import '../../../../../App/assets_path.dart';
import '../../../../../Core/responsive.dart';
import '../../../../Share/button_gradient.dart';
import '../../../../Share/manifex_logo.dart';
import '../../../../Share/scafold_background.dart';
import 'package:pinput/pinput.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../Controller/Controller.dart';

class OtpVerification extends StatelessWidget {
  String email;
  OtpVerification({super.key, required this.email});
  TextEditingController otp = TextEditingController();
  final controller = Get.find<OTP_verification_controller>();



  @override
  Widget build(BuildContext context) {
    return scaffold_background(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assets_path.logo, width: 62, height: 62),
          logo_manifex(),
          Text(
            "Verify OTP"
                .tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: ScreenResponsive.responsiveFont(context,22),
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Enter the 6-digit code sent to $email"
                .tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenResponsive.responsiveFont(context,16),
            ),
          ),
          SizedBox(height: 20.h),

          Pinput(
            controller: otp,
            length: 6,
            onChanged: (value) {},
            defaultPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: Theme.of(context).textTheme.displaySmall
                  ?.copyWith(
                color: Colors.white,
                fontSize: ScreenResponsive.responsiveFont(context,17),
                fontWeight: FontWeight.w400,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 7,
            children: [
              Text("Didn't get a code?".tr, style: TextStyle(fontSize: ScreenResponsive.responsiveFont(context,16), color: Colors.white),),
              Obx(
                    () => controller.isResendCode.value
                    ? GestureDetector(
                  onTap: (){
                    controller.isResendCode.value = false;
                    controller.resent_code();
                  },
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          AppColors.yellow,
                          AppColors.pink,
                          AppColors.sky
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // required for ShaderMask
                      ),
                    ),
                  ),
                )
                    : SlideCountdown(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context,16),
                      color: Colors.white
                  ),
                  duration: Duration(seconds: 90),
                  onDone: () {
                    controller.isResendCode.value = true;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          ButtonGradient(
            onTap: () {
              if(otp.text.length != 6){
               AppSnackbar.show("Please enter a valid otp code");
              }else{
                controller.verify_otp(otp.text, email);
              }
            },
            text: "Verify OTP",
          )
        ],
      ),
    ));
  }
}
