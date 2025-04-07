import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/membershipManagement/controllers/membership_management_controller.dart';
import 'package:white_gym_web/app/modules/membershipManagement/views/membership_management_detail_page.dart';
import 'package:white_gym_web/app/modules/membershipManagement/views/membership_management_list_page.dart';

class MembershipManagementPage extends GetView<MembershipManagementController> {
  const MembershipManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isDetailView.value ? MembershipManagementDetailPage() : MembershipManagementListPage());
  }
}
