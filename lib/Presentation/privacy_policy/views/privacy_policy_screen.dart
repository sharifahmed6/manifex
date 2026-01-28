import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';

import '../../Share/text_title_small.dart';
import '../../app_bar/views/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return scaffold_background(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Row(
                  spacing: 8.w,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                    ),
                    CustomText(
                      text: 'Privacy Policy',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('Last Updated: January 21, 2026'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('At MANIFEX, we respect and value your privacy. This Privacy Policy explains how we collect, use, and protect your personal information when you visit our website or use our services. By accessing MANIFEX, you agree to the practices described in this policy. If you do not agree, please discontinue using our services.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('When you create an account or use MANIFEX, we may collect certain personal information such as your name, email address, age group, language preference, subscription details, and any content you submit during practice activities such as writing exercises. For minors, we may also collect guardian or parent contact details for verification and progress tracking. In addition, we automatically collect certain technical information such as your browser type, device, IP address, and usage activity to ensure smooth functionality and improve the user experience.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('We use the information we collect to deliver and personalize our services, provide AI-powered feedback, process subscription payments securely through Stripe, track progress and generate analytics, send user updates or notifications, and improve MANIFEX by analyzing learner behaviors and preferences. Your personal data is used solely for the purpose of operating and enhancing the platform. We never sell your data to third parties.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('MANIFEX uses trusted third-party tools and services, such as Stripe for payment processing. Stripe collects and processes payment information on our behalf, and we do not store your full payment card details on our servers. Integrations with third-party providers are carefully selected, and we require them to follow strict security and privacy practices.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('We take the security of your information seriously. All data is protected using industry-standard encryption and secure storage practices. Access to personal data is restricted to authorized team members only, and we routinely monitor and update our systems to prevent unauthorized access, loss, misuse, or disclosure. However, no system can ever be 100% secure, and we cannot guarantee absolute protection of your information.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('If you are a child or minor, guardian or parent consent may be required to create an account and access certain features. Parent dashboards and notifications may be used to update guardians about a child’s learning progress.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('You have certain rights regarding your personal information. At any time, you may access your account, update or correct your details, or request account deletion. If you cancel your subscription or deactivate your account, some data may remain in backup storage or logs but will not be used further. To exercise these rights, please contact us at the provided email address.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('Our services are not designed to collect sensitive personal data such as racial or ethnic origin, political opinions, religious beliefs, or health-related details. Please do not provide this information when using our platform.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('We may update this Privacy Policy from time to time to reflect new features, technologies, or legal requirements. If there are significant changes, we will notify you via email or through the platform. By continuing to use MANIFEX after those updates, you agree to the revised Privacy Policy.'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('This Privacy Policy is governed by the laws of [Insert Country/Region]. Any disputes will be resolved in the courts of [Insert Location].'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('If you have any questions, concerns, or complaints about how we handle your personal data, please reach out to us at:\nEmail: [support@manifex.org]\nAddress: [Insert Business Address]'),
                SizedBox(height: screenHeight * 0.02),
                _textParagraph('By using MANIFEX, you acknowledge that you have read, understood, and agreed to this Privacy Policy.'),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        )
    );
  }
  CustomText _textParagraph(String text) {
    return CustomText(
      text: text,
      color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
      fontWeight: FontWeight.w300,
      textAlign: TextAlign.start,
    );
  }
}
