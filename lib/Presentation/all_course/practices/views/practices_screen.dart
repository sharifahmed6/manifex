import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/App/routes.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import '../../../Share/text_title_small.dart';
import '../widget/transperent_gradient_border.dart';

class PracticesScreen extends StatelessWidget {
  const PracticesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 5, left: 16, right: 16, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Practices',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/images/book.png',
                title: 'Interactive Reading',
                subTitle:
                    'Poneme recognition an word games with visual cues designed for dyslexic learners',
                onTap: (){
                  Get.toNamed(routes.interactive_reading_screen);
                }
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/icons/smart_writing_icon.png',
                title: 'Smart Writing',
                subTitle:
                    'Write. Learn. Improve. AI checks your grammar, structure, and style instantly.',
                onTap: (){
                  Get.toNamed(routes.smart_writing_screen);
                }
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/icons/native_speaking_icon.png',
                title: 'Native Speaking',
                subTitle:
                    'Advanced Al pronunciation coaching with real-time feedback and accent training',
                onTap: (){
                  Get.toNamed(routes.native_speaking_skill_screen);
                }
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/icons/reward_icon.png',
                title: 'Reward System',
                subTitle:
                    'oneme recognition an word games with visual cues designed for dyslexic learners',
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/icons/presentation_icon.png',
                title: 'Presentation Practice',
                subTitle:
                    'Practice English made for adults. Improve speaking, listening, and vocabulary with easy, real-life lessons you can use every day.',
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/icons/person.png',
                title: 'English for Adult Practice',
                subTitle:
                    'Improve your English with real-life practice made especially for adults. Build confidence in speaking, listening, and vocabulary.',
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/icons/person.png',
                title: 'Handwriting Practice',
                subTitle: 'Learn to write letters the fun way',
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _practicesCard({String? imagePath, String? title, String? subTitle,VoidCallback? onTap}) {
    return TransparentGradientBorder(
      strokeWidth: 0.5,
      radius: 16.r,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: [
              Color(0xff111217).withAlpha(50),
              Color(0xffCFDBFF).withAlpha(30),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white.withAlpha((2.56 * 17).toInt()),
              ),
              child: _responsiveIcon(imagePath),
            ),
            CustomText(
              text: title ?? '',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: subTitle ?? '',
              fontSize: 16,
              color: AppColors.white.withAlpha((2.56 * 90).toInt()),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16.h),
            ButtonGradient(text: 'Start Reading',onTap: onTap),
          ],
        ),
      ),
    );
  }

  Widget _responsiveIcon(String? imagePath) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortest = MediaQuery.of(context).size.shortestSide;

        // icon size logic (perfect for landscape)
        final iconSize = (shortest * 0.06).clamp(24.0, 36.0);

        return Image.asset(
          imagePath ?? '',
          width: iconSize,
          height: iconSize,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
