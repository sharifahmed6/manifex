import 'package:dotted_border/dotted_border.dart';
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
import '../controller/task_three_controller.dart';

class InteractiveTaskThreeScreen extends StatelessWidget {
  InteractiveTaskThreeScreen({super.key});

  final c = Get.put(TaskThreeController());
  LinearGradient gradientByKey(String key) {
    switch (key) {
      case 'apple':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffFFD6B7), Color(0xffE07C2F)],
        );
      case 'dog':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffFFA6C8), Color(0xffB920ED)],
        );
      default: // sun
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffB2DEFF), Color(0xff3BA3F2)],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (c.words.isEmpty) {
      c.loadFromApi(const [
        ApiPair(
          word: "APPLE",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbqqx475Jl4uzxMCaIjwrOE6bqmguZJpXgyA&s",
          answerKey: "apple",
        ),
        ApiPair(
          word: "DOG",
          image:
              "https://file.aiquickdraw.com/imgcompressed/img/compressed_aeaae7ca35b46daf50bb77732a392385.webp",
          answerKey: "dog",
        ),
        ApiPair(
          word: "SUN",
          image:
              "https://static.vecteezy.com/system/resources/thumbnails/044/631/634/small/a-half-sun-is-setting-downwards-icon-sunset-concept-for-graphic-design-logo-web-site-social-media-mobile-app-ui-illustration-png.png",
          answerKey: "sun",
        ),
      ]);
    }
    final screenHeight = MediaQuery.of(context).size.height;
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(text: 'Task 3 '),
              SizedBox(height: 16.h),
              GradientTitle(
                normalText: 'Phoneme ',
                gradientText: 'Flashcards',
                fontSize: 20,
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: 'Drag words to their matching pictures',
                color: Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                return TransparentGradientBorder(
                  strokeWidth: 0.5,
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff111217).withAlpha(30),
                          Color(0xffCFDBFF).withAlpha(20),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(text: 'Words',fontSize: 18,fontWeight: FontWeight.w600,),
                                  SizedBox(height: 8.h,),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: c.words.length,
                                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                                    itemBuilder: (_, i) {
                                      final w = c.words[i];
                                      return Obx(() {
                                        final enabled = !c.isWordUsed(w.key);
                                        return _WordCard(
                                          text: w.text,
                                          enabled: enabled,
                                          wordKey: w.key,
                                          gradient: gradientByKey(w.key),
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(text: 'Picture',fontSize: 18,fontWeight: FontWeight.w600,),
                                  SizedBox(height: 8.h,),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: c.slots.length,
                                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                                    itemBuilder: (_, i) {
                                      final slot = c.slots[i];
                                      return Obx(() {
                                        final filled = c.isSlotFilled(slot.slotId);
                                        final state = c.slotState(slot.slotId);
                                        final placedKey = c.placedBySlotId[slot.slotId];

                                        return _DropSlot(
                                          slotId: slot.slotId,
                                          imageUrlOrAsset: slot.imageUrlOrAsset,
                                          label: "Drop word here",
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
                        SizedBox(height: 16.h,),
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
                                text: 'Nice! You found  of  sight words!',
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
                      color: const Color(0xffFFFFFF).withAlpha((2.56 * 90).toInt()),
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


