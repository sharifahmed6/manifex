import 'package:get/get.dart';
import 'package:manifex/Presentation/Features/home/view/home_screen.dart';
import 'package:manifex/Presentation/about_us/views/about_us_screen.dart';
import 'package:manifex/Presentation/all_course/interactive_reading/views/interactive_reading_screen.dart';
import 'package:manifex/Presentation/all_course/interactive_reading/views/sight_word_screen.dart';
import 'package:manifex/Presentation/all_course/interactive_reading/views/task_one.dart';
import 'package:manifex/Presentation/all_course/smart_writing/views/smart_writing_screen.dart';
import 'package:manifex/Presentation/bottom_navbar/views/bottom_navbar_view.dart';
import 'package:manifex/Presentation/language/views/language_screen.dart';
import 'package:manifex/Presentation/privacy_policy/views/privacy_policy_screen.dart';
import 'package:manifex/Presentation/profile/views/profile_screen.dart';
import 'package:manifex/Presentation/profile_edit/views/profile_edit_screen.dart';
import 'package:manifex/Presentation/progress/views/progress_screen.dart';
import 'package:manifex/Presentation/terms_condition/views/terms_condition_screen.dart';
import 'package:manifex/Presentation/unlock_rewards/views/unlock_rewards_screen.dart';
import '../Presentation/Authentication/Forget_password/find_account/View/find_account.dart';
import '../Presentation/Authentication/Login/View/login.dart';
import '../Presentation/Authentication/SignUp/View/SignUp.dart';
import '../Presentation/Authentication/SignUp/View/signupGmail.dart';
import '../Presentation/On_boarding/View/on_boarding.dart';
import '../Presentation/Splash/View/Splash.dart';
import '../Presentation/all_course/EnglishAdultPractice/View/EnglishAdultPractice.dart';
import '../Presentation/all_course/EnglishAdultPractice/Widgets/auditoryDiscrimination/View/auditoryDiscrimination.dart';
import '../Presentation/all_course/EnglishAdultPractice/Widgets/phonemeGraphemeMapping/View/phonemeGraphemeMapping.dart';
import '../Presentation/all_course/EnglishAdultPractice/Widgets/phraseMaker/View/phraseMaker.dart';
import '../Presentation/all_course/EnglishAdultPractice/Widgets/sentenceBuilder/View/sentenceBuilder.dart';
import '../Presentation/all_course/EnglishAdultPractice/Widgets/wordFlash/View/wordFlash.dart';
import '../Presentation/all_course/EnglishAdultPractice/Widgets/wordPartsWorkshop/View/wordPartsWorkshop.dart';
import '../Presentation/all_course/HandwritingPractice/View/HandwritingPractice.dart';
import '../Presentation/all_course/HandwritingPractice/Widgets/AFHandwriting/View/AFHandwriting.dart';
import '../Presentation/all_course/interactive_reading/views/interactive_task_four_screen.dart';
import '../Presentation/all_course/interactive_reading/views/interactive_task_three_screen.dart';
import '../Presentation/all_course/native_speaking/views/native_speaking_screen.dart';
import '../Presentation/all_course/native_speaking/views/native_task_one.dart';
import '../Presentation/all_course/native_speaking/views/native_task_two.dart';
import '../Presentation/all_course/native_speaking/views/native_task_three.dart';
import '../Presentation/all_course/native_speaking/views/native_task_four.dart';
import '../Presentation/all_course/practices/views/practices_screen.dart';
import '../Presentation/all_course/presentationPractice/View/presentationPractice.dart';
import '../Presentation/all_course/presentationPractice/Widgets/ContextSpin/View/ContextSpin.dart';
import '../Presentation/all_course/presentationPractice/Widgets/PrecisionDrill/View/PrecisionDrill.dart';
import '../Presentation/all_course/presentationPractice/Widgets/flowChain/View/flowChain.dart';
import '../Presentation/all_course/presentationPractice/Widgets/powerWordsPluse/View/powerWordsPluse.dart';
import 'Binding.dart';

class routes {
  static const String splash_screen = '/splash';
  static const String on_borading_screen = '/on_borading';
  static const String login_screen = '/login';
  static const String signup_screen = '/signup';
  static const String bottom_navbar = '/bottom_navbar';
  static const String home_screen = '/home_screen';
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
  static const String interactive_reading_screen =
      '/interactive_reading_screen';
  static const String native_speaking_skill_screen =
      '/native_speaking_skill_screen';
  static const String smart_writing_screen = '/smart_writing_screen';
  static const String interactive_reading_task1 = '/interactive_reading_task1';
  static const String sight_word_scrren = '/sight_word_scrren';
  static const String interactive_task3_screen = '/interactive_task3_screen';
  static const String interactive_task4_screen = '/interactive_task4_screen';
  static const String signupGmail_screen = '/signupGmail';
  static const String presentationPractice_screen = '/presentationPractice';
  static const String EnglishAdultPractice_screen = '/EnglishAdultPractice';
  static const String HandwritingPractice_screen = '/HandwritingPractice';
  static const String powerWordsPlus_screen = '/powerWordsPlus';
  static const String PrecisionDrill_screen = '/PrecisionDrill';
  static const String ContextSpin_screen = '/ContextSpin';
  static const String flowChain_screen = '/flowChain';
  static const String auditoryDiscrimination_screen = '/auditoryDiscrimination';
  static const String phonemeGraphemeMapping_screen = '/phonemeGraphemeMapping';
  static const String phraseMaker_screen = '/phraseMaker';
  static const String sentenceBuilder_screen = '/sentenceBuilder';
  static const String wordFlash_screen = '/wordFlash';
  static const String wordPartsWorkshop_screen = '/wordPartsWorkshop';
  static const String nativeOneScreen = '/native_one_screen';
  static const String nativeTwoScreen = '/native_two_screen';
  static const String nativeThreeScreen = '/native_three_screen';
  static const String nativeFourScreen = '/native_four_screen';

