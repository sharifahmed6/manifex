import 'package:get/get.dart';
import 'package:manifex/Presentation/about_us/views/about_us_screen.dart';
import 'package:manifex/Presentation/all_course/interactive_reading/views/interactive_reading_screen.dart';
import 'package:manifex/Presentation/all_course/native_speaking/views/native_speaking_screen.dart';
import 'package:manifex/Presentation/all_course/smart_writing/views/smart_writing_screen.dart';
import 'package:manifex/Presentation/bottom_navbar/views/bottom_navbar_view.dart';
import 'package:manifex/Presentation/language/views/language_screen.dart';
import 'package:manifex/Presentation/privacy_policy/views/privacy_policy_screen.dart';
import 'package:manifex/Presentation/profile/views/profile_screen.dart';
import 'package:manifex/Presentation/profile_edit/views/profile_edit_screen.dart';
import 'package:manifex/Presentation/progress/views/progress_screen.dart';
import 'package:manifex/Presentation/terms_condition/views/terms_condition_screen.dart';
import 'package:manifex/Presentation/unlock_rewards/views/unlock_rewards_screen.dart';
import '../Presentation/Authentication/Login/View/login.dart';
import '../Presentation/Authentication/SignUp/View/SignUp.dart';
import '../Presentation/On_boarding/View/on_boarding.dart';
import '../Presentation/Splash/View/Splash.dart';
import '../Presentation/all_course/practices/views/practices_screen.dart';
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
  static const String profile_screen = '/profile_screen';
  static const String profile_edit_screen = '/profile_edit_screen';
  static const String language_screen = '/language_screen';
  static const String about_us_screen = '/about_us_screen';
  static const String terms_conditon_screen = '/terms_conditon_screen';
  static const String privacy_policy_screen = '/privacy_policy_screen';
  static const String unlock_rewards_screen = '/unlock_rewards_screen';
  static const String interactive_reading_screen = '/interactive_reading_screen';
  static const String native_speaking_skill_screen = '/native_speaking_skill_screen';
  static const String smart_writing_screen = '/smart_writing_screen';



  static final pages = [
    GetPage( name: splash_screen, binding: InitialBinding(), page: () => splash()),
    GetPage( name: on_borading_screen, binding: InitialBinding(), page: () => on_borading()),
    GetPage( name: login_screen, binding: InitialBinding(), page: () => login()),
    GetPage( name: signup_screen, binding: InitialBinding(), page: () => signup()),
    GetPage( name: bottom_navbar, binding: InitialBinding(), page: () => BottomNavbarView()),
    GetPage( name: practices_screen, binding: InitialBinding(), page: () => PracticesScreen()),
    GetPage( name: progress_screen, binding: InitialBinding(), page: () => ProgressScreen()),
    GetPage( name: profile_screen, binding: InitialBinding(), page: () => ProfileScreen()),
    GetPage( name: profile_edit_screen, binding: InitialBinding(), page: () => ProfileEditScreen()),
    GetPage( name: language_screen, binding: InitialBinding(), page: () => LanguageScreen()),
    GetPage( name: about_us_screen, binding: InitialBinding(), page: () => AboutUsScreen()),
    GetPage( name: terms_conditon_screen, binding: InitialBinding(), page: () => TermsConditionScreen()),
    GetPage( name: privacy_policy_screen, binding: InitialBinding(), page: () => PrivacyPolicyScreen()),
    GetPage( name: unlock_rewards_screen, binding: InitialBinding(), page: () => UnlockRewardsScreen()),
    GetPage( name: interactive_reading_screen, binding: InitialBinding(), page: () => InteractiveReadingScreen()),
    GetPage( name: smart_writing_screen, binding: InitialBinding(), page: () => SmartWritingScreen()),
    GetPage( name: native_speaking_skill_screen, binding: InitialBinding(), page: () => NativeSpeakingScreen()),

  ];
}


