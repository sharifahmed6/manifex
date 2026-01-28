import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Share/button_gradient.dart';
import '../../Share/text_title_small.dart';
import '../model/task_view_model.dart';

class RewardVideoLockedCard extends StatelessWidget {
  final String thumbnailUrl;
  final String title;
  final String subtitle;

  final bool unlocked;
  final int remaining;
  final List<TaskViewModel> tasks;

  final VoidCallback onPlay;

  const RewardVideoLockedCard({
    super.key,
    required this.thumbnailUrl,
    required this.title,
    required this.subtitle,
    required this.unlocked,
    required this.remaining,
    required this.tasks,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final cardRadius = BorderRadius.circular(22.r);

    return Container(
      padding:  EdgeInsets.all(14.w),
      decoration: BoxDecoration(
          borderRadius: cardRadius,
          color: Colors.white,
          border: Border.all(color: Colors.white.withAlpha((2.56 * 10).toInt())),
          gradient: LinearGradient(
              colors: [
                Color(0xff111217).withAlpha(30),
                Color(0xffCFDBFF).withAlpha(30),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft
          )
      ),
      child: ClipRRect(
        borderRadius: cardRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.w),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(thumbnailUrl, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withAlpha(30),
                              Colors.black.withAlpha(50),
                            ],
                          ),
                        ),
                      ),

                      Center(
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withAlpha(50),
                            border: Border.all(color: Colors.white.withAlpha(50)),
                          ),
                          child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 34),
                        ),
                      ),

                      // ✅ LOCKED overlay
                      if (!unlocked)
                        Container(
                          color: Colors.black.withOpacity(0.35),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.white.withOpacity(0.18)),
                              ),
                              child: const Text(
                                "LOCKED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(text: title,fontSize: 20,fontWeight: FontWeight.w600,),
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(text: subtitle),
              ),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Color(0xffFFFFFF).withAlpha((2.56 * 17).toInt())
                    ),
                    child: Image.asset('assets/icons/reward_icon.png',width: 24.w,height: 24.h,),
                  ),
                  SizedBox(width: 10.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unlocked ? "Reward Unlocked" : "Reward Locked",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          unlocked
                              ? "You can watch the full video now"
                              : "Complete $remaining more tasks to unlock this video",
                          style: TextStyle(
                            color: Colors.white.withAlpha(204),
                            fontSize: 12,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ...tasks.map((t) => _TaskRowReadOnly(item: t)),
              SizedBox(height: 14.h),
              ButtonGradient(
                onTap: unlocked ? onPlay : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(unlocked ? Icons.play_circle_fill_rounded : Icons.lock_rounded,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "See Full Video",
                      style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _TaskRowReadOnly extends StatelessWidget {
  final TaskViewModel item;
  const _TaskRowReadOnly({required this.item});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2ED47A);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.done ? green : Colors.white.withOpacity(0.14),
            ),
            child: Icon(
              Icons.check_rounded,
              color: item.done ? Colors.white : Colors.white.withOpacity(0.40),
              size: 14,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomText(text: item.title),
          ),
        ],
      ),
    );
  }
}