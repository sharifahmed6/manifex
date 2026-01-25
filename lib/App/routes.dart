import 'package:get/get.dart';
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
  static const String find_account_screen = '/find_account';



  static final pages = [
    GetPage( name: splash_screen, binding: InitialBinding(), page: () => splash()),
    GetPage( name: on_borading_screen, binding: InitialBinding(), page: () => on_borading()),
    GetPage( name: login_screen, binding: InitialBinding(), page: () => login()),
    GetPage( name: signup_screen, binding: InitialBinding(), page: () => signup()),
    GetPage( name: find_account_screen, binding: InitialBinding(), page: () => find_account()),

  ];
}


