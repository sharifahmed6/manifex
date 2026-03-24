import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifex/App/assets_path.dart';
import 'package:manifex/Core/SharepreferenceHelper.dart';
import 'package:manifex/Core/responsive.dart';
import 'package:manifex/Presentation/Features/Subcription/View/Subcription.dart';
import 'package:manifex/Presentation/Share/GradientMask.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../../../../App/AppColors.dart';
import '../../../../App/routes.dart';
import '../../../all_course/interactive_reading/views/task_one.dart';
import '../../../all_course/practices/widget/transperent_gradient_border.dart';
import '../../../app_bar/views/custom_app_bar.dart';
import 'package:chewie/chewie.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(ScreenResponsive.r(context, 15)),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(
                    ScreenResponsive.r(context, 12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: GradientMask(
                                  child: Text(
                                    "${PrefHelper.getFirstName()} ${PrefHelper.getLastName()}!",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        20,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 7),
                              Flexible(
                                child: Text(
                                  "Welcome back".tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      20,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 7),
                        Obx(() => GestureDetector(
                          onTap: () {
                            if (controller.music.isPlaying) {
                              controller.music.stop();
                            } else {
                              controller.music.play(assets_path.home_music);
                            }
                          },
                          child: Icon(
                            controller.music.isPlayingRx.value
                                ? Icons.volume_up_sharp
                                : Icons.volume_off,
                            color: Colors.white70,
                            size: 24.sp,
                          ),
                        )),
                      ],
                    ),
                    Text(
                      "I'm Mercury, your AI reading companion. Today we'll practice reading together!"
                          .tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenResponsive.h(context, 10)),
              Text(
                "Today Progress".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.7,
                              heightFactor: 0.6,
                              child: Image.asset(
                                assets_path.time_file,
                                width: ScreenResponsive.w(context, 200),
                                height: ScreenResponsive.h(context, 200),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 21,
                            left: 21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Words".tr,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    controller.totalWords,
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        12,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.7,
                              heightFactor: 0.6,
                              child: Image.asset(
                                assets_path.streak_file,
                                width: ScreenResponsive.w(context, 200),
                                height: ScreenResponsive.h(context, 200),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 21,
                            left: 21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Streak".tr,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),

                                Obx(
                                      () => Text(
                                    "${controller.dayStreak} ${"Days".tr}",
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        12,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.7,
                              heightFactor: 0.6,
                              child: Image.asset(
                                assets_path.progress_file,
                                width: ScreenResponsive.w(context, 200),
                                height: ScreenResponsive.h(context, 200),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 21,
                            left: 21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Daily Goal".tr,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    controller.dailyGoal,
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        12,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.7,
                              heightFactor: 0.6,
                              child: Image.asset(
                                assets_path.goal_file,
                                width: ScreenResponsive.w(context, 200),
                                height: ScreenResponsive.h(context, 200),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 21,
                            left: 21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today’s Goal".tr,
                                  style: TextStyle(
                                    fontSize: ScreenResponsive.responsiveFont(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    "${controller.overallAccuracy}% ${" Accuracy".tr}",
                                    style: TextStyle(
                                      fontSize: ScreenResponsive.responsiveFont(
                                        context,
                                        12,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: ScreenResponsive.h(context, 10)),
              GradientButton(
                text: "Intro Video".tr,
                onPressed: () => _showIntroVideo(context),
              ),
              Text(
                "Running Practices".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ScreenResponsive.h(context, 10)),
              TransparentGradientBorder(
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
                    spacing: 5,
                    children: [
                      SizedBox(width: double.infinity),
                      Text(
                        "Phoneme Flashcards".tr,
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(
                            context,
                            18,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Complete each task to improve your English reading skill"
                            .tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenResponsive.responsiveFont(
                            context,
                            16,
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenResponsive.h(context, 10)),
                      SizedBox(
                        width: ScreenResponsive.w(context, 200),
                        height: ScreenResponsive.h(context, 50),
                        child: ButtonGradient(
                          text: "Start Practices".tr,
                          onTap: () => Get.to(TaskOne()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: ScreenResponsive.h(context, 10)),
              Text(
                "Trending Practices".tr,
                style: TextStyle(
                  fontSize: ScreenResponsive.responsiveFont(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ScreenResponsive.h(context, 10)),

              _practicesCard(
                imagePath: 'assets/images/book.png',
                title: 'Interactive Reading'.tr,
                subTitle:
                'Phoneme recognition and word games with visual cues designed for dyslexic learners'
                    .tr,
                context: context,
                onTap: () => Get.toNamed(routes.interactive_reading_screen),
              ),
              SizedBox(height: 16.h),
              _practicesCard(
                imagePath: 'assets/icons/smart_writing_icon.png',
                title: 'Smart Writing'.tr,
                subTitle:
                'Write. Learn. Improve. AI checks your grammar, structure, and style instantly.'
                    .tr,
                context: context,
                onTap: () => Get.toNamed(routes.smart_writing_screen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _practicesCard({
  String? imagePath,
  String? title,
  String? subTitle,
  VoidCallback? onTap,
  required BuildContext context,
}) {
  return TransparentGradientBorder(
    strokeWidth: 0.5,
    radius: ScreenResponsive.r(context, 16),
    child: Container(
      padding: EdgeInsets.all(ScreenResponsive.r(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenResponsive.r(context, 16)),
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
        spacing: 5,
        children: [
          Container(
            padding: EdgeInsets.all(ScreenResponsive.r(context, 16)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                ScreenResponsive.r(context, 12),
              ),
              color: AppColors.white.withAlpha((2.56 * 17).toInt()),
            ),
            child: Image.asset(
              imagePath ?? '',
              width: ScreenResponsive.w(context, 35),
              height: ScreenResponsive.h(context, 32),
            ),
          ),
          Text(
            title ?? '',
            style: TextStyle(
              fontSize: ScreenResponsive.responsiveFont(context, 16),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            subTitle ?? '',
            style: TextStyle(
              fontSize: ScreenResponsive.responsiveFont(context, 12),
            ),
          ),
          SizedBox(height: 10.h),
          ButtonGradient(text: 'Start Reading'.tr, onTap: onTap),
        ],
      ),
    ),
  );
}

void _showIntroVideo(BuildContext context) {
  String videoPath = _getIntroVideoPath();
  Get.dialog(
    IntroVideoDialog(videoPath: videoPath),
    barrierDismissible: true,
  );
}

String _getIntroVideoPath() {
  String language = PrefHelper.getLanguage().toLowerCase();

  print("Language : $language");

  if (language.contains("french")) return assets_path.intro_French;
  if (language.contains("bangla")) return assets_path.intro_Bangla;
  if (language.contains("chinese")) return assets_path.intro_Chinese;
  if (language.contains("german")) return assets_path.intro_German;
  if (language.contains("hindi")) return assets_path.intro_Hindi;
  if (language.contains("nigeria") || language.contains("igbo"))
    return assets_path.intro_Nigeria;
  if (language.contains("italian")) return assets_path.intro_Italian;
  if (language.contains("korean")) return assets_path.intro_Korean;
  if (language.contains("portugese")) return assets_path.intro_Portugese;
  if (language.contains("russian")) return assets_path.intro_Russian;
  if (language.contains("spanish")) return assets_path.intro_Spanish;
  if (language.contains("vietnamese")) return assets_path.intro_Vietnamese;
  if (language.contains("japanese")) return assets_path.intro_Japanese;

  return assets_path.intro_English; // Default
}

class IntroVideoDialog extends StatefulWidget {
  final String videoPath;
  const IntroVideoDialog({super.key, required this.videoPath});

  @override
  State<IntroVideoDialog> createState() => _IntroVideoDialogState();
}

class _IntroVideoDialogState extends State<IntroVideoDialog> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.white,
        bufferedColor: Colors.white24,
        handleColor: Colors.white,
        backgroundColor: Colors.white12,
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
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
                  aspectRatio:
                      _videoPlayerController.value.isInitialized
                          ? _videoPlayerController.value.aspectRatio
                          : 16 / 9,
                  child:
                      _chewieController == null
                          ? const Center(
                              child: CustomCircleProgressIndicator(
                                size: 30,
                                color: Colors.blue,
                              ),
                            )
                          : Chewie(controller: _chewieController!),
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
      ),
    );
  }
}
