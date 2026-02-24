import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/language_model.dart';

class LanguageController extends GetxController{
  static const _langKey = 'lang_index';

  final languages = <LanguageModel>[
    LanguageModel(title: "English", country: "United Kingdom", flag: "assets/icons/english.png", locale: const Locale('en', 'GB')),
    LanguageModel(title: "Polish", country: "Poland", flag: "assets/icons/poland_icon.png", locale: const Locale('pl', 'PL')),
    LanguageModel(title: "Bangla", country: "Bangladesh", flag: "assets/icons/bangladesh_icon.png", locale: const Locale('bn', 'BD')),
    LanguageModel(title: "Chinese", country: "China", flag: "assets/icons/chinese_icon.png", locale: const Locale('zh', 'CN')),
    LanguageModel(title: "Hindi", country: "India", flag: "assets/icons/india_icon.png", locale: const Locale('hi', 'IN')),
    LanguageModel(title: "Korean", country: "Korea", flag: "assets/icons/korean_icon.png", locale: const Locale('ko', 'KR')),
    LanguageModel(title: "Italian", country: "Italia", flag: "assets/icons/italian_icon.png", locale: const Locale('it', 'IT')),
  ];

  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt(_langKey);

    if (savedIndex != null && savedIndex < languages.length) {
      selectedIndex.value = savedIndex;
      Get.updateLocale(languages[savedIndex].locale);
    }
  }

  Future<void> selectLanguage(int index) async {
    selectedIndex.value = index;
    Get.updateLocale(languages[index].locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_langKey, index);
    Get.back();
  }
}