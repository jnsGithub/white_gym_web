import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/util/sign.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementController.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementView.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementController.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementView.dart';
import 'package:white_gym_web/view/staff/staffManagementView.dart';
import 'package:white_gym_web/view/user/userManagementView.dart';



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
  RxList menuWidget = [UserManagementView(),StaffManagementView(),UserManagementView(),SpotManagementView(), MembershipManagementView(), Scaffold()].obs;

  //[UserPage(),StorePage(),PaymentPage(),CalculatePage()];
  RxInt menuIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    permissionCheck();
  }
  @override
  void onClose(){
    super.onClose();
  }

  void permissionCheck() {
    switch(myInfo.value.position){
      case '매니저':
        menuItem = ['Main','회원 관리','멤버쉽 관리', '로그아웃'].obs;
        menuIcon = [
          Symbols.home,
          Symbols.person,
          Symbols.shoppingmode,
          Symbols.logout
        ].obs;
        menuWidget = [UserManagementView(), UserManagementView(), MembershipManagementView(), Scaffold()].obs;
        break;
      case '인포':
        menuItem = ['Main', '회원 관리', '로그아웃'].obs;
        menuIcon = [
          Symbols.home,
          Symbols.person,
          Symbols.logout
        ].obs;
        menuWidget = [UserManagementView(), UserManagementView(), Scaffold()].obs;
        break;
      case '트레이너':
        menuItem = ['Main', '로그아웃'].obs;
        menuIcon = [
          Symbols.home,
          Symbols.logout
        ].obs;
        menuWidget = [UserManagementView(), Scaffold()].obs;
        break;
    }
  }

  changeMenu(i) {
    if(menuItem[i] == '로그아웃'){
      signOut();
      Get.offAllNamed('/signIn');
      return;
    }
    menuIndex.value = i;
    if(menuItem[i] == '지점 관리'){
      var controller = Get.find<SpotManagementController>();
      controller.clearSelectedSpot();
      controller.isDetailView.value = false;
      controller.isUpdate = false;
    }
    else if(menuItem[i] == '이용권 관리'){
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
