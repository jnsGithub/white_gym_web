import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/models/userData.dart';
import 'package:white_gym_web/util/spotManagement.dart';
import 'package:white_gym_web/util/userDataManagement.dart';
import 'package:jns_package/jns_package.dart' as jns;

class UserManagementController extends GetxController{
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
  ).obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    await getUserDataList();
    await getSpotList();

    userDataListView.value = userDataList.where((element) => element.ticket.spotDocumentId.contains(selectedSpot.value.documentId)).toList();
    mySpotList.value = myInfo.value.position == '마스터' ? spotList : spotList.where((element) => myInfo.value.spotIdList.contains(element.documentId)).toList();
    mySpotList.insert(0, Spot.empty());
  }

  searchUserList() {
    userDataListView.value = userDataList.where((element) => element.name.contains(searchController.text) && element.ticket.spotDocumentId.contains(selectedSpot.value.documentId)).toList();
  }

  Future<void> getUserDataList() async {
    List<UserData> temp = await userDataManagement.getUserDataList();
    List<UserData> temp2 = [];
    if(myInfo.value.position != '마스터') {
      for(var i in myInfo.value.spotIdList){
        temp2 = temp2 + temp.where((element) => element.ticket.spotDocumentId == i).toList();
      }
    }
    else{
      temp2 = temp;
    }
    userDataList.value = temp2;
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

  addUserDialog(BuildContext context, Size size, UserData? userData){
    late Rx<UserData> user;
    bool readOnly = false;
    if(userData == null) {
      user = UserData.empty().obs;
    }
    else{
      user = userData.obs;
      readOnly = true;
    }
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    nameController.text = user.value.name;
    phoneController.text = user.value.phone;
    String tempPhone = '';

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
                          '${user.value.ticket.paymentBranch}',
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
                          final selectedSpot = spotList.firstWhere((element) => element.documentId == value);

                          user.update((val) {
                            val?.ticket.spotDocumentId = selectedSpot.documentId;
                            val?.ticket.paymentBranch = selectedSpot.name;
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
                          user.value.gender == 0 ? '남성' : '여성',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        items: [
                          DropdownMenuItem(child: Text('남성'), value: 0,),
                          DropdownMenuItem(child: Text('여성'), value: 1,),
                        ],
                        onChanged: readOnly ? null : (value){
                          user.update((val) {
                            val!.gender = value! as int;
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
                      if(userData == null){
                        user.value.name = nameController.text;
                        user.value.phone = tempPhone;
                        print(user);
                        print(user.value.ticket.spotItem);
                        userDataManagement.addUserData(user.value, );
                      }
                      else{

                      }
                      Get.back();
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
          title: userData.ticket.subscribe ? '구독권을 해지하시겠습니까?' : '해당 회원의 이용권을\n일시정지 하시겠습니까?',
          titleFontSize: 20,
          subTitle: userData.ticket.subscribe ? '(구독 해지 후 되돌릴 수 없습니다.)' : null,
          subTitleTextColor: Colors.red,
          onPressedOK: (){
            if(userData.ticket.subscribe){

            }else{

            }
          },
          onPressedCancel: (){Get.back();},
          size: size
      );
    });
  }
}