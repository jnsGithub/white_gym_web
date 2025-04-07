import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/sign/find_password/controllers/find_password_controller.dart';

class FindPasswordBinding implements Bindings {
  @override
  void dependencies() {
    // Add your dependencies here
    Get.lazyPut<FindPasswordController>(() {
      return FindPasswordController();
    });
  }
}