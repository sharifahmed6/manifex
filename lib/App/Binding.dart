import 'package:get/get.dart';
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



  }
}
