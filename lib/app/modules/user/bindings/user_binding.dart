import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/user/controllers/user_management_controller.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    // Add your dependencies here
    Get.put<UserManagementController>(UserManagementController());
  }
}
