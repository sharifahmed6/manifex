import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import '../model/rewards_model.dart';

class RewardVideoLockedCard extends StatelessWidget {
  final String thumbnailUrl;
  final String title;
  final String subtitle;
  final String category;
  final int views;
  final bool unlocked;
  final int remaining;
  final List<RewardTaskItem> tasks;
  final VoidCallback onPlayToggle;
  final bool isPlaying;
  final bool isVideoInitialized;
  final String currentTime;
  final String totalTime;
  final ChewieController? chewieController;
  final VoidCallback? onSeeAll;
  final bool isMoreRewardsVisible;
  final String videoId;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final bool showFavoriteIcon;

  const RewardVideoLockedCard({
    super.key,
    required this.thumbnailUrl,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.views,
    required this.unlocked,
    required this.remaining,
    required this.tasks,
    required this.onPlayToggle,
    required this.isPlaying,
    required this.isVideoInitialized,
    required this.currentTime,
    required this.totalTime,
    this.chewieController,
    this.onSeeAll,
    this.isMoreRewardsVisible = false,
    required this.videoId,
    required this.isFavorite,
    required this.onFavoriteToggle,
    this.showFavoriteIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;
        final cardRadius = BorderRadius.circular(22.r);

        return Container(
          padding: EdgeInsets.all(isLandscape ? 12.w : 14.w),
          decoration: BoxDecoration(
            borderRadius: cardRadius,
            color: Colors.white,
            border: Border.all(
              color: Colors.white.withAlpha((2.56 * 10).toInt()),
            ),
            gradient: LinearGradient(
              colors: [
                const Color(0xff111217).withAlpha(30),
                const Color(0xffCFDBFF).withAlpha(30),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
          child: ClipRRect(
            borderRadius: cardRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16.w, sigmaY: 16.h),
              child: isLandscape
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildVideoSection()),
                        SizedBox(width: 16.w),
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: _buildInfoSection(),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildVideoSection(),
                        SizedBox(height: 12.h),
                        _buildInfoSection(),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (unlocked && isVideoInitialized && chewieController != null)
              Chewie(controller: chewieController!)
            else
              Image.network(thumbnailUrl, fit: BoxFit.cover),

            if (!unlocked)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: Colors.white.withOpacity(0.18)),
                      ),
                      child: Text(
                        "LOCKED".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            if (unlocked && isVideoInitialized)
              Stack(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: onPlayToggle,
                      child: Container(
                        width: 54.w,
                        height: 54.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(50),
                          border: Border.all(color: Colors.white.withAlpha(50)),
                        ),
                        child: Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 34.sp,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    right: 12.w,
                    child: GestureDetector(
                      onTap: () => chewieController?.enterFullScreen(),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.fullscreen_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 10.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "$currentTime / $totalTime",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (showFavoriteIcon)
              Positioned(
                top: 10.h,
                left: 12.w,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(text: title, fontSize: 20.sp, fontWeight: FontWeight.w600),
        SizedBox(height: 6.h),
        CustomText(text: subtitle, fontSize: 14.sp),
        if (category.isNotEmpty) ...[
          SizedBox(height: 4.h),
          CustomText(
            text: "${'Category: '.tr}$category",
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ],
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: const Color(0xffFFFFFF).withAlpha((2.56 * 17).toInt()),
              ),
              child: Image.asset(
                'assets/icons/reward_icon.png',
                width: 24.w,
                height: 24.h,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unlocked ? "Today's Session".tr : "Reward Locked".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    unlocked
                        ? "You can watch the full video now".tr
                        : "Complete the following activities".tr,
                    style: TextStyle(
                      color: Colors.white.withAlpha(204),
                      fontSize: 12.sp,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (tasks.isNotEmpty)
          ...tasks.map(
            (task) => _TaskRow(title: task.name.tr, done: task.completed),
          )
        else
          CustomText(
            text: "No tasks available".tr,
            fontSize: 14.sp,
            color: Colors.white70,
          ),
        SizedBox(height: 14.h),
        ButtonGradient(
          onTap: onSeeAll ?? (unlocked ? onPlayToggle : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isMoreRewardsVisible ? "Hide All Video".tr : "See All Video".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TaskRow extends StatelessWidget {
  final String title;
  final bool done;
  const _TaskRow({required this.title, required this.done});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2ED47A);

    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? green : Colors.white.withOpacity(0.14),
            ),
            child: Icon(Icons.check_rounded, color: Colors.white, size: 14.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomText(text: title, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
