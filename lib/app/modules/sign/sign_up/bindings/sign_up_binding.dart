import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/sign/sign_up/controllers/sign_up_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() {
      return SignUpController();
      }, fenix: true);
  }
}