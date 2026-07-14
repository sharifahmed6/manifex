import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../App/Urls.dart';
import '../../../App/network_caller.dart';
import '../model/rewards_model.dart';
import '../model/more_video_rewards.dart';

class UnlockRewardsController extends GetxController {
  final isLoading = false.obs;
  final rewardModel = Rxn<RewardModel>();
  final moreVideoRewards = Rxn<MoreVideoRewards>();
  final isMoreRewardsVisible = false.obs;
  final isMoreRewardsLoading = false.obs;
  final selectedVideo = Rxn<dynamic>(); // Can be RewardVideo or VideoModel

  // Video states
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  final isVideoInitialized = false.obs;
  final isPlaying = false.obs;
  final videoPosition = Duration.zero.obs;
  final videoDuration = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    getRewardStatus();
  }

  Future<void> getRewardStatus() async {
    try {
      isLoading.value = true;
      NetworkResponse response = await NetworkCaller().getRequest(
        url: urls.rewardVideoCheck,
      );

      if (response.isSuccess) {
        final model = RewardModel.fromJson(response.responseData);
        rewardModel.value = model;

        if (model.data.alreadyUnlocked &&
            model.data.unlockedVideo != null &&
            model.data.unlockedVideo!.videoUrl.isNotEmpty) {
          _initializeVideo(model.data.unlockedVideo!.videoUrl);
        }
      }
    } catch (e) {
      debugPrint("Error fetching rewards: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMoreRewards() async {
    try {
      isMoreRewardsLoading.value = true;
      NetworkResponse response = await NetworkCaller().getRequest(
        url: urls.rewardVideoList,
      );

      if (response.isSuccess && response.responseData != null) {
        final model = MoreVideoRewards.fromJson(
          response.responseData as Map<String, dynamic>,
        );
        moreVideoRewards.value = model;

        if (model.data.rewards.isEmpty) {
          Get.snackbar(
            'Notice'.tr,
            'No reward videos available at the moment.'.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.redAccent.withOpacity(0.8),
            colorText: Colors.white,
            margin: EdgeInsets.all(12),
          );
          // Hide it back if empty
          isMoreRewardsVisible.value = false;
        }
      }
    } catch (e) {
      debugPrint("Error fetching more rewards: $e");
    } finally {
      isMoreRewardsLoading.value = false;
    }
  }

  void _initializeVideo(String url) {
    isVideoInitialized.value = false;
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    videoPlayerController.initialize().then((_) {
      videoDuration.value = videoPlayerController.value.duration;
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        showControls: true, // Needed for full-screen controls
        showControlsOnInitialize: false,
        allowFullScreen: true,
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.white,
          bufferedColor: Colors.white24,
          handleColor: Colors.white,
          backgroundColor: Colors.white12,
        ),
      );
      isVideoInitialized.value = true;
      update();
    });

    videoPlayerController.addListener(() {
      isPlaying.value = videoPlayerController.value.isPlaying;
      videoPosition.value = videoPlayerController.value.position;
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void selectVideo(dynamic video) {
    if (video == null) return;
    String url = '';
    if (video is RewardVideo) {
      url = video.videoUrl;
    } else if (video is VideoModel) {
      url = video.videoUrl;
    }

    if (url.isNotEmpty) {
      selectedVideo.value = video;
      _initializeVideo(url);
    }
  }

  void toggleMoreRewards() {
    isMoreRewardsVisible.value = !isMoreRewardsVisible.value;
    if (isMoreRewardsVisible.value) {
      if (moreVideoRewards.value == null || moreVideoRewards.value!.data.rewards.isEmpty) {
        getMoreRewards();
      }
    }
  }

  void togglePlayPause() {
    if (!isVideoInitialized.value) return;

    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
