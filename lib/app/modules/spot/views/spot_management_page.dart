import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/spotManagement/controllers/spot_management_controller.dart';

import 'spot_detail_page.dart';
import 'spot_list_page.dart';

class SpotManagementPage extends GetView<SpotManagementController> {
  const SpotManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() =>
      controller.isDetailView.value ? SpotDetailPage() : SpotListPage()
    );
  }
}
