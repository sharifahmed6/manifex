import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/App/routes.dart';
import 'Binding.dart';
import 'CustomTheme.dart';
import 'Translation.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslation(),
        locale: initialLocale,
        fallbackLocale: const Locale('en', 'US'),
        // locale: Locale('pl', 'PL'),
        // fallbackLocale: Locale('pl', 'PL'),
        theme: customTheme,
        initialBinding: InitialBinding(),
        navigatorObservers: [routeObserver],
        getPages: routes.pages,
        initialRoute: routes.splash_screen,
      ),
    );
  }
}
