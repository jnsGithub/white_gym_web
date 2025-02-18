import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/view/user/addMembershipView.dart';
import 'package:white_gym_web/view/user/userManagementController.dart';
import 'package:white_gym_web/view/user/userManagementView.dart';

class UserView extends GetView<UserManagementController> {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isAddView.value ? AddMembershipView() : UserManagementView());
  }
}
