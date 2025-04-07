import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/membership/controllers/membership_management_controller.dart';

class MembershipBinding implements Bindings {
  @override
  void dependencies() {
    // Add your dependencies here
    Get.put<MembershipManagementController>(MembershipManagementController());
  }
}