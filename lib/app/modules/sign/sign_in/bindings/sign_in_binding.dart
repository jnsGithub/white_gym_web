import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/sign/sign_in/controllers/sign_in_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>((){
      return LoginController();
    }, fenix: true);
  }
}