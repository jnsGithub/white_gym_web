
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/staff.dart';




class StaffManagementController extends GetxController with GetTickerProviderStateMixin {

  TextEditingController searchController = TextEditingController();
  RxList<Staff> staffList = <Staff>[
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '트레이너', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '인포', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '매니저', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '지점장', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '트레이너', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '인포', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '매니저', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '지점장', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '트레이너', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '인포', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '매니저', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '지점장', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '트레이너', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '인포', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '매니저', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '지점장', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '트레이너', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '인포', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '매니저', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '지점장', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '트레이너', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '인포', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '매니저', createDate: DateTime.now(), isApproved: false),
    Staff(documentId: 'documentId', email: 'email', name: 'name', spotIdList: [], hp: '010-0101-0101', position: '지점장', createDate: DateTime.now(), isApproved: false),


  ].obs;
  RxList<Staff> selectedStaffList = <Staff>[].obs;

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
  void onClose(){

    super.onClose();
  }
  init() {
    approvedList.value = staffList.where((element) => element.isApproved == false).toList();
    trainerList.value = staffList.where((element) => element.position == '트레이너').toList();
    infoList.value = staffList.where((element) => element.position == '인포').toList();
    managerList.value = staffList.where((element) => element.position == '매니저').toList();
    spotOwner.value = staffList.where((element) => element.position == '지점장').toList();
    selectedStaffList.value = approvedList;
  }

  currentUserChange(value){
    if(value == 0){
      selectedStaffList.value = approvedList;
    }else if(value == 1){
      selectedStaffList.value = trainerList;
    }else if(value == 2){
      selectedStaffList.value = infoList;
    }else if(value == 3){
      selectedStaffList.value = managerList;
    }else if(value == 4){
      selectedStaffList.value = spotOwner;
    }
  }

  Widget staffTypeTab(size){
    return Container(
      width: size,
      height: 40,
      decoration: const BoxDecoration(

          border: Border(
            bottom: BorderSide(color: gray100),
          )
      ),
      child: TabBar(
        onTap: (value){
          currentUserChange(value);
        },
        controller: tabController,
        tabs: myTabs,
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
}
