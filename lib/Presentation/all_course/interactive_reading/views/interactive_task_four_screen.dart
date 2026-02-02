import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/text_title_small.dart';
import '../../../progress/widget/achievment_gradient_border.dart';
import '../../practices/widget/transperent_gradient_border.dart';
import '../controller/task_four_controller.dart';
import '../widget/gradient_radio_option.dart';

class InteractiveTaskFourScreen extends StatelessWidget {
  InteractiveTaskFourScreen({super.key});
  final controller = Get.find<TaskFourController>();

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(text: 'Task 4 '),
              SizedBox(height: 16.h),
          
              GradientTitle(
                normalText: 'Reading ',
                gradientText: 'Quiz',
                fontSize: 20,
              ),
              SizedBox(height: 10.h),
          
              CustomText(
                text: 'Read the story and answer the questions',
                color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                final data = controller.readingData.first;
                final title = (data["title"] ?? "") as String;
                final passages = (data["passages"] ?? []) as List;
                final imagePath = (data["image"] ?? "") as String;
                final questions = (data["questions"] ?? []) as List;

                return TransparentGradientBorder(
                  strokeWidth: 0.5,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff111217).withAlpha(30),
                          const Color(0xffCFDBFF).withAlpha(20),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        _StoryCard(
                          title: title,
                          passages: passages.map((e) => e.toString()).toList(),
                          imagePath: imagePath,
                        ),
                        SizedBox(height: 14.h),
                        ...List.generate(questions.length, (qIndex) {
                          final q = questions[qIndex] as Map<String, dynamic>;
                          final qNo = q["questionNo"].toString();
                          final qText = (q["question"] ?? "") as String;
                          final options =
                          (q["options"] ?? []) as List<dynamic>;

                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Obx(() {
                              final selected =
                              controller.selectedAnswers[qIndex];

                              return _QuestionCard(
                                questionNo: qNo,
                                question: qText,
                                options:
                                options.map((e) => e.toString()).toList(),
                                selectedIndex: selected,
                                onSelect: (optIndex) =>
                                    controller.selectOption(qIndex, optIndex),
                              );
                            }),
                          );
                        }),
                        SizedBox(height: 14.h),
                        AchievmentGradientBorder(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return const LinearGradient(
                                  colors: [
                                    Color(0xffFFBC6F),
                                    Color(0xffF176B7),
                                    Color(0xff3797CD),
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                );
                              },
                              child: CustomText(
                                text: 'Submit All Answers',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.title,
    required this.passages,
    required this.imagePath,
  });

  final String title;
  final List<String> passages;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xffFFFFFF).withAlpha((2.56 * 8).toInt()),
        border: Border.all(
          color: const Color(0xffFFFFFF).withAlpha((2.56 * 14).toInt()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title centered
          ShaderMask(shaderCallback: (bounds){
            return LinearGradient(colors: [
              Color(0xffFFBC6F),
              Color(0xffF176B7),
              Color(0xff3797CD),
            ]).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
          },child: Center(child: CustomText(text: title,fontSize: 24,fontWeight: FontWeight.w600,)),),
          SizedBox(height: 12.h),
          ...passages.map((p) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: CustomText(
                text: p,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
            );
          }),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.questionNo,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.onSelect,
  });

  final String questionNo;
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final void Function(int optionIndex) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xffFFFFFF).withAlpha((2.56 * 8).toInt()),
        border: Border.all(
          color: const Color(0xffFFFFFF).withAlpha((2.56 * 14).toInt()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Question $questionNo",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xffFFFFFF).withAlpha((2.56 * 95).toInt()),
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: question,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
          ),
          SizedBox(height: 12.h),
          ...List.generate(options.length, (i) {
            final isSelected = selectedIndex == i;

            return GradientRadioOption(
              text: options[i],
              isSelected: isSelected,
              onTap: () => onSelect(i),
            );
          }),
        ],
      ),
    );
  }
}
