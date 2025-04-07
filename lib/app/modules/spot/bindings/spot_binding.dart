import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/spot/controllers/spot_management_controller.dart';

class SpotBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SpotManagementController());
  }
}