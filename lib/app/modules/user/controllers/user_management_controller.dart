import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/data/service/spot.dart';
import 'package:white_gym_web/app/theme/app_color.dart';
import 'package:white_gym_web/global/global.dart';
import 'package:white_gym_web/app/data/models/spot.dart';
import 'package:white_gym_web/app/data/models/user_data.dart';
import 'package:white_gym_web/app/data/service/user_data.dart';
import 'package:jns_package/jns_package.dart' as jns;
import 'dart:async';

class UserManagementController extends GetxController{
  RxBool isAddView = false.obs;

  TextEditingController searchController = TextEditingController();

  TextEditingController memberShipNameController = TextEditingController();
  TextEditingController memberShipPriceController = TextEditingController();
  TextEditingController useDayController = TextEditingController();
  TextEditingController todayUseCountController = TextEditingController();
  TextEditingController pauseCountController = TextEditingController();

  UserDataManagement userDataManagement = UserDataManagement();
  SpotManagement spotManagement = SpotManagement();

  RxList<UserData> userDataList = <UserData>[].obs;
  RxList<UserData> userDataListView = <UserData>[].obs;

  RxList<Spot> mySpotList = <Spot>[].obs;

  RxInt a = 0.obs;
  RxInt selectedPage = 1.obs;

  RxList<Spot> spotList = <Spot>[].obs;
  Rx<Spot> selectedSpot = Spot(
    documentId: '',
    name: '전체',
    address: '',
    addressDetail: '',
    descriptions: '',
    imageUrlList: <String>[].obs,
    lat: 0,
    lon: 0,
    createDate: DateTime.now(),
    devSnList: [],
  ).obs;

  late UserData addUserData;

  @override
  void onInit() {
    print('UserManagementController onInit');
    super.onInit();
    init();//unawaited(init());
  }

  @override
  void onClose() {
    super.onClose();
  }


  updateUserDate(UserData userData) async {
    await userDataManagement.updateUserTicket(userData, false);
    init();
    update();
  }

  init() async {
    print('전체유저 조회');
    print(await userDataManagement.getAllUsersLength());
    await getUserDataList();
    await getSpotList();

    userListSort();
    // userDataListView.value = userDataList.where((element) => element.ticket.spotDocumentId.contains(selectedSpot.value.documentId)).toList();// && element.ticket.paymentBranch != '').toList();
    // mySpotList.value = myInfo.value.position == '마스터' ? spotList : spotList.where((element) => myInfo.value.spotIdList.contains(element.documentId)).toList();
    // if(mySpotList.length > 1){
    //   mySpotList.insert(0, Spot.empty());
    //   if(myInfo.value.position != '마스터'){
    //     spotList.insert(0, Spot.empty());
    //   }
    // }
    // else{
    //   selectedSpot.value = mySpotList[0];
    //   spotList.insert(0, Spot.empty());
    // }
    // a.value = userDataListView.length - ((selectedPage.value-1) * 10) > 10 ? 10 : userDataListView.length - ((selectedPage.value-1) * 10);//userDataListView.length > 10 ? 10 : userDataListView.length;
    // update();
  }

  userListSort() {
    userDataListView.value = userDataList.where((element) => element.ticket.spotDocumentId.contains(selectedSpot.value.documentId)).toList();// && element.ticket.paymentBranch != '').toList();
    mySpotList.value = myInfo.value.position == '마스터' ? spotList : spotList.where((element) => myInfo.value.spotIdList.contains(element.documentId)).toList();
    if(mySpotList.length > 1){
      mySpotList.insert(0, Spot.empty());
      if(myInfo.value.position != '마스터'){
        spotList.insert(0, Spot.empty());
      }
    }
    else{
      selectedSpot.value = mySpotList[0];
      spotList.insert(0, Spot.empty());
    }
    a.value = userDataListView.length - ((selectedPage.value-1) * 10) > 10 ? 10 : userDataListView.length - ((selectedPage.value-1) * 10);
    //userDataListView.length > 10 ? 10 : userDataListView.length;
    update();
  }

  searchUserList() {
    try{
      selectedPage.value = 1;
      if(searchController.text.isEmpty){
        userDataListView.value = userDataList.where((element) => element.ticket.spotDocumentId.contains(selectedSpot.value.documentId) && element.ticket.paymentBranch != '').toList();
      }
      else{
        userDataListView.value = userDataList.where((element) => element.name.contains(searchController.text)).toList();// && element.ticket.spotDocumentId.contains(selectedSpot.value.documentId)).toList();
      }
      a.value = userDataListView.length - ((selectedPage.value-1) * 10) > 10 ? 10 : userDataListView.length - ((selectedPage.value-1) * 10);//userDataListView.length > 10 ? 10 : userDataListView.length;
      update();
    } catch(e){
      print(e);
    }
  }

