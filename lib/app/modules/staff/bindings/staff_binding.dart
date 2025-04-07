import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/staff/controllers/staff_management_controller.dart';

class StaffBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(StaffManagementController());
  }
}