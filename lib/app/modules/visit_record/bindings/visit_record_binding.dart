import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/visit_record/controllers/visit_record_controller.dart';

class VisitRecordBinding implements Bindings {
  @override
  void dependencies() {
    // Add your dependencies here
    Get.lazyPut<VisitRecordController>(() {
      return VisitRecordController();
    });
  }
}