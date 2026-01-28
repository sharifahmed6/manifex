import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/unlock_rewards/controller/unlock_rewards_controller.dart';
import 'package:video_player/video_player.dart';

import '../../Share/text_title_small.dart';
import '../../app_bar/views/custom_app_bar.dart';
import '../model/task_view_model.dart';
import '../widget/reward_video_card.dart';

class UnlockRewardsScreen extends StatelessWidget {
   UnlockRewardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.find<UnlockRewardsController>();
    const videoUrl = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
    const thumbUrl = "https://picsum.photos/900/500";
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
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
                  text: 'Unlock Rewards',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _gradientTitle(
              normalText: 'Learning Feels Better When',
              gradientText: 'You\'re Rewarded',
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView(
                children: [
                  // ✅ Card UI
                  Obx(() {
                    return RewardVideoLockedCard(
                      thumbnailUrl: thumbUrl,
                      title: "Best Goals of the Week – 30s\nhighlight",
                      subtitle: "Celebrate your progress with the best football mom...",
                      unlocked: c.unlocked,
                      remaining: (4 - c.completedCount).clamp(0, 4),
                      tasks: List.generate(
                        c.tasks.length,
                            (i) => TaskViewModel(title: c.tasks[i], done: c.taskDone(i)),
                      ),
                      onPlay: () {
                        if (!c.unlocked) return; // extra safety
                        Get.bottomSheet(
                          VideoPlayerSheet(videoUrl: videoUrl),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      },
                    );
                  }),

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
          ],
        ),
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
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1020).withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: AspectRatio(
            aspectRatio: _vp.value.isInitialized ? _vp.value.aspectRatio : 16 / 9,
            child: _chewie == null
                ? const Center(child: CircularProgressIndicator())
                : Chewie(controller: _chewie!),
          ),
        ),
      ),
    );
  }
}
