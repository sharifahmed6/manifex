import 'package:get/get.dart';
import 'package:manifex/Presentation/bottom_navbar/views/bottom_navbar_view.dart';
import 'package:manifex/Presentation/practices/views/practices_screen.dart';
import 'package:manifex/Presentation/progress/views/progress_screen.dart';
import '../Presentation/Authentication/Forget_password/find_account/View/find_account.dart';
import '../Presentation/Authentication/Login/View/login.dart';
import '../Presentation/Authentication/SignUp/View/SignUp.dart';
import '../Presentation/On_boarding/View/on_boarding.dart';
import '../Presentation/Splash/View/Splash.dart';
import 'Binding.dart';

class routes {
  static const String splash_screen = '/splash';
  static const String on_borading_screen = '/on_borading';
  static const String login_screen = '/login';
  static const String signup_screen = '/signup';
  static const String bottom_navbar = '/bottom_navbar';
  static const String practices_screen = '/practices_screen';
  static const String progress_screen = '/progress_screen';
  static const String find_account_screen = '/find_account';



  static final pages = [
    GetPage( name: splash_screen, binding: InitialBinding(), page: () => splash()),
    GetPage( name: on_borading_screen, binding: InitialBinding(), page: () => on_borading()),
    GetPage( name: login_screen, binding: InitialBinding(), page: () => login()),
    GetPage( name: signup_screen, binding: InitialBinding(), page: () => signup()),
    GetPage( name: bottom_navbar, binding: InitialBinding(), page: () => BottomNavbarView()),
    GetPage( name: practices_screen, binding: InitialBinding(), page: () => PracticesScreen()),
    GetPage( name: progress_screen, binding: InitialBinding(), page: () => ProgressScreen()),
    GetPage( name: find_account_screen, binding: InitialBinding(), page: () => find_account()),

  ];
}


