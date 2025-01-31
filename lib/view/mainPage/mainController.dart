import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/util/sign.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementController.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementView.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementController.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementView.dart';
import 'package:white_gym_web/view/staff/staffManagementView.dart';



class MainController extends GetxController {
  Sign sign = Sign();

  RxList menuItem = ['Main','직원 관리','회원 관리','지점 관리', '이용권 관리', '로그아웃'].obs;
  RxList<IconData> menuIcon = [
    Symbols.home,
    Symbols.id_card,
    Symbols.person,
    Symbols.exercise,
    Symbols.shoppingmode,
    Symbols.logout
  ].obs;
  RxList menuWidget = [StaffManagementView(),StaffManagementView(),StaffManagementView(),SpotManagementView(), MembershipManagementView(), Scaffold()].obs;

  //[UserPage(),StorePage(),PaymentPage(),CalculatePage()];
  RxInt menuIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  changeMenu(i) {
    if(menuItem[i] == '로그아웃'){
      signOut();
      Get.offAllNamed('/signIn');
      return;
    }
    menuIndex.value = i;
    if(i == 3){
      var controller = Get.find<SpotManagementController>();
      print(controller);
      controller.clearSelectedSpot();
      controller.isDetailView.value = false;
      controller.isUpdate = false;
    }
    else if(i == 4){
      var controller = Get.find<MembershipManagementController>();
      controller.clearController();
      controller.isDetailView.value = false;

    }
    update();
  }

  signOut() async {
    await sign.signOut();
  }
}
