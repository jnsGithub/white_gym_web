import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/data/service/sign.dart';

class FindPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  Sign sign = Sign();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}