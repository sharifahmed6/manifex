import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import '../../../Share/custom_back_button.dart';
import '../../../Share/gradient_title.dart';
import '../../../Share/text_title_small.dart';
import '../../../progress/widget/achievment_gradient_border.dart';
import '../../practices/widget/transperent_gradient_border.dart';
import '../controller/interactive_reading_controller.dart';
import '../controller/task_three_controller.dart';

class InteractiveTaskThreeScreen extends StatelessWidget {
  InteractiveTaskThreeScreen({super.key});

  final c = Get.find<TaskThreeController>();
  final interactiveReading = Get.find<InteractiveReadingController>();
  LinearGradient gradientFromKey(String key) {
    final h = key.hashCode.abs() % 3;
    if (h == 0) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffFFD6B7), Color(0xffE07C2F)],
      );
    } else if (h == 1) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffFFA6C8), Color(0xffB920ED)],
      );
    }
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xffB2DEFF), Color(0xff3BA3F2)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(text: 'Task 3'.tr),
              SizedBox(height: 16.h),

              Obx(() {
                final title = c.sessionName.value.isEmpty
                    ? 'Phoneme Flashcards'.tr
                    : c.sessionName.value;
                return GradientTitle(
                  normalText: '',
                  gradientText: title,
                  fontSize: 20,
                );
              }),

              SizedBox(height: 16.h),
              CustomText(
                text: 'Drag words to their matching pictures'.tr,
                color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
              SizedBox(height: 16.h),

              Obx(() {
                if (c.isLoading.value) {
                  return const Center(child: CustomCircleProgressIndicator());
                }
                if (c.error.value.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Column(
                        children: [
                          Text(
                            c.error.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withAlpha(220),
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          GestureDetector(
                            onTap: c.loadFromServer,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                "Retry".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (c.words.isEmpty || c.slots.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Text(
                        "No data".tr,
                        style: TextStyle(
                          color: Colors.white.withAlpha(220),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                }

                return TransparentGradientBorder(
                  strokeWidth: 0.5,
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        Row(
                          children: [
                            /// LEFT: Words
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Words'.tr,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 8.h),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: c.words.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 12.h),
                                    itemBuilder: (_, i) {
                                      final w = c.words[i];
                                      return Obx(() {
                                        final enabled = !c.isWordUsed(w.key);
                                        return _WordCard(
                                          text: w.text,
                                          enabled: enabled,
                                          wordKey: w.key,
                                          gradient: gradientFromKey(w.key),
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 12.w),

                            /// RIGHT: Pictures
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Picture'.tr,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 8.h),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: c.slots.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 12.h),
                                    itemBuilder: (_, i) {
                                      final slot = c.slots[i];
                                      return Obx(() {
                                        final state = c.slotState(slot.slotId);

                                        return _DropSlot(
                                          slotId: slot.slotId,
                                          imageUrlOrAsset: slot.imageUrlOrAsset,
                                          label: "Drop word here".tr,
                                          state: state,
                                          canAccept: (wordKey) => c.canAccept(
                                            slotId: slot.slotId,
                                            wordKey: wordKey,
                                          ),
                                          onDrop: (wordKey) => c.drop(
                                            slotId: slot.slotId,
                                            wordKey: wordKey,
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        /// ✅ Bottom: Nice banner (only if allCorrect) + Finish button (if allFilled) + score
                        Obx(() {
                          final total = c.totalSlots;
                          final correct = c.correctCount.value;

                          final showNiceBanner = c.allCorrect;
                          final showFinish = c.allFilled;

                          return Column(
                            children: [
                              if (!showNiceBanner)
                                CustomText(
                                  text: "Correct: ".tr + "$correct/$total",
                                  fontSize: 18,
                                  color: const Color(
                                    0xffFFFFFF,
                                  ).withAlpha((2.56 * 80).toInt()),
                                  textAlign: TextAlign.center,
                                ),
                              SizedBox(height: 8.h),
                              if (showNiceBanner)
                                AchievmentGradientBorder(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 10.h,
                                    ),
                                    child: ShaderMask(
                                      shaderCallback: (bounds) {
                                        return const LinearGradient(
                                          colors: [
                                            Color(0xffFFBC6F),
                                            Color(0xffF176B7),
                                            Color(0xff3797CD),
                                          ],
                                        ).createShader(
                                          Rect.fromLTWH(
                                            0,
                                            0,
                                            bounds.width,
                                            bounds.height,
                                          ),
                                        );
                                      },
                                      child: CustomText(
                                        text:
                                            'Nice! You found '.tr +
                                            '$correct' +
                                            ' of '.tr +
                                            '$total' +
                                            ' sight words!'.tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),

                              if (showNiceBanner) SizedBox(height: 12.h),

                              if (showFinish)
                                ButtonGradient(
                                  onTap: () {
                                    c.finish();
                                    interactiveReading.t4Done.value = false;
                                    interactiveReading.t3SkillLock.value =
                                        false;
                                    interactiveReading.checkAllComplete();
                                  },
                                  text: 'Finish'.tr,
                                ),
                              SizedBox(height: 8.h),
                              ButtonGradient(
                                onTap: c.resetAll,
                                text: 'Reset'.tr,
                              ),
                              if (showFinish) SizedBox(height: 10.h),
                            ],
                          );
                        }),
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

class _WordCard extends StatelessWidget {
  const _WordCard({
    required this.text,
    required this.enabled,
    required this.wordKey,
    required this.gradient,
  });

  final String text;
  final bool enabled;
  final String wordKey;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: 171.w,
      height: 200.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: enabled ? gradient : null,
        color: enabled ? null : Colors.white.withAlpha(40),
      ),
      child: CustomText(text: text, fontSize: 20, fontWeight: FontWeight.w600),
    );

    if (!enabled) return card;

    return Draggable<String>(
      data: wordKey,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(width: 160.w, child: card),
      ),
      childWhenDragging: Opacity(opacity: 0.25, child: card),
      child: card,
    );
  }
}

class _DropSlot extends StatelessWidget {
  const _DropSlot({
    required this.slotId,
    required this.imageUrlOrAsset,
    required this.label,
    required this.state,
    required this.canAccept,
    required this.onDrop,
  });

  final String slotId;
  final String imageUrlOrAsset;
  final String label;
  final DropState state;

  final bool Function(String wordKey) canAccept;
  final void Function(String wordKey) onDrop;

  @override
  Widget build(BuildContext context) {
    Color borderColor() {
      switch (state) {
        case DropState.correct:
          return const Color(0xFF2EE59D);
        case DropState.wrong:
          return const Color(0xFFFF4D6D);
        case DropState.empty:
          return Colors.white.withAlpha((2.56 * 50).toInt());
      }
    }

    return DragTarget<String>(
      onWillAcceptWithDetails: (d) => canAccept(d.data),
      onAcceptWithDetails: (d) => onDrop(d.data),
      builder: (context, candidate, rejected) {
        final hovering = candidate.isNotEmpty;
        final cRadius = 16.r;
        final bColor = hovering ? Colors.white.withAlpha(150) : borderColor();

        return Column(
          children: [
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(cRadius),
                dashPattern: const [8, 4],
                strokeWidth: 1.6,
                color: bColor,
              ),
              child: Container(
                width: 171.w,
                height: 195.h,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cRadius),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xffCFDBFF).withAlpha(50),
                      const Color(0xff111217).withAlpha(40),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.transparent,
                      backgroundImage: (imageUrlOrAsset.startsWith('http'))
                          ? NetworkImage(imageUrlOrAsset)
                          : AssetImage(imageUrlOrAsset) as ImageProvider,
                    ),
                    SizedBox(height: 12.h),
                    CustomText(
                      text: label,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(
                        0xffFFFFFF,
                      ).withAlpha((2.56 * 90).toInt()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
