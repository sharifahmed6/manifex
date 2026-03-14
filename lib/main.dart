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

  await Purchases.configure(
    PurchasesConfiguration("appl_XvgIfWcbeBNBrEwIEumbLJGlJhS"),
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
    default:
      initialLocale = const Locale('en', 'US');
  }

  runApp(MyApp(initialLocale: initialLocale));
}
