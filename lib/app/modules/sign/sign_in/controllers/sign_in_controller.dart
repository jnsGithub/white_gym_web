import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:white_gym_web/app/data/service/sign.dart';
import 'package:white_gym_web/app/data/service/user_data.dart';



class LoginController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Sign sign = Sign();
  UserDataManagement userDataManagement = UserDataManagement();

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
}
