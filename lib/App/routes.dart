import 'package:get/get.dart';
import '../Presentation/Splash/View/Splash.dart';
import 'Binding.dart';

class routes {
  static const String splash_screen = '/splash';



  static final pages = [
    GetPage( name: splash_screen, binding: InitialBinding(), page: () =>  splash()),

  ];
}