  Future<void> getUserDataList() async {
    userDataList.value = await userDataManagement.getUserDataList();
    // List<UserData> temp = await userDataManagement.getUserDataList();
    // List<UserData> temp2 = [];
    // if(myInfo.value.position != '마스터') {
    //   for(var i in myInfo.value.spotIdList){
    //     temp2 = temp2 + temp.where((element) => element.ticket.spotDocumentId == i).toList();
    //   }
    // }
    // else{
    //   temp2 = temp;
    // }
    // userDataList.value = temp2;
  }

  int useDayCalculation(UserData userData) {
    int useDay = 0;
    if(userData.ticket.status){
      useDay = userData.ticket.endDate.difference(DateTime.now()).inDays;
    }
    else{
      useDay = userData.ticket.pauseStartDate.last.difference(DateTime.now()).inDays;
    }
    return useDay;
  }

  Future<void> getSpotList() async {
    spotList.value = await spotManagement.getSpotList();
  }

  addUserDialog(BuildContext context, Size size, UserData? userData, UserManagementController controller){
    late Rx<UserData> user;
    bool readOnly = false;
    Rx<Spot> selectedSpot = Spot.empty().obs;
    print(readOnly);
    RxList<Spot> spotList = <Spot>[].obs;
    spotList.assignAll(mySpotList);

    if(spotList.length > 1){
      spotList.removeAt(0);
    }

    selectedSpot.value = spotList[0];

    if(userData == null) {
      user = UserData.empty().obs;
      user.value.ticket.paymentBranch = selectedSpot.value.name;
      user.value.ticket.spotDocumentId = selectedSpot.value.documentId;
      user.value.gender = 1;
    }
    else{
      user = userData.obs;
      readOnly = true;
    }

    // spotList.removeAt(0);
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    nameController.text = user.value.name;
    phoneController.text = user.value.phone;
    String tempPhone = user.value.phone;

    TextStyle titleTextStyle = TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700);
    TextStyle subTitleTextStyle = TextStyle(fontSize: 17, color: gray600, fontWeight: FontWeight.w500);
    TextStyle contentTextStyle = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500);

    showDialog(context: (context), builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titlePadding: EdgeInsets.only(top: 33, left: 40, right: 28, bottom: 0),
        contentPadding: EdgeInsets.only(top: 35, left: 40, right: 50, bottom: 0),
        title: SizedBox(
          width: 392,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Row(
                children: [
                  Text('회원 추가', style: titleTextStyle),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){Get.back();},
                  )
                ],
              ),
              Text.rich(
                TextSpan(
                    children: [
                      TextSpan(text: '회원 정보를 입력하고, ', style: subTitleTextStyle),
                      TextSpan(text: '저장 버튼', style: TextStyle(fontSize: 17, color: mainColor, fontWeight: FontWeight.w500)),
                      TextSpan(text: '을 눌러주세요', style: subTitleTextStyle)
                    ]
                ),
              )
            ],
          ),
        ),
        content: SizedBox(
          width: 392,
          height: 480,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('결제 지점', style: contentTextStyle,),
                  Spacer(),
                  Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,

                      hint: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          '${userData == null ? selectedSpot.value.name : user.value.ticket.paymentBranch}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      items: spotList
                          .map((element) => DropdownMenuItem<String>(
                        value: element.documentId,
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            element.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )).toList(),
                      // value: value,
                      onChanged: readOnly ? null : (String? value) {
                        print(value);
                        if (value != null) {
                          selectedSpot.value = spotList.firstWhere((element) => element.documentId == value);

                          user.update((val) {
                            val?.ticket.spotDocumentId = selectedSpot.value.documentId;
                            val?.ticket.paymentBranch = selectedSpot.value.name;
                          });

                          print(user.value.ticket.paymentBranch); // 변경된 값 출력
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          color: readOnly ? gray200 : bg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: 282,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('이름', style: contentTextStyle,),
                  Spacer(),
                  Container(
                    width: 282,
                    height: 50,
                    decoration: BoxDecoration(
                      color: readOnly ? gray200 : bg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextField(
                      readOnly: readOnly,
                      controller: nameController,
                      onChanged: (value){
                        if(value.contains(' ')){
                          nameController.text = value.replaceAll(' ', '');
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('전화번호', style: contentTextStyle,),
                        SizedBox(height: 30,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 282,
                          height: 50,
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onChanged: (value){
                              tempPhone = value;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('중복된 전화번호는 가입이 불가능합니다.', style: TextStyle(fontSize: 14, color: gray500, fontWeight: FontWeight.w500),)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('성별', style: contentTextStyle,),
                  Spacer(),
                  Obx(() => DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          textAlign: TextAlign.left,
                          user.value.gender == 1 ? '남성' : '여성',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        items: [
                          DropdownMenuItem(child: Text('남성'), value: 1,),
                          DropdownMenuItem(child: Text('여성'), value: 0,),
                        ],
                        onChanged: (value){
                          print(value);
                          user.update((val) {
                            val!.gender = value!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: 282,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('마케팅\n수신동의', style: contentTextStyle,),
                  Spacer(),
                  Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        textAlign: TextAlign.left,
                        user.value.smsAlarm ? 'O' : 'X',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(child: Text('O'), value: true,),
                        DropdownMenuItem(child: Text('X'), value: false,),
                      ],
                      onChanged: readOnly ? null : (value){
                        user.update((val) {
                          val!.smsAlarm = value! as bool;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          color: readOnly ? gray200 : bg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: 282,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                  )
                ],
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  jns.ConfirmButton(
                    radius: 8,
                    color: mainColor,
                    text: '저장',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    width: 94,
                    height: 40,
                    onPressed: () async {
                      if(nameController.text.isEmpty || phoneController.text.isEmpty){
                        Get.snackbar('회원 추가 실패', '모든 항목을 입력해주세요.');
                        return;
                      }
                      if(userData == null){
                        user.value.name = nameController.text;
                        user.value.phone = tempPhone;
                        if(!await userDataManagement.addUserData(user.value)){
                          return;
                        }
                      }
                      else{
                        user.update((val) {
                          val!.phone = tempPhone;
                        });
                        if(!await userDataManagement.updateUserData(user.value)){
                          return;
                        }
                      }
                      userDataList.insert(0, user.value);
                      userListSort();
                      // controller.init();
                      Get.back();
                      if(!Get.isSnackbarOpen) {
                        Get.snackbar(
                            '저정 완료',
                            '저장이 완료되었습니다.');
                      }
                      },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  pauseAndCancelDialog(BuildContext context, UserData userData, Size size){
    showDialog(context: (context), builder: (context){
      return jns.Dialog(
          topPadding: 80,
          bottomPadding: 80,
          width: 442,
          radius: 20,
          height: 78,
          title: userData.ticket.subscribe ? '구독권을 해지하시겠습니까?' : userData.ticket.status ? '해당 회원의 이용권을\n일시정지 하시겠습니까?' : '해당 회원의 이용권을\n재개 하시겠습니까?',
          titleFontSize: 20,
          subTitle: userData.ticket.subscribe ? '(구독 해지 후 되돌릴 수 없습니다.)' : null,
          subTitleTextColor: Colors.red,
          onPressedOK: () async {
            DateTime Date = DateTime.now();
            if(userData.ticket.status) {
              if (userData.ticket.subscribe) {
                userData.ticket.status = false;
                userData.ticket.subscribe = true;
                print(123123);
                await userDataManagement.updateUserTicket(userData, false);
              } else {
                userData.ticket.status = false;
                userData.ticket.pauseStartDate.add(DateTime(Date.year, Date.month, Date.day, 0, 0, 0));
                userData.ticket.pauseEndDate.add(DateTime(Date.year, Date.month, Date.day + 29, 0, 0, 0));
                await userDataManagement.updateUserTicket(userData, true);
              }
            }
            else if(!userData.ticket.subscribe && !userData.ticket.status){
              userData.ticket.status = true;
              print('-----------------------');
              print(DateTime(Date.year, Date.month, Date.day , 0, 0, 0).difference(DateTime(Date.year, Date.month, Date.day, 0, 0, 0)).inDays);
              print(userData.ticket.endDate.add(Duration(days: DateTime(Date.year, Date.month, Date.day + 1, 0, 0, 0).difference(Date).inDays)));
              print(userData.ticket.pauseStartDate.last);
              userData.ticket.endDate = userData.ticket.endDate.add(Duration(days: DateTime(Date.year, Date.month, Date.day, 0, 0, 0).difference(userData.ticket.pauseStartDate.last).inDays));
              print(userData.ticket.endDate);
              await userDataManagement.updateUserTicket(userData, false);
            }
            init();
            Get.back();
            update();
          },
          onPressedCancel: (){Get.back();},
          size: size
      );
    });
  }
}