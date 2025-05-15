import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:white_gym_web/app/data/models/temp/staff.dart';
import 'package:white_gym_web/app/data/service/sign.dart';
import 'package:white_gym_web/app/modules/membership/controllers/membership_management_controller.dart';
import 'package:white_gym_web/app/modules/membership/views/membership_management_page.dart';
import 'package:white_gym_web/app/modules/spot/controllers/spot_management_controller.dart';
import 'package:white_gym_web/app/modules/spot/views/spot_management_page.dart';
import 'package:white_gym_web/app/modules/staff/views/staff_management_page.dart';
import 'package:white_gym_web/app/modules/user/views/user_management_page.dart';
import 'package:white_gym_web/app/modules/visit_record/views/visit_record_page.dart';
import 'package:white_gym_web/app/routes/app_routes.dart';
import 'package:white_gym_web/global/global.dart';
import 'package:white_gym_web/app/data/models/temp/spot.dart';



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
  RxList menuWidget = [VisitRecordPage(),StaffManagementPage(),UserManagementPage(),SpotManagementPage(), MembershipManagementPage(), Scaffold()].obs;

  //[UserPage(),StorePage(),PaymentPage(),CalculatePage()];
  int menuIndex = 0;

  @override
  void onInit() {
    super.onInit();
    permissionCheck();
    switch(Get.currentRoute){
      case Routes.MAIN_HOME_PAGE:
        menuIndex = 0;
        break;
      case Routes.STAFF_PAGE:
        menuIndex = 1;
        break;
      case Routes.USER_PAGE:
        menuIndex = 2;
        break;
      case Routes.SPOT_PAGE:
        menuIndex = 3;
        break;
      case Routes.MEMBERSHIP_PAGE:
        menuIndex = 4;
        break;
      default:
        menuIndex = 0;
    }
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
        menuWidget = [VisitRecordPage(), UserManagementPage(), MembershipManagementPage(), Scaffold()].obs;
        break;
      case '인포':
        menuItem = ['Main', '회원 관리', '로그아웃'].obs;
        menuIcon = [
          Symbols.home,
          Symbols.person,
          Symbols.logout
        ].obs;
        menuWidget = [VisitRecordPage(), UserManagementPage(), Scaffold()].obs;
        break;
      case '트레이너':
        menuItem = ['Main', '로그아웃'].obs;
        menuIcon = [
          Symbols.home,
          Symbols.logout
        ].obs;
        menuWidget = [VisitRecordPage(), Scaffold()].obs;
        break;
    }
  }

  changeMenu(i) async {
    if(menuItem[i] == '로그아웃'){
      signOut();
      Get.offAllNamed(Routes.SIGN_IN_PAGE);
      menuIndex = 0;
      return;
    }
    menuIndex = i;

    if(menuItem[i] == '지점 관리'){
      await Get.toNamed(Routes.SPOT_PAGE);
      var controller = Get.find<SpotManagementController>();
      controller.clearSelectedSpot();
      controller.isDetailView.value = false;
      controller.isUpdate = false;
    }
    else if(menuItem[i] == '이용권 관리'){
      await Get.toNamed(Routes.MEMBERSHIP_PAGE);
      var controller = Get.find<MembershipManagementController>();
      controller.clearTextEditingController();
      controller.isDetailView.value = false;
    }
    else if(menuItem[i] == '회원 관리'){
      await Get.toNamed(Routes.USER_PAGE);
      // var controller = Get.find<UserManagementController>();
      // controller.isAddView.value = false;
    }
    else if(menuItem[i] == 'Main'){
      await Get.toNamed(Routes.MAIN_HOME_PAGE);
    }
    else if(menuItem[i] == '직원 관리'){
      await Get.toNamed(Routes.STAFF_PAGE);
      // var controller = Get.find<StaffManagementController>();
      // controller.clearTextEditingController();
      // controller.isDetailView.value = false;
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
