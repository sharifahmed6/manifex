import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'App/app.dart';
import 'Core/SharepreferenceHelper.dart';
import 'Core/TTSService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  await TTSService.init();

  await Purchases.configure(PurchasesConfiguration("appl_XvgIfWcbeBNBrEwIEumbLJGlJhS"));


  runApp(const MyApp());
}