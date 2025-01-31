import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/view/spotManagement/spotDetailView.dart';
import 'package:white_gym_web/view/spotManagement/spotListView.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementController.dart';

class SpotManagementView extends GetView<SpotManagementController> {
  const SpotManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Get.lazyPut(() => SpotManagementController());
    return Obx(() =>
      controller.isDetailView.value ? SpotDetailView() : SpotListView()
    );
  }
}
