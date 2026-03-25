import 'package:get/get.dart';
import '../App/assets_path.dart';
import '../Core/SharepreferenceHelper.dart';

class AssetHelper {
  static String getIntroVideoPath() {
    // 1. Try to get language from current active locale (GetX)
    final locale = Get.locale?.languageCode.toLowerCase() ?? '';

    if (locale == 'pl') return AssetsPath.introPortugese;
    if (locale == 'fr') return AssetsPath.introFrench;
    if (locale == 'bn') return AssetsPath.introBangla;
    if (locale == 'zh') return AssetsPath.introChinese;
    if (locale == 'de') return AssetsPath.introGerman;
    if (locale == 'hi') return AssetsPath.introHindi;
    if (locale == 'it') return AssetsPath.introItalian;
    if (locale == 'ko') return AssetsPath.introKorean;
    if (locale == 'pt') return AssetsPath.introPortugese;
    if (locale == 'ru') return AssetsPath.introRussian;
    if (locale == 'es') return AssetsPath.introSpanish;
    if (locale == 'vi') return AssetsPath.introVietnamese;
    if (locale == 'ja') return AssetsPath.introJapanese;
    if (locale == 'en') return AssetsPath.introEnglish;

    // 2. Fallback to PrefHelper (stored preference)
    String language = PrefHelper.getLanguage().toLowerCase();

    if (language.contains("polish")) return AssetsPath.introPortugese;
    if (language.contains("french")) return AssetsPath.introFrench;
    if (language.contains("bangla")) return AssetsPath.introBangla;
    if (language.contains("chinese")) return AssetsPath.introChinese;
    if (language.contains("german")) return AssetsPath.introGerman;
    if (language.contains("hindi")) return AssetsPath.introHindi;
    if (language.contains("nigeria") || language.contains("igbo")) {
      return AssetsPath.introNigeria;
    }
    if (language.contains("italian")) return AssetsPath.introItalian;
    if (language.contains("korean")) return AssetsPath.introKorean;
    if (language.contains("portugese")) return AssetsPath.introPortugese;
    if (language.contains("russian")) return AssetsPath.introRussian;
    if (language.contains("spanish")) return AssetsPath.introSpanish;
    if (language.contains("vietnamese")) return AssetsPath.introVietnamese;
    if (language.contains("japanese")) return AssetsPath.introJapanese;

    return AssetsPath.introEnglish; // Default
  }
}
