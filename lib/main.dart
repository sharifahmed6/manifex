import 'package:flutter/material.dart';

import 'App/app.dart';
import 'Core/SharepreferenceHelper.dart';
import 'Core/TTSService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  await TTSService.init();


  runApp(const MyApp());
}