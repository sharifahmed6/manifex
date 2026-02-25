import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class on_boarding_controller extends GetxController {
  var page_index = 0.obs;
  var languageIndex = 0.obs; // 0 for English, 1 for Polish
  static const _langKey = 'lang_index';

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt(_langKey);
    if (savedIndex != null) {
      languageIndex.value = savedIndex;
      _updateLocale(savedIndex);
    }
  }

  Future<void> changeLanguage(int index) async {
    languageIndex.value = index;
    _updateLocale(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_langKey, index);
  }

  void _updateLocale(int index) {
    if (index == 0) {
      Get.updateLocale(const Locale('en', 'US'));
    } else if (index == 1) {
      Get.updateLocale(const Locale('pl', 'PL'));
    }
  }

  void change_page(int index) {
    page_index.value = index;
  }
}