  static final pages = [
    GetPage(
      name: splash_screen,
      binding: InitialBinding(),
      page: () => splash(),
    ),
    GetPage(
      name: on_borading_screen,
      binding: InitialBinding(),
      page: () => on_borading(),
    ),
    GetPage(name: login_screen, binding: InitialBinding(), page: () => login()),
    GetPage(
      name: signup_screen,
      binding: InitialBinding(),
      page: () => signup(),
    ),
    GetPage(
      name: bottom_navbar,
      binding: InitialBinding(),
      page: () => BottomNavbarView(),
    ),
    GetPage(
      name: practices_screen,
      binding: InitialBinding(),
      page: () => PracticesScreen(),
    ),
    GetPage(
      name: progress_screen,
      binding: InitialBinding(),
      page: () => ProgressScreen(),
    ),
    GetPage(
      name: profile_screen,
      binding: InitialBinding(),
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: profile_edit_screen,
      binding: InitialBinding(),
      page: () => ProfileEditScreen(),
    ),
    GetPage(
      name: find_account_screen,
      binding: InitialBinding(),
      page: () => find_account(),
    ),
    GetPage(
      name: language_screen,
      binding: InitialBinding(),
      page: () => LanguageScreen(),
    ),
    GetPage(
      name: about_us_screen,
      binding: InitialBinding(),
      page: () => AboutUsScreen(),
    ),
    GetPage(
      name: terms_conditon_screen,
      binding: InitialBinding(),
      page: () => TermsConditionScreen(),
    ),
    GetPage(
      name: privacy_policy_screen,
      binding: InitialBinding(),
      page: () => PrivacyPolicyScreen(),
    ),
    GetPage(
      name: unlock_rewards_screen,
      binding: InitialBinding(),
      page: () => UnlockRewardsScreen(),
    ),
    GetPage(
      name: interactive_reading_screen,
      binding: InitialBinding(),
      page: () => InteractiveReadingScreen(),
    ),
    GetPage(
      name: smart_writing_screen,
      binding: InitialBinding(),
      page: () => SmartWritingScreen(),
    ),
    GetPage(
      name: native_speaking_skill_screen,
      binding: InitialBinding(),
      page: () => NativeSpeakingScreen(),
    ),
    GetPage(
      name: interactive_reading_task1,
      binding: InitialBinding(),
      page: () => TaskOne(),
    ),
    GetPage(
      name: sight_word_scrren,
      binding: InitialBinding(),
      page: () => SightWordPracticeScreen(),
    ),
    GetPage(
      name: interactive_task3_screen,
      binding: InitialBinding(),
      page: () => InteractiveTaskThreeScreen(),
    ),
    GetPage(
      name: interactive_task4_screen,
      binding: InitialBinding(),
      page: () => InteractiveTaskFourScreen(),
    ),
    GetPage(
      name: signupGmail_screen,
      binding: InitialBinding(),
      page: () => signupGmail(),
    ),
    GetPage(
      name: home_screen,
      binding: InitialBinding(),
      page: () => HomeScreen(),
    ),
    GetPage(
      name: presentationPractice_screen,
      binding: InitialBinding(),
      page: () => presentationPractice(),
    ),
    GetPage(
      name: EnglishAdultPractice_screen,
      binding: InitialBinding(),
      page: () => EnglishAdultPractice(),
    ),
    GetPage(
      name: HandwritingPractice_screen,
      binding: InitialBinding(),
      page: () => HandwritingPractice(),
    ),
    GetPage(
      name: powerWordsPlus_screen,
      binding: InitialBinding(),
      page: () => powerWordsPlus(),
    ),
    GetPage(
      name: PrecisionDrill_screen,
      binding: InitialBinding(),
      page: () => PrecisionDrill(),
    ),
    GetPage(
      name: ContextSpin_screen,
      binding: InitialBinding(),
      page: () => ContextSpin(),
    ),
    GetPage(
      name: flowChain_screen,
      binding: InitialBinding(),
      page: () => flowChain(),
    ),
    GetPage(
      name: auditoryDiscrimination_screen,
      binding: InitialBinding(),
      page: () => auditoryDiscrimination(),
    ),
    GetPage(
      name: phonemeGraphemeMapping_screen,
      binding: InitialBinding(),
      page: () => phonemeGraphemeMapping(),
    ),
    GetPage(
      name: phraseMaker_screen,
      binding: InitialBinding(),
      page: () => phraseMaker(),
    ),
    GetPage(
      name: sentenceBuilder_screen,
      binding: InitialBinding(),
      page: () => sentenceBuilder(),
    ),
    GetPage(
      name: wordFlash_screen,
      binding: InitialBinding(),
      page: () => wordFlash(),
    ),
    GetPage(
      name: wordPartsWorkshop_screen,
      binding: InitialBinding(),
      page: () => wordPartsWorkshop(),
    ),
    GetPage(
      name: nativeOneScreen,
      binding: InitialBinding(),
      page: () => NaviteTaskOne(),
    ),
    GetPage(
      name: nativeTwoScreen,
      binding: InitialBinding(),
      page: () => NativeTaskTwo(),
    ),
    GetPage(
      name: nativeThreeScreen,
      binding: InitialBinding(),
      page: () => NativeTaskThree(),
    ),
    GetPage(
      name: nativeFourScreen,
      binding: InitialBinding(),
      page: () => NativeTaskFour(),
    ),
  ];
}
