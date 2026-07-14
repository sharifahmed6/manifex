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
      if (route == 'null' || route.isEmpty) return;

      // Ensure music only plays when precisely on the Bottom Navbar's Home Tab
      if (route == '/home_screen' || route == '/bottom_navbar' || route == '/') {
        try {
          final bottomController = Get.find<BottomNavbarController>();
          if (bottomController.selectedIndex.value == 0) {
            // Respect user manual pause preference
            if (!music.isPlaying && music.isPreferencePlay) {
              Future.delayed(const Duration(milliseconds: 100), () {
                if (!music.isPlaying && music.isPreferencePlay) {
                  music.play(AssetsPath.homeMusic);
                }
              });
            }
          } else {
            music.stop();
          }
        } catch (_) {
          // Fallback if BottomNavbarController is not yet available
          if (!music.isPlaying && music.isPreferencePlay) {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (!music.isPlaying && music.isPreferencePlay) {
                music.play(AssetsPath.homeMusic);
              }
            });
          }
        }
      } else {
        // Stop music when pushed to sub-screens like Task or Writing
        music.stop();
      }
    });
  }

  // Detect screen lock / unlock or minimizing (lifecycle changes)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Stop music when app is minimized or screen is locked (paused/inactive)
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      music.stop();
    }

    // Resume music when screen is unlocked and app returns to focus (resumed)
    if (state == AppLifecycleState.resumed) {
      final currentRoute = Get.currentRoute;

      // Case 1: On Home Screen (Home Tab)
      if (currentRoute == '/home_screen' || currentRoute == '/bottom_navbar' || currentRoute == '/') {
        try {
          final bottomController = Get.find<BottomNavbarController>();
          if (bottomController.selectedIndex.value == 0) {
            // Respect user manual pause preference
            if (music.isPreferencePlay) {
              Future.delayed(const Duration(milliseconds: 100), () {
                if (!music.isPlaying && music.isPreferencePlay) {
                  music.play(AssetsPath.homeMusic);
                }
              });
            }
          }
        } catch (_) {
          // Default play if controller look-up fails but we are on home route
          if (music.isPreferencePlay) {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (!music.isPlaying && music.isPreferencePlay) {
                music.play(AssetsPath.homeMusic);
              }
            });
          }
        }
      }
      // Case 2: On Smart Writing Screen
      else if (currentRoute == '/smart_writing_screen') {
        if (music.isPreferencePlay) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (!music.isPlaying && music.isPreferencePlay) {
              music.play(AssetsPath.smartWritingMusic);
            }
          });
        }
      }
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

  int get remainingFreeDays {
    final createdAt = profileInfo.value?.data?.createdAt;
    if (createdAt == null) return 0;
    
    final difference = DateTime.now().difference(createdAt).inDays;
    final remaining = 7 - difference;
    
    return remaining > 0 ? remaining : 0;
  }
  
  int get usedFreeDays {
    final createdAt = profileInfo.value?.data?.createdAt;
    if (createdAt == null) return 0;
    
    final difference = DateTime.now().difference(createdAt).inDays;
    // Difference is 0 on the first day, so used days is difference + 1
    return (difference + 1).clamp(1, 7);
  }

  bool get isFreeTrialActive => remainingFreeDays > 0;

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
