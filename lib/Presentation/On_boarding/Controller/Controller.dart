import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manifex/Core/MusicService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../language/model/language_model.dart';

class on_boarding_controller extends GetxController
    with WidgetsBindingObserver {
  var page_index = 0.obs;
  var languageIndex = 0.obs;
  static const _langKey = 'lang_index';

  final music = MusicService();

  final languages = <LanguageModel>[
    LanguageModel(
      title: "English",
      country: "United Kingdom",
      flag: "assets/icons/english.png",
      locale: const Locale('en', 'US'),
    ),
    LanguageModel(
      title: "Polish",
      country: "Poland",
      flag: "assets/icons/poland_icon.png",
      locale: const Locale('pl', 'PL'),
    ),
    LanguageModel(
      title: "Bangla",
      country: "Bangladesh",
      flag: "assets/icons/bangladesh_icon.png",
      locale: const Locale('bn', 'BD'),
    ),
    LanguageModel(
      title: "Chinese",
      country: "China",
      flag: "assets/icons/chinese_icon.png",
      locale: const Locale('zh', 'CN'),
    ),
    // LanguageModel(
    //   title: "Hindi",
    //   country: "India",
    //   flag: "assets/icons/india_icon.png",
    //   locale: const Locale('hi', 'IN'),
    // ),
    // LanguageModel(
    //   title: "Korean",
    //   country: "Korea",
    //   flag: "assets/icons/korean_icon.png",
    //   locale: const Locale('ko', 'KR'),
    // ),
    // LanguageModel(
    //   title: "Italian",
    //   country: "Italia",
    //   flag: "assets/icons/italian_icon.png",
    //   locale: const Locale('it', 'IT'),
    // ),
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _loadLanguage();
    music.play();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    music.stop(); // 👈 stop when leaving page
    super.onClose();
  }

  // 👇 Detect app minimize / resume
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      music.stop(); // App minimized
    }

    if (state == AppLifecycleState.resumed) {
      music.play(); // Optional: resume when back
    }
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt(_langKey);
    if (savedIndex != null && savedIndex < languages.length) {
      languageIndex.value = savedIndex;
      Get.updateLocale(languages[savedIndex].locale);
    }
  }

  Future<void> changeLanguage(int index) async {
    languageIndex.value = index;
    Get.updateLocale(languages[index].locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_langKey, index);
  }

  void change_page(int index) {
    page_index.value = index;
  }
}
