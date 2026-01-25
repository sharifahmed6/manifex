import 'package:get/get.dart';
import '../Presentation/Authentication/Forget_password/Change_password/Controller/Controller.dart';
import '../Presentation/Authentication/Forget_password/OTP_verification/Controller/Controller.dart';
import '../Presentation/Authentication/Forget_password/find_account/Controller/Controller.dart';
import '../Presentation/Authentication/Login/Controller/Controller.dart';
import '../Presentation/Authentication/SignUp/Controller/Controller.dart';
import '../Presentation/On_boarding/Controller/Controller.dart';
import '../Presentation/Splash/Controller/Controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<on_boarding_controller>(() => on_boarding_controller(), fenix: true);
    Get.lazyPut<login_controller>(() => login_controller(), fenix: true);
    Get.lazyPut<signup_controller>(() => signup_controller(), fenix: true);
    Get.lazyPut<find_account_controller>(() => find_account_controller(), fenix: true);
    Get.lazyPut<OTP_verification_controller>(() => OTP_verification_controller(), fenix: true);
    Get.lazyPut<reset_password_controller>(() => reset_password_controller(), fenix: true);



  }
}
