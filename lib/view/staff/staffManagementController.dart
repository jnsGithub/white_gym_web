
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/models/staff.dart';
import 'package:white_gym_web/util/spotManagement.dart';
import 'package:white_gym_web/util/staffManagement.dart';
import 'package:jns_package/jns_package.dart' as jns;



class StaffManagementController extends GetxController with GetTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  StaffManagement staffManagement = StaffManagement();
  SpotManagement spotManagement = SpotManagement();

  RxList<Staff> staffList = <Staff>[].obs;
  RxList<Staff> selectedStaffList = <Staff>[].obs;
  List<Spot> spotList = [];

  RxInt selectedPageNumber = 1.obs;
  RxInt a = 0.obs;

  RxList<Staff> approvedList = <Staff>[].obs;
  RxList<Staff> trainerList = <Staff>[].obs;
  RxList<Staff> infoList = <Staff>[].obs;
  RxList<Staff> managerList = <Staff>[].obs;
  RxList<Staff> spotOwner = <Staff>[].obs;
  List<Tab> myTabs = [
    const Tab(text: '직원 승인대기'),
    const Tab(text: '트레이너'),
    const Tab(text: '인포'),
    const Tab(text: '매니저'),
    const Tab(text: '지점장'),
  ];
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    await getUserDataList();

    approvedList.value = staffList.where((element) => element.isApproved == false).toList();
    trainerList.value = staffList.where((element) => element.isApproved == true && element.position == '트레이너').toList();
    infoList.value = staffList.where((element) => element.isApproved == true && element.position == '인포').toList();
    managerList.value = staffList.where((element) => element.isApproved == true && element.position == '매니저').toList();
    spotOwner.value = staffList.where((element) => element.isApproved == true && element.position == '지점장').toList();
    selectedStaffList.value = approvedList;
    a.value = selectedStaffList.length > 10 ? 10 : selectedStaffList.length;
    print(selectedStaffList.length);
  }

  void searchStaff() {
    selectedStaffList.value = staffList.where((element) => element.name.contains(searchController.text) && element.position == myTabs[tabController.index].text).toList();
    a.value = selectedStaffList.length > 10 ? 10 : selectedStaffList.length;
  }

  Future<void> getUserDataList() async {
    List<Staff> temp = await staffManagement.getStaffList();
    spotList = await spotManagement.getSpotList();
    if (myInfo.value.position != '마스터') {
      for (int i = 0; i < myInfo.value.spotIdList.length; i++) {
        staffList.value = temp.where((element) =>
            element.spotIdList.contains(myInfo.value.spotIdList[i])).toList();
      }
    }
    else {
      staffList.value = temp;
    }
  }

  currentUserChange(value) {
    if (value == 0) {
      selectedStaffList.value = approvedList;
    } else if (value == 1) {
      selectedStaffList.value = trainerList;
    } else if (value == 2) {
      selectedStaffList.value = infoList;
    } else if (value == 3) {
      selectedStaffList.value = managerList;
    } else if (value == 4) {
      selectedStaffList.value = spotOwner;
    }
    a.value = selectedStaffList.length > 10 ? 10 : selectedStaffList.length;
  }

  Widget staffTypeTab(size) {
    return Container(
      width: size,
      height: 40,
      decoration: const BoxDecoration(

          border: Border(
            bottom: BorderSide(color: gray100),
          )
      ),
      child: TabBar(
        onTap: (value) {
          currentUserChange(value);
        },
        controller: tabController,
        tabs: myInfo.value.position != '마스터' ? myTabs.where((element) =>
        element.text != '지점장').toList() : myTabs,
        labelColor: mainColor,
        unselectedLabelColor: gray300,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        dividerHeight: 0,
        indicatorColor: mainColor,
        indicator: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: mainColor,
                  width: 2
              )
          ),
        ),
      ),
    );
  }

  deleteApprovedDialog(BuildContext context, Size size, Staff selectedStaff) {
    {
      showDialog(context: (context), builder: (context) {
        return jns.Dialog(
            size: size,
            bottomPadding: 80,
            topPadding: 80,
            width: 442,
            height: 78,
            radius: 20,
            title: '해당 직원을 삭제하시겠습니까?',
            titleFontSize: 20,
            subTitle: '(삭제 후 되돌릴 수 없습니다.)',
            subTitleFontSize: 20,
            subTitleTextColor: Colors.red,
            onPressedOK: () async {
              await staffManagement.deleteStaff(selectedStaff.documentId);
              Get.back();
              init();
            },
            onPressedCancel: () {
              Get.back();
            }
        );
      });
    }
  }
}
