import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/unlock_rewards/controller/unlock_rewards_controller.dart';
import 'package:video_player/video_player.dart';
import '../../Share/text_title_small.dart';
import '../../app_bar/views/custom_app_bar.dart';
import '../widget/reward_video_card.dart';
import '../model/rewards_model.dart';
import '../model/more_video_rewards.dart';

class UnlockRewardsScreen extends StatelessWidget {
  UnlockRewardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.find<UnlockRewardsController>();
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: OrientationBuilder(
        builder: (context, orientation) {
          final isLandscape = orientation == Orientation.landscape;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: isLandscape ? 8.h : 16.h,
            ),
            child: Column(
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
                      text: 'Unlock Rewards'.tr,
                      fontSize: isLandscape ? 20.sp : 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: isLandscape ? 8.h : 16.h),
                if (!isLandscape)
                  _gradientTitle(
                    normalText: 'Learning Feels Better When'.tr,
                    gradientText: 'You\'re Rewarded'.tr,
                  ),
                if (!isLandscape) SizedBox(height: 12.h),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Future.wait([
                        c.getRewardStatus(),
                        c.getMoreRewards(),
                      ]);
                    },
                    child: ListView(
                      children: [
                        // ✅ Card UI
                        Obx(() {
                          if (c.isLoading.value) {
                            return const Center(
                              child: CustomCircleProgressIndicator(
                                size: 30,
                                color: Colors.blue,
                              ),
                            );
                          }
                          final reward = c.rewardModel.value;
                          if (reward == null) {
                            return Center(
                              child: Text("No rewards available".tr),
                            );
                          }
                          return Obx(() {
                            final data = c.rewardModel.value?.data;
                            if (data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            // Use selectedVideo from controller if available, otherwise use default unlockedVideo
                            final currentVideo = c.selectedVideo.value;
                            final String title = currentVideo is RewardVideo
                                ? currentVideo.title
                                : (currentVideo is VideoModel
                                      ? currentVideo.title
                                      : (data.unlockedVideo?.title ??
                                            "Daily Reward Video".tr));
                            final String subtitle = currentVideo is RewardVideo
                                ? currentVideo.description
                                : (currentVideo is VideoModel
                                      ? currentVideo.description
                                      : (data.unlockedVideo?.description ??
                                            "Complete tasks to unlock this exclusive content"
                                                .tr));
                            final String category = currentVideo is RewardVideo
                                ? currentVideo.category
                                : (currentVideo is VideoModel
                                      ? currentVideo.category
                                      : (data.unlockedVideo?.category ??
                                            "Educational".tr));
                            final int views = currentVideo is RewardVideo
                                ? currentVideo.views
                                : (currentVideo is VideoModel
                                      ? currentVideo.views
                                      : (data.unlockedVideo?.views ?? 0));

                            return RewardVideoLockedCard(
                              thumbnailUrl: "https://picsum.photos/900/500",
                              title: title,
                              subtitle: subtitle,
                              category: category,
                              views: views,
                              unlocked: data.alreadyUnlocked,
                              remaining: data.progress.remainingCount,
                              taskStatus: data.progress.taskStatus,
                              onPlayToggle: () => c.togglePlayPause(),
                              isPlaying: c.isPlaying.value,
                              isVideoInitialized: c.isVideoInitialized.value,
                              currentTime: c.formatDuration(
                                c.videoPosition.value,
                              ),
                              totalTime: c.formatDuration(
                                c.videoDuration.value,
                              ),
                              chewieController: c.chewieController,
                              onSeeAll: () {
                                c.toggleMoreRewards();
                              },
                            );
                          });
                        }),

                        Obx(() {
                          if (!c.isMoreRewardsVisible.value) {
                            return const SizedBox.shrink();
                          }

                          final moreRewards = c.moreVideoRewards.value;
                          if (moreRewards == null ||
                              moreRewards.data.rewards.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: 24.h),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24.h),
                              CustomText(
                                text: 'Other Rewards'.tr,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 12.h),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: moreRewards.data.rewards.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  final rewardItem =
                                      moreRewards.data.rewards[index];
                                  final video = rewardItem.video;
                                  return InkWell(
                                    onTap: () {
                                      Get.dialog(
                                        Dialog(
                                          backgroundColor: Colors.transparent,
                                          insetPadding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                          ),
                                          child: VideoPlayerSheet(
                                            videoUrl: video.videoUrl,
                                          ),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Container(
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            child: Image.network(
                                              "https://picsum.photos/200/120?random=$index",
                                              width: 100.w,
                                              height: 60.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: video.title,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(height: 4.h),
                                                CustomText(
                                                  text: video.category,
                                                  fontSize: 12.sp,
                                                  color: Colors.white70,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.play_circle_fill_rounded,
                                            color: Colors.white,
                                            size: 32.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 20.h),

                        /*                  const SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white.withOpacity(0.10)),
                      ),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Demo Progress: ${c.completedCount}/4",
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: c.completeNext,
                                    child: const Text("Complete Next Task"),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: c.reset,
                                    child: const Text("Reset"),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Note:",
                              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                            ),
                          ],
                        );
                      }),
                    ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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

class VideoPlayerSheet extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerSheet({super.key, required this.videoUrl});

  @override
  State<VideoPlayerSheet> createState() => _VideoPlayerSheetState();
}

class _VideoPlayerSheetState extends State<VideoPlayerSheet> {
  late final VideoPlayerController _vp;
  ChewieController? _chewie;

  @override
  void initState() {
    super.initState();
    _vp = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _vp.initialize().then((_) {
      _chewie = ChewieController(
        videoPlayerController: _vp,
        autoPlay: true,
        looping: false,
        showControls: true,
        allowFullScreen: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.white,
          bufferedColor: Colors.white24,
          handleColor: Colors.white,
          backgroundColor: Colors.white12,
        ),
      );
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _chewie?.dispose();
    _vp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1020),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12.r),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: AspectRatio(
                aspectRatio: _vp.value.isInitialized
                    ? _vp.value.aspectRatio
                    : 16 / 9,
                child: _chewie == null
                    ? const Center(child: CircularProgressIndicator())
                    : Chewie(controller: _chewie!),
              ),
            ),
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 20.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
