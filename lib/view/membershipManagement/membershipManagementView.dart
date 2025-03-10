import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementDetailView.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementController.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementListView.dart';

class MembershipManagementView extends GetView<MembershipManagementController> {
  const MembershipManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isDetailView.value ? MembershipManagementDetailView() : MembershipManagementListView());
  }
}
