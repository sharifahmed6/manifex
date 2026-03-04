import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

import '../../Share/text_title_small.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    text: 'About Us'.tr,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              _gradientTitle(
                normalText: 'We Created MANIFEX with \n'.tr,
                gradientText: 'your language'.tr,
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomText(
                text:
                    'Our platform is designed to make practicing reading, writing, and speaking both effective and engaging. We draw on proven scientific research to create activities that strengthen the brain, build confidence, and support lifelong learning.'
                        .tr,
                fontSize: 16,
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: screenHeight * 0.02),
              _bulletPointCard(
                imagePath: 'assets/icons/real_time_analytics.png',
                title: 'Real-Time Analytics'.tr,
                subTitle:
                    'Built with cognitive science principles and tested with dyslexia specialists'
                        .tr,
              ),
              SizedBox(height: screenHeight * 0.02),
              _bulletPointCard(
                imagePath: 'assets/icons/advanced_ai_technology.png',
                title: 'Advanced AI Technology'.tr,
                subTitle:
                    'Machine learning adapts to individual learning patterns and preferences'
                        .tr,
              ),
              SizedBox(height: screenHeight * 0.02),
              _bulletPointCard(
                imagePath: 'assets/icons/book.png',
                title: 'Passion-Driven Learning'.tr,
                subTitle:
                    'Connect education with personal interests for maximum engagement'
                        .tr,
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _progressCard(
                    count: '100k+',
                    smallTitle: '100,000+ Learners'.tr,
                  ),
                  _progressCard(count: '98%', smallTitle: 'Positive Rating'.tr),
                  _progressCard(count: '24/7', smallTitle: 'AI Support'.tr),
                ],
              ),
              SizedBox(height: screenHeight * 0.08),
              _gradientTitle(
                normalText: 'At the Core of Our Approach are'.tr,
                gradientText: '4 Key Foundations'.tr,
              ),
              SizedBox(height: screenHeight * 0.03),
              _foundationCard(
                title: '1. Neuroplasticity'.tr,
                subTitle:
                    'The brain has an incredible ability to reorganize itself by forming new neural connections throughout life. This process not only supports learning and problem-solving but also helps individuals adapt to new challenges. Our activities are designed to activate neuroplasticity, making practice more impactful over time.'
                        .tr,
              ),
              SizedBox(height: screenHeight * 0.03),
              _foundationCard(
                title: '2. Rhythmic Therapy'.tr,
                subTitle:
                    'Humans are naturally responsive to rhythm. By using rhythmic and repetitive patterns, we help regulate the brain and nervous system. Here, we use music to rhythmically influence the reshaping of neurons and their plasticity by creating new neuronic pathways when working on our activities.This fortifies retention and facilitates the application of newly learned behaviors when using cognitive processing. This approach can reduce stress, improve focus, and create a natural flow in reading, writing, and speaking.'
                        .tr,
              ),
              SizedBox(height: screenHeight * 0.03),
              _foundationCard(
                title: '3. Dysgraphia Support'.tr,
                subTitle:
                    'Dysgraphia is a neurological condition that affects writing. Our tools offer structured practice to strengthen handwriting, written expression, and the motor skills that support the writing process.'
                        .tr,
              ),
              SizedBox(height: screenHeight * 0.03),
              _foundationCard(
                title: '4. Dyslexia Support'.tr,
                subTitle:
                    'Dyslexia, a neurobiological learning difference, can make reading, writing, and spelling difficult. We provide engaging activities that build fluency, comprehension, and language skills—helping learners overcome barriers with confidence.'
                        .tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _foundationCard({String? title, String? subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        CustomText(
          text: title ?? '',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.start,
        ),
        CustomText(
          text: subTitle ?? '',
          fontSize: 16,
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _progressCard({String? count, String? smallTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: count ?? '',
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        CustomText(
          text: smallTitle ?? '',
          color: Color(0xffFFFFFF).withAlpha((2.56 * 80).toInt()),
        ),
      ],
    );
  }

  Widget _bulletPointCard({
    String? imagePath,
    String? title,
    String? subTitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.w,
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundColor: Color(0xffFFFFFF).withAlpha((2.56 * 17).toInt()),
          child: Image.asset(imagePath ?? '', width: 25.w, height: 25.h),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              CustomText(
                text: title ?? '',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text: subTitle ?? '',
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color(0xffFFFFFF).withAlpha((2.56 * 80).toInt()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _gradientTitle({String? normalText, String? gradientText}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
        children: [
          TextSpan(
            text: normalText ?? '',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xffFFFFFF),
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFFFBC6F), // pink
                    Color(0xFFF176B7), // orange
                    Color(0xFF3797CD), // blue
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: Text(
                gradientText ?? '',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
