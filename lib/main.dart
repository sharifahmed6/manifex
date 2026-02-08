import 'package:flutter/material.dart';

import 'App/app.dart';
import 'Core/SharepreferenceHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();

  runApp(const MyApp());
}