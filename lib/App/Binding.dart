import 'package:get/get.dart';
import 'package:manifex/Presentation/language/controller/language_controller.dart';
import 'package:manifex/Presentation/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:manifex/Presentation/profile_edit/controller/profile_edit_controller.dart';
import 'package:manifex/Presentation/terms_condition/controller/terms_conditon_controller.dart';
import 'package:manifex/Presentation/unlock_rewards/controller/unlock_rewards_controller.dart';
import '../Presentation/Authentication/Forget_password/Change_password/Controller/Controller.dart';
import '../Presentation/Authentication/Forget_password/OTP_verification/Controller/Controller.dart';
import '../Presentation/Authentication/Forget_password/find_account/Controller/Controller.dart';
import '../Presentation/Authentication/Login/Controller/Controller.dart';
import '../Presentation/Authentication/SignUp/Controller/Controller.dart';
import '../Presentation/On_boarding/Controller/Controller.dart';
import '../Presentation/Splash/Controller/Controller.dart';
import '../Presentation/about_us/controller/about_us_controller.dart';
import '../Presentation/all_course/interactive_reading/controller/interactive_reading_controller.dart';
import '../Presentation/all_course/native_speaking/controller/native_speaking_skill_controller.dart';
import '../Presentation/all_course/practices/controller/practices_controller.dart';
import '../Presentation/all_course/practices/controller/toggle_tab_controller.dart';
import '../Presentation/all_course/smart_writing/controller/smart_writing_controller.dart';
import '../Presentation/bottom_navbar/controllers/bottom_navbar_controller.dart';
import '../Presentation/profile/controller/profile_controller.dart';
import '../Presentation/progress/controllers/progress_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<on_boarding_controller>(() => on_boarding_controller(), fenix: true);
    Get.lazyPut<login_controller>(() => login_controller(), fenix: true);
    Get.lazyPut<signup_controller>(() => signup_controller(), fenix: true);
    Get.lazyPut<BottomNavbarController>(() => BottomNavbarController(), fenix: true);
    Get.lazyPut<PracticesController>(() => PracticesController(), fenix: true);
    Get.lazyPut<ProgressController>(() => ProgressController(), fenix: true);
    Get.lazyPut<find_account_controller>(() => find_account_controller(), fenix: true);
    Get.lazyPut<OTP_verification_controller>(() => OTP_verification_controller(), fenix: true);
    Get.lazyPut<reset_password_controller>(() => reset_password_controller(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<ProfileEditController>(() => ProfileEditController(), fenix: true);
    Get.lazyPut<LanguageController>(() => LanguageController(), fenix: true);
    Get.lazyPut<AboutUsController>(() => AboutUsController(), fenix: true);
    Get.lazyPut<TermsConditonController>(() => TermsConditonController(), fenix: true);
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController(), fenix: true);
    Get.lazyPut<UnlockRewardsController>(() => UnlockRewardsController(), fenix: true);
    Get.lazyPut<InteractiveReadingController>(() => InteractiveReadingController(), fenix: true);
    Get.lazyPut<ToggleTabController>(() => ToggleTabController(), fenix: true);
    Get.lazyPut<SmartWritingController>(() => SmartWritingController(), fenix: true);
    Get.lazyPut<NativeSpeakingSkillController>(() => NativeSpeakingSkillController(), fenix: true);



  }
}
