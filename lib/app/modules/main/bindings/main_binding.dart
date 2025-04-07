import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/main/controllers/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}