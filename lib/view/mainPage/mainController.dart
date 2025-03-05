import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/models/staff.dart';
import 'package:white_gym_web/util/sign.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementController.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementView.dart';
import 'package:white_gym_web/view/sign/signIn/signInController.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementController.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementView.dart';
import 'package:white_gym_web/view/staff/staffManagementView.dart';
import 'package:white_gym_web/view/user/UserView.dart';
import 'package:white_gym_web/view/user/userManagementController.dart';
import 'package:white_gym_web/view/user/userManagementView.dart';
import 'package:white_gym_web/view/visitRecordManagement/visitRecordView.dart';



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
  RxList menuWidget = [VisitRecordView(),StaffManagementView(),UserView(),SpotManagementView(), MembershipManagementView(), Scaffold()].obs;

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
        menuItem = ['Main','회원 관리','이용권 관리', '로그아웃'].obs;
        menuIcon = [
          Symbols.home,
          Symbols.person,
          Symbols.shoppingmode,
          Symbols.logout
        ].obs;
        menuWidget = [VisitRecordView(), UserView(), MembershipManagementView(), Scaffold()].obs;
        break;
      case '인포':
        menuItem = ['Main', '회원 관리', '로그아웃'].obs;
        menuIcon = [
          Symbols.home,
          Symbols.person,
          Symbols.logout
        ].obs;
        menuWidget = [VisitRecordView(), UserView(), Scaffold()].obs;
        break;
      case '트레이너':
        menuItem = ['Main', '로그아웃'].obs;
        menuIcon = [
          Symbols.home,
          Symbols.logout
        ].obs;
        menuWidget = [VisitRecordView(), Scaffold()].obs;
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
      controller.clearTextEditingController();
      controller.isDetailView.value = false;
    }
    else if(menuItem[i] == '회원 관리'){
      var controller = Get.find<UserManagementController>();
      controller.isAddView.value = false;
    }
    update();
  }

  signOut() async {
    myInfo = Staff(
      documentId: '',
      name: '',
      email: '',
      position: '',
      hp: '',
      spotIdList: [],
      createDate: DateTime.now(),
      isApproved: false,
    ).obs;
    await sign.signOut();
  }
}
