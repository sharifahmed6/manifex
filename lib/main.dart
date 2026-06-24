import 'dart:io';

import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App/app.dart';
import 'Core/SharepreferenceHelper.dart';
import 'Core/TTSService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  await TTSService.init();

  String apiKey = "";
  if (Platform.isAndroid) {
    apiKey = "goog_ddPdIDBYehMXVmlxIqvSfzFskSf";
  } else if (Platform.isIOS) {
    apiKey = "appl_XvgIfWcbeBNBrEwIEumbLJGlJhS";
  }

  await Purchases.configure(
    PurchasesConfiguration(apiKey),
  );

  final prefs = await SharedPreferences.getInstance();
  final savedIndex = prefs.getInt('lang_index') ?? 0;

  Locale initialLocale;
  switch (savedIndex) {
    case 1:
      initialLocale = const Locale('pl', 'PL');
      break;
    case 2:
      initialLocale = const Locale('bn', 'BD');
      break;
    case 3:
      initialLocale = const Locale('zh', 'CN');
      break;
    case 4:
      initialLocale = const Locale('fr', 'FR');
      break;
    case 5:
      initialLocale = const Locale('hi', 'IN');
      break;
    case 6:
      initialLocale = const Locale('de', 'DE');
      break;
    case 7:
      initialLocale = const Locale('it', 'IT');
      break;
    case 8:
      initialLocale = const Locale('ko', 'KR');
      break;
    case 9:
      initialLocale = const Locale('es', 'ES');
      break;
    case 10:
      initialLocale = const Locale('ru', 'RU');
      break;
    case 11:
      initialLocale = const Locale('vi', 'VN');
      break;
    default:
      initialLocale = const Locale('en', 'US');
  }

  runApp(MyApp(initialLocale: initialLocale));
}
