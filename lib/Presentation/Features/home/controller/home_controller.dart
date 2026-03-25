import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/App/Urls.dart';
import 'package:manifex/App/network_caller.dart';
import 'package:manifex/Core/SharepreferenceHelper.dart';
import 'package:manifex/Presentation/Features/home/model/user_model.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../Core/MusicService.dart';
import '../../../../App/assets_path.dart';
import '../../../bottom_navbar/controllers/bottom_navbar_controller.dart';
import '../../../../Core/AssetHelper.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final profileInfo = Rxn<UserModel>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final music = MusicService();

  @override
  Future<void> onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    music.play(AssetsPath.homeMusic);
    String userId = PrefHelper.getUserId();
    if (userId.isEmpty) {
      throw Exception("Backend user ID cannot be empty for RevenueCat login!");
    }

    await Purchases.logIn(userId);
    fetchProfileInfo();

    // Monitor GetX routing changes globally
    ever(Get.routing.current.obs, (String route) {
      if (route == 'null' || route.isEmpty) return; // Initial setup

      // Play music ONLY when exactly on HomeScreen (within BottomNavbar)
      // Any other Push route that covers the home screen should stop it.
      if (route == '/home_screen' ||
          route == '/bottom_navbar' ||
          route == '/') {
        // Also ensure bottom navbar tab is actually the home tab
        try {
          final bottomController = Get.find<BottomNavbarController>();
          if (bottomController.selectedIndex.value == 0) {
            if (music.isPlaying) {
              music.stop();
            } else {
              music.play(AssetsPath.homeMusic);
            }
          } else {
            music.stop();
          }
        } catch (_) {
          // If BottomNavbarController isn't ready, default to playing since we are on the base route
          music.play(AssetsPath.homeMusic);
        }
      } else {
        music.stop(); // We are pushed to a completely different screen
      }
    });
  }

  // 👇 Detect app minimize / resume
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      music.stop(); // App minimized
    }

    if (state == AppLifecycleState.resumed &&
        Get.currentRoute == '/HomeScreen') {
      music.play(AssetsPath.homeMusic); // Optional: resume when back
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    music.stop(); // 👈 stop when leaving page
    super.onClose();
  }

  String get userId => profileInfo.value?.data?.id ?? '';
  String get ageRange => profileInfo.value?.data?.age ?? '';
  String get totalWords =>
      profileInfo.value?.data?.userProgress?.totalWords.toString() ?? '0';
  String get totalLessons =>
      profileInfo.value?.data?.userProgress?.totalLessons.toString() ?? '0';
  String get overallAccuracy =>
      profileInfo.value?.data?.userProgress?.overallAccuracy.toString() ?? '0';
  String get dailyGoal =>
      profileInfo.value?.data?.userProgress?.dailyGoal.toString() ?? '0';
  String get dayStreak =>
      profileInfo.value?.data?.userProgress?.dayStreak.toString() ?? '0';

  int get apiAge => _mapAgeToApi(ageRange);
  bool get isReady => userId.isNotEmpty;

  Future<void> fetchProfileInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await NetworkCaller().getRequest(url: urls.profileInfo);

      if (response.isSuccess && response.responseData != null) {
        profileInfo.value = UserModel.fromJson(response.responseData!);
        print("User Data: $profileInfo");
      } else {
        errorMessage.value = response.errorMessage;
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

  void playIntroVideo(BuildContext context, Widget dialog) {
    Get.dialog(
      dialog,
      barrierDismissible: true,
    );
  }

  String getIntroVideoPath() {
    return AssetHelper.getIntroVideoPath();
  }

  int _mapAgeToApi(String? range) {
    final s = (range ?? '').trim();

    if (s == '6-9') return 8;
    if (s == '10-13') return 12;
    if (s == '14-17') return 16;
    if (s == '18-40') return 39;

    final parts = s.split('-').map((e) => e.trim()).toList();
    if (parts.length == 2) {
      final a = int.tryParse(parts[0]);
      final b = int.tryParse(parts[1]);
      if (a != null && b != null) return ((a + b) / 2).round();
    }

    final single = int.tryParse(s);
    if (single != null) return single;

    return 12;
  }
}
