import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jns_package/jns_package.dart' as jns;
import 'package:number_pagination/number_pagination.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/models/ticket.dart';
import 'package:white_gym_web/models/userData.dart';
import 'package:white_gym_web/util/toExcel.dart';
import 'package:white_gym_web/view/user/userManagementController.dart';

class UserManagementView extends GetView<UserManagementController> {
  const UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double tranSize(int num){
      return size.width * (num/1920);
    }

    double spotWidth = size.width * 0.0885;
    double nameWidth = size.width * 0.0885;
    double sexWidth = size.width * 0.0885;
    double hpWidth = size.width * 0.099;
    double createdDateWidth = size.width * 0.099;
    double itemWidth = size.width * 0.0938;
    double itemFinishWidth = size.width * 0.099;
    double marketingWidth = size.width * 0.0781;
    double moreWidth = size.width * 0.051;
    // double spotWidth = 170;
    // double nameWidth = 170;
    // double sexWidth = 170;
    // double hpWidth = 190;
    // double createdDateWidth = 190;
    // double itemWidth = 180;
    // double itemFinishWidth = 190;
    // double marketingWidth = 150;
    // double moreWidth = 98;
    return Scaffold(
      body: GetBuilder<UserManagementController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: myInfo.value.position == '마스터' ? '마스터 계정' : myInfo.value.name, style: TextStyle(fontSize: 30, color: gray900, fontWeight: FontWeight.w700)),
                            TextSpan(text: ' 님', style: TextStyle(fontSize: 26, color: gray500, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            items: controller.mySpotList.map((e) => DropdownMenuItem<String>(
                              value: e.documentId,
                              child: Text(e.name, style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w600),),
                            )).toList(),
                            hint: Text(controller.selectedSpot.value.name, style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w600),),
                            iconStyleData: IconStyleData(icon: Icon(Icons.keyboard_arrow_down_outlined, color: gray600,), iconSize: 24),
                            onChanged: controller.mySpotList.length == 1
                                ? null
                                : (String? value){
                              controller.selectedSpot.value = controller.mySpotList.firstWhere((element) => element.documentId == value);
                              controller.userDataListView.value = controller.userDataList.where((element) => element.ticket.spotDocumentId.contains(controller.selectedSpot.value.documentId)).toList();

                              controller.selectedPage.value = 1;
                              controller.a.value = controller.userDataListView.length > 10 ? 10 : controller.userDataListView.length;
                              controller.update();
                            },
                            buttonStyleData: ButtonStyleData(
                              width: 150,
                              height: 60,
                              decoration: BoxDecoration(
                                color: bg,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 25),
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('회원 관리', style: TextStyle(fontSize: 30, color: gray900, fontWeight: FontWeight.w700)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 266,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: gray300),
                        ),
                        child: TextField(
                          controller: controller.searchController,
                          decoration: InputDecoration(
                            hintText: '회원 이름으로 검색',
                            hintStyle: const TextStyle(
                                fontSize: 20,
                                color: gray300,
                                fontWeight: FontWeight.w400
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search_rounded, color: gray500,),
                              onPressed: () {
                                // search();
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            border: InputBorder.none,
                          ),
                          onChanged: (String value) async {
                            controller.searchUserList();
                            controller.update();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 30,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                maximumSize: Size(150, 40),
                                minimumSize: Size(150, 40),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: mainColor, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              ),
                              onPressed: (){
                                controller.addUserDialog(context, size, null, controller);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.person_add_alt_1_rounded, color: mainColor, size: 30,),
                                  Text('회원 추가', style: TextStyle(fontSize: 20, color: mainColor, fontWeight: FontWeight.w600),),
                                ],
                              )
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                maximumSize: Size(181, 40),
                                minimumSize: Size(181, 40),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xff0B661C), width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              ),
                              onPressed: (){
                                ToExcel().toExcel(controller.userDataListView, controller.selectedSpot.value.name);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.file_download_outlined, color: Color(0xff0B661C), size: 30,),
                                  Text('엑셀 다운로드', style: TextStyle(fontSize: 20, color: Color(0xff0B661C), fontWeight: FontWeight.w600),),
                                ],
                              )
                          ),
                          IconButton(
                            icon: Icon(Icons.refresh_outlined),
                            color: gray500,
                            onPressed: (){
                              controller.init();
                              // controller.selectedPage.value = 1;
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 61,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: spotWidth,
                              alignment: Alignment.center,
                              child: Text('지점', style: TextStyle(fontSize: tranSize(16), color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: nameWidth,
                              alignment: Alignment.center,
                              child: Text('이름', style: TextStyle(fontSize: tranSize(16), color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: sexWidth,
                              alignment: Alignment.center,
                              child: Text('성별', style: TextStyle(fontSize: tranSize(16), color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: hpWidth,
                              alignment: Alignment.center,
                              child: Text('휴대폰 번호', style: TextStyle(fontSize: tranSize(16), color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: createdDateWidth,
                              alignment: Alignment.center,
                              child: Text('가입 일자', style: TextStyle(fontSize: tranSize(16), color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: itemWidth,
                              alignment: Alignment.center,
                              child: Text('멤버쉽 이용권', style: TextStyle(fontSize: tranSize(16), color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: itemFinishWidth,
                              alignment: Alignment.center,
                              child: Text('멤버쉽 종료일', style: TextStyle(fontSize: tranSize(16), color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: marketingWidth,
                              alignment: Alignment.center,
                              child: Text('마케팅 정보\n수신동의 여부', style: TextStyle(fontSize: tranSize(16), color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: moreWidth,
                              alignment: Alignment.center,
                              child: Icon(Icons.more_vert, color: Colors.white,),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                            shrinkWrap: true,
                            itemCount: controller.a.value,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index){
                              return Divider(
                                height: 1,
                                color: gray100,
                              );
                            },
                            itemBuilder: (context, index){
                              TextEditingController memberShipNameController = TextEditingController();
                              TextEditingController memberShipPriceController = TextEditingController();
                              TextEditingController useDayController = TextEditingController();
                              TextEditingController endDateController = TextEditingController();
                              TextEditingController todayUseCountController = TextEditingController();
                              TextEditingController pauseCountController = TextEditingController();
                              TextEditingController sportswearPriceController = TextEditingController();
                              TextEditingController lockerPriceController = TextEditingController();
                              TextEditingController lockerNumberController = TextEditingController();

                              int num = (controller.selectedPage.value - 1) * 10 + index;
                              UserData user = controller.userDataListView[num].copyWith();

                              RxBool isStatus = user.ticket.endDate.isBefore(DateTime.now()).obs;
                              if(isStatus.value){
                                user.ticket = Ticket.empty();
                                user.ticket.paymentBranch = controller.userDataListView[num].ticket.paymentBranch;
                                user.ticket.spotDocumentId = controller.userDataListView[num].ticket.spotDocumentId;
                              }

                              memberShipNameController.text = user.ticket.spotItem.name;
                              memberShipPriceController.text = user.ticket.spotItem.price.toString();
                              useDayController.text = formatDate(user.ticket.createDate);
                              endDateController.text = formatDate(user.ticket.endDate);
                              todayUseCountController.text = user.ticket.admission.toString();
                              pauseCountController.text = user.ticket.pause.toString();
                              sportswearPriceController.text = '';
                              lockerPriceController.text = '';
                              lockerNumberController.text = '';


                              bool isSubscribe = user.ticket.subscribe;

                              if(isSubscribe){
                                pauseCountController.text = user.ticket.passTicket ? '전체 지점' : user.ticket.paymentBranch;
                              }
                              else{
                                int days = 0;
                                if(user.ticket.endDate.year != 1990){
                                  days = user.ticket.status ? user.ticket.endDate.difference(DateTime.now()).inDays + 2 : user.ticket.endDate.difference(user.ticket.pauseStartDate.last).inDays + 1;
                                }
                                useDayController.text = days.toString();
                                if(DateTime.now().isAfter(user.ticket.endDate)){
                                  useDayController.text = '0';
                                }
                              }

                              RxString selectedSpotName = user.ticket.passTicket ? '전체 지점'.obs : user.ticket.paymentBranch.obs;
                              RxString selectedSpotId = user.ticket.spotDocumentId.obs;

                              RxBool sportswear = user.ticket.sportswear.obs;
                              RxBool locker = user.ticket.locker.obs;

                              if(sportswear.value){
                                sportswearPriceController.text = user.ticket.spotItem.sportswear.toString();
                              }
                              if(locker.value){
                                lockerPriceController.text = user.ticket.spotItem.locker.toString();
                                lockerNumberController.text = user.ticket.lockerNum.toString();
                              }

                              return ExpansionTile(
                                    maintainState: false,
                                    tilePadding: EdgeInsets.only(right: size.width * 0.0391),
                                    collapsedShape: RoundedRectangleBorder(
                                      borderRadius: index == 9
                                          ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                                          : (index + (controller.selectedPage.value - 1) * 10) == controller.userDataListView.length - 1
                                          ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                                          : BorderRadius.zero,
                                      side: BorderSide(color: gray100, width: 1),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: index == 9
                                          ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                                          : (index + (controller.selectedPage.value - 1) * 10) == controller.userDataListView.length - 1
                                          ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                                          : BorderRadius.zero,
                                      side: BorderSide(color: gray100, width: 1),
                                    ),
                                    title: GestureDetector(
                                      onTap: (){
                                        controller.addUserDialog(context, size, user, controller);
                                      },
                                      child: Container(
                                        height: 59,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border: Border(
                                          //   left: BorderSide(color: gray100, width: 1),
                                          //   // right: BorderSide(color: gray100, width: 1),
                                          //   bottom: index == 9 ? BorderSide(color: gray100, width: 1) : index == controller.userDataListView.length - 1 ? BorderSide(color: gray100, width: 1) : BorderSide.none,
                                          // ),
                                          // borderRadius: index == 9 ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)) : index == controller.userDataListView.length - 1 ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)) : null,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: spotWidth,
                                              alignment: Alignment.center,
                                              child: Text(user.ticket.paymentBranch == '' ? '-' : user.ticket.paymentBranch, style: TextStyle(fontSize: tranSize(16), color: gray900, fontWeight: FontWeight.w600),),
                                            ),
                                            Container(
                                              width: nameWidth,
                                              alignment: Alignment.center,
                                              child: Text(
                                                user.name,
                                                style: TextStyle(fontSize: tranSize(16), color: gray900, fontWeight: FontWeight.w600),),
                                            ),
                                            Container(
                                              width: sexWidth,
                                              alignment: Alignment.center,
                                              child: Text(user.gender == 1 ? '남자' : '여자', style: TextStyle(fontSize: tranSize(16), color: gray900, fontWeight: FontWeight.w600),),
                                            ),
                                            Container(
                                              width: hpWidth,
                                              alignment: Alignment.center,
                                              child: Text(formatPhoneNumber(user.phone) , style: TextStyle(fontSize: tranSize(16), color: gray900, fontWeight: FontWeight.w600),),
                                            ),
                                            Container(
                                              width: createdDateWidth,
                                              alignment: Alignment.center,
                                              child: Text(formatDate(user.createDate), style: TextStyle(fontSize: tranSize(16), color: gray900, fontWeight: FontWeight.w600),),
                                            ),
                                            Container(
                                              width: itemWidth,
                                              alignment: Alignment.center,
                                              child: Text(user.ticket.spotDocumentId == '' || user.ticket.endDate.isBefore(DateTime.now()) ? '-' : isSubscribe ? '구독 멤버쉽' : '일반 멤버쉽', style: TextStyle(fontSize: tranSize(16), color: gray900, fontWeight: FontWeight.w600),),
                                            ),
                                            Container(
                                              width: itemFinishWidth,
                                              alignment: Alignment.center,
                                              child: Text(formatDate(user.ticket.endDate), style: TextStyle(fontSize: tranSize(16), color: gray900, fontWeight: FontWeight.w600),),
                                            ),
                                            Container(
                                              width: marketingWidth,
                                              alignment: Alignment.center,
                                              child: Text(user.smsAlarm ? 'O' : 'X', style: TextStyle(fontSize: tranSize(16), color: gray900, fontWeight: FontWeight.w600),),
                                            ),
                                            // Container(
                                            //     width: moreWidth,
                                            //     // padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 14.5),
                                            //     alignment: Alignment.center,
                                            //     child: IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down_outlined))
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    children: [
                                      Obx(() => isStatus.value// && !controller.userDataListView[num].ticket.subscribe
                                          ? Container(
                                          height: 170,
                                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                          decoration: BoxDecoration(
                                            color: gray100,
                                            border: Border(
                                              left: BorderSide(color: gray100, width: 1),
                                              right: BorderSide(color: gray100, width: 1),
                                              bottom: BorderSide(color: gray100, width: 1),
                                            ),
                                          ),
                                          child: Center(
                                              child: GestureDetector(
                                                onTap: (){
                                                  isStatus.value = !isStatus.value;
                                                  // controller.addUserData = user;
                                                  // controller.isAddView.value = true;
                                                },
                                                child: Container(
                                                    width: 245,
                                                    height: 57,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border: Border.all(color: mainColor, width: 1),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.add, color: mainColor, size: 24),
                                                        Text('일반 이용권 추가', style: TextStyle(fontSize: 24, color: mainColor, fontWeight: FontWeight.w600),),
                                                      ],
                                                    )
                                                ),
                                              )
                                          )
                                      )
                                          :  Container(
                                        height: 170,
                                        padding: EdgeInsets.symmetric(horizontal: tranSize(40), vertical: 20),
                                        decoration: BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            left: BorderSide(color: gray100, width: 1),
                                            right: BorderSide(color: gray100, width: 1),
                                            bottom: BorderSide(color: gray100, width: 1),
                                          ),
                                        ),
                                        child: Column(
                                          spacing: 20,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(isSubscribe ? '구독 멤버쉽(월 정기 결제) 정보' : '일반 멤버쉽(단건결제) 정보', style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w600),),
                                                Row(
                                                  children: [
                                                    // isSubscribe && !user.ticket.status || user.ticket.endDate.isBefore(DateTime.now()) ? Container() :
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.zero,
                                                        minimumSize: isSubscribe ? Size(102, 36) : Size(136, 36),
                                                        maximumSize: isSubscribe ? Size(102, 36) : Size(136, 36),
                                                        backgroundColor: isSubscribe && !user.ticket.status ? gray200 : Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          side: BorderSide(color: isSubscribe && user.ticket.status
                                                              ? Colors.red
                                                              : isSubscribe && !user.ticket.status
                                                              ? gray500
                                                              : !user.ticket.status
                                                              ? mainColor : Colors.red),
                                                        ),
                                                      ),
                                                      onPressed: (){
                                                        if(isSubscribe && !user.ticket.status){
                                                          print(123);
                                                          return;
                                                        }
                                                        if(!isSubscribe && user.ticket.pause < 1 && user.ticket.status){
                                                          if(!Get.isSnackbarOpen){
                                                            Get.snackbar('일시 정지 불가', '일시 정지 가능 횟수가 없습니다.');
                                                          }
                                                          return;
                                                        }
                                                        controller.pauseAndCancelDialog(context, user, size);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          if(!isSubscribe)
                                                            Icon(user.ticket.status ? Icons.pause : Icons.play_arrow, color: isSubscribe ? Colors.red : !user.ticket.status ? mainColor : Colors.red,),
                                                          if(!isSubscribe)
                                                            SizedBox(width: 9,),
                                                          Text(isSubscribe && user.ticket.status
                                                              ? '구독 해지'
                                                              : isSubscribe && !user.ticket.status
                                                              ? '구독 해지 완료'
                                                              : user.ticket.status
                                                              ? '이용권 일시 정지'
                                                              : '일시 정지 해제',
                                                            style: TextStyle(fontSize: 14, color: isSubscribe && user.ticket.status
                                                                ? Colors.red                                  // 구독 활성화 상태 컬러
                                                                : isSubscribe && !user.ticket.status
                                                                ? gray500                                     // 구독 비활성화 상태 컬러
                                                                : !user.ticket.status
                                                                ? mainColor                                   // 비구독권 비활성화 상태 컬러
                                                                : Colors.red, fontWeight: FontWeight.w500),), // 비구독권 활성화 상태 컬러
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10,),
                                                    jns.ConfirmButton(
                                                      onPressed: () async { // TODO: 저장버튼 구현해야함.
                                                        try{
                                                          UserData userData = user.copyWith();

                                                          print(userData.documentId);
                                                          print('-----------------------------------------');
                                                          // userData.ticket = controller.userDataListView[num].ticket;
                                                          if(userData.ticket.subscribe){
                                                            userData.ticket.lockerNum = userData.ticket.lockerNum == '' ? 0 :  int.parse(lockerNumberController.text);
                                                            controller.userDataManagement.updateUserTicket(userData, false);
                                                            return;
                                                          }
                                                          saving(context);
                                                          print(user.ticket.status);
                                                          print(isStatus.value);
                                                          if(!isStatus.value && user.ticket.endDate.isBefore(DateTime.now())){
                                                            print(user.ticket.status);
                                                            userData.ticket.status = !isStatus.value;
                                                            print(user.ticket.status);
                                                          }

                                                          userData.ticket.spotItem.name = memberShipNameController.text;
                                                          userData.ticket.spotItem.price = int.parse(memberShipPriceController.text);
                                                          userData.ticket.admission = int.parse(todayUseCountController.text);
                                                          userData.ticket.pause = int.parse(pauseCountController.text);
                                                          userData.ticket.passTicket = selectedSpotId.value == '' || selectedSpotId.value == 'custom' || selectedSpotName.value == '전체 지점';
                                                          userData.ticket.sportswear = sportswear.value;
                                                          userData.ticket.locker = locker.value;
                                                          userData.ticket.endDate = DateTime.parse(endDateController.text);
                                                          userData.ticket.spotItem.sportswear = !userData.ticket.sportswear || sportswearPriceController.text == '' ? 0 : int.parse(sportswearPriceController.text);
                                                          userData.ticket.spotItem.locker = !userData.ticket.locker || lockerPriceController.text == '' ? 0 : int.parse(lockerPriceController.text);
                                                          userData.ticket.lockerNum = !locker.value || lockerNumberController.text == '' ? 0 : int.parse(lockerNumberController.text);
                                                          userData.ticket.spotItem.spotDocumentId = controller.selectedSpot.value.documentId;
                                                          userData.ticket.spotDocumentId = selectedSpotId.value == '' || selectedSpotId.value == 'custom' || selectedSpotName.value == '전체 지점' ? userData.ticket.spotDocumentId : selectedSpotId.value;
                                                          userData.ticket.paymentBranch = selectedSpotId.value == '' || selectedSpotId.value == 'custom' || selectedSpotName.value == '전체 지점'  ? userData.ticket.paymentBranch : selectedSpotName.value;
                                                          await controller.updateUserDate(userData);
                                                          controller.update();
                                                          Get.back();
                                                          //
                                                          // await controller.userDataManagement.updateUserTicket(userData, false);
                                                          // controller.init();
                                                          // controller.update();
                                                          if(!Get.isSnackbarOpen) {
                                                            Get.snackbar(
                                                                '저정 완료',
                                                                '저장이 완료되었습니다.');
                                                          }
                                                        } catch(e){
                                                          Get.back();
                                                          if(!Get.isSnackbarOpen){
                                                            Get.snackbar('저정 실패', '잠시 후 다시 시도해주세요.');
                                                          }
                                                          print(e);
                                                        }
                                                      },
                                                      radius: 8,
                                                      text: '저장',
                                                      fontWeight: FontWeight.w600,
                                                      color: mainColor,
                                                      width: 80,
                                                      height: 36,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                spacing: size.width * 0.0156,//30,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    spacing: 15,
                                                    children: [
                                                      textWithTextField(text: '멤버쉽 이름', fontSize: size, controller: memberShipNameController, width: size.width * 0.1589, controllerWidth: size.width * 0.1057, isSubscribe: isSubscribe, isForward: false),
                                                      textWithTextField(text: isSubscribe ? '멤버쉽 가격(월)' : '멤버쉽 가격', fontSize: size, controller: memberShipPriceController, width: size.width * 0.1589, controllerWidth: isSubscribe ? size.width * 0.0818 : size.width * 0.0958, isSubscribe: isSubscribe, lastText: '원', isForward: true),
                                                      // textWithTextField(text: '멤버쉽 이름', controller: memberShipNameController, width: 305, controllerWidth: 203, isSubscribe: isSubscribe, isForward: false),
                                                      // textWithTextField(text: isSubscribe ? '멤버쉽 가격(월)' : '멤버쉽 가격', controller: memberShipPriceController, width: 305, controllerWidth: isSubscribe ? 157 : 184, isSubscribe: isSubscribe, lastText: '원', isForward: true),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    spacing: 15,
                                                    children: [
                                                      textWithTextField(text: isSubscribe ? '최초 등록일' : '남은 일 수', fontSize: size, controller: useDayController, width: size.width * 0.1042, controllerWidth: isSubscribe ? size.width * 0.0552 : size.width * 0.0453, isSubscribe: isSubscribe, lastText: isSubscribe ? '' : '일', isForward: !isSubscribe,
                                                      // textWithTextField(text: isSubscribe ? '최초 등록일' : '남은 일 수', controller: useDayController, width: 200, controllerWidth: isSubscribe ? 106 : 87, isSubscribe: isSubscribe, lastText: isSubscribe ? '' : '일', isForward: !isSubscribe,
                                                          onChanged: (){
                                                            endDateController.text = formatDate(DateTime.now().add(Duration(days: int.parse(useDayController.text) - 1)));
                                                          }),
                                                      textWithTextField(text: isSubscribe ? '자동 결제일' : '이용 종료일', fontSize: size, controller: endDateController, width: size.width * 0.1042, controllerWidth: size.width * 0.0552, isSubscribe: true, isForward: false),
                                                      // textWithTextField(text: isSubscribe ? '자동 결제일' : '이용 종료일', controller: endDateController, width: 200, controllerWidth: 106, isSubscribe: true, isForward: false),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    spacing: 15,
                                                    children: [
                                                      textWithTextField(text: '일일 입장 가능 횟수', fontSize: size, controller: todayUseCountController, width: size.width * 0.1026, controllerWidth: size.width * 0.0224, lastText: '회', isSubscribe: isSubscribe, isForward: true),
                                                      textWithTextField(text: isSubscribe ? '이용 가능 지점' : '일시 정지 가능 횟수', fontSize: size, controller: pauseCountController, width: size.width * 0.1026, controllerWidth: isSubscribe ? size.width * 0.0422 : size.width * 0.0224, isSubscribe: isSubscribe, lastText: isSubscribe ? null : '회', isForward: !isSubscribe),
                                                      // textWithTextField(text: '일일 입장 가능 횟수', controller: todayUseCountController, width: 197, controllerWidth: 43, lastText: '회', isSubscribe: isSubscribe, isForward: true),
                                                      // textWithTextField(text: isSubscribe ? '이용 가능 지점' : '일시 정지 가능 횟수', controller: pauseCountController, width: 197, controllerWidth: isSubscribe ? 81 : 43, isSubscribe: isSubscribe, lastText: isSubscribe ? null : '회', isForward: !isSubscribe),
                                                    ],
                                                  ),
                                                  if(!isSubscribe)
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text('이용 가능 지점', style: TextStyle(fontSize: tranSize(16), color: gray700, fontWeight: FontWeight.w600)),
                                                            SizedBox(width: size.width * 0.0052,),
                                                            Obx(() => DropdownButtonHideUnderline(
                                                              child: DropdownButton2<String>(
                                                                isExpanded: true,
                                                                hint: Center(
                                                                  child: Text(
                                                                    textAlign: TextAlign.center,
                                                                    selectedSpotName.value,
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: gray900,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                items: controller.spotList
                                                                    .map((element) => DropdownMenuItem<String>(
                                                                  value: element.documentId,
                                                                  child: Center(
                                                                    child: Text(
                                                                      textAlign: TextAlign.center,
                                                                      element.name,
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: gray900,
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )).toList(),
                                                                // value: value,
                                                                onChanged: (String? value) {
                                                                  selectedSpotId.value = value!;
                                                                  selectedSpotName.value = controller.spotList.firstWhere((element) => element.documentId == value).name;
                                                                },
                                                                buttonStyleData: ButtonStyleData(
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(color: gray300),
                                                                    color: bg,
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                                                  height: 28,
                                                                  width: size.width * 0.0568,//109,
                                                                ),
                                                                dropdownStyleData: const DropdownStyleData(
                                                                  decoration: BoxDecoration(
                                                                      color: bg,
                                                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                                                  ),
                                                                ),
                                                                menuItemStyleData: const MenuItemStyleData(
                                                                  height: 40,
                                                                ),
                                                              ),
                                                            ),),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.1156,//222,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('회원복', style: TextStyle(fontSize: tranSize(16), color: gray700, fontWeight: FontWeight.w600)),
                                                            Obx(() => Checkbox(
                                                              activeColor: user.ticket.subscribe ? gray500 : mainColor,
                                                              value: sportswear.value,
                                                              onChanged: (bool? value) {
                                                                if(user.ticket.subscribe){
                                                                  return;
                                                                }
                                                                if(value!){
                                                                  sportswearPriceController.text = user.ticket.spotItem.sportswear.toString();
                                                                }
                                                                else{
                                                                  sportswearPriceController.text = '';
                                                                }
                                                                sportswear.value = value;
                                                              },),
                                                            ),
                                                            Text('비용', style: TextStyle(fontSize: tranSize(16), color: gray700, fontWeight: FontWeight.w600)),
                                                            Container(
                                                              width: size.width * 0.0417,//80,
                                                              height: 28,
                                                              decoration: BoxDecoration(
                                                                color: user.ticket.subscribe ? gray200 : Colors.white,
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(color: gray300),
                                                              ),
                                                              child: TextField(
                                                                textAlign: TextAlign.right,
                                                                controller: sportswearPriceController,
                                                                readOnly: user.ticket.subscribe,
                                                                decoration: InputDecoration(
                                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: -18),
                                                                  border: InputBorder.none,
                                                                ),
                                                              ),
                                                            ),
                                                            Text('원', style: TextStyle(fontSize: tranSize(16), color: gray700, fontWeight: FontWeight.w600))
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.2083,//400,
                                                        child: Row(
                                                          spacing: 10,
                                                          children: [
                                                            SizedBox(
                                                              width: size.width * 0.1156,//222,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [//width : 42
                                                                  Container(width: size.width * 0.0219, child: Text('락커', textAlign: TextAlign.right, style: TextStyle(fontSize: tranSize(16), color: gray700, fontWeight: FontWeight.w600))),
                                                                  Obx(() => Checkbox(
                                                                    activeColor: user.ticket.subscribe ? gray500 : mainColor,
                                                                    value: locker.value,
                                                                    onChanged: (bool? value) {
                                                                      if(user.ticket.subscribe){
                                                                        return;
                                                                      }
                                                                      if(value!){
                                                                        lockerPriceController.text = user.ticket.spotItem.locker.toString();
                                                                        lockerNumberController.text = user.ticket.lockerNum.toString();
                                                                      }
                                                                      else{
                                                                        lockerPriceController.text = '';
                                                                        lockerNumberController.text = '';
                                                                      }
                                                                      locker.value = value!;
                                                                    },),
                                                                  ),
                                                                  Text('비용', style: TextStyle(fontSize: tranSize(16), color: gray700, fontWeight: FontWeight.w600)),
                                                                  Container(
                                                                    width: size.width * 0.0417, //80,
                                                                    height: 28,
                                                                    decoration: BoxDecoration(
                                                                      color: user.ticket.subscribe ? gray200 : Colors.white,
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      border: Border.all(color: gray300),
                                                                    ),
                                                                    child: TextField(
                                                                      textAlign: TextAlign.right,
                                                                      controller: lockerPriceController,
                                                                      readOnly: user.ticket.subscribe,
                                                                      decoration: InputDecoration(
                                                                        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.0052, vertical: -18),
                                                                        border: InputBorder.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text('원', style: TextStyle(fontSize: 16, color: gray700, fontWeight: FontWeight.w600))
                                                                ],
                                                              ),
                                                            ),
                                                            Obx(() => locker.value ? SizedBox(
                                                              width: size.width * 0.0557, //107,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('번호', style: TextStyle(fontSize: tranSize(16), color: gray700, fontWeight: FontWeight.w600)),
                                                                  Container(
                                                                    width: size.width * 0.0276,//53,
                                                                    height: 28,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      border: Border.all(color: gray300),
                                                                    ),
                                                                    child: TextField(
                                                                      textAlign: TextAlign.right,
                                                                      controller: lockerNumberController,
                                                                      decoration: InputDecoration(
                                                                        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.0052, vertical: -18),
                                                                        border: InputBorder.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text('번', style: TextStyle(fontSize: tranSize(16), color: gray700, fontWeight: FontWeight.w600))
                                                                ],
                                                              ),
                                                            ) : Container(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      )

                                    ],
                                  );

                            },
                          ),
                      SizedBox(height: 20,),
                      Obx(() => NumberPagination(
                        onPageChanged: (int pageNumber) {
                          //To optimize further, use a package that supports partial updates instead of setState (e.g. riverpod)
                          controller.selectedPage.value = pageNumber;
                          controller.a.value = controller.userDataListView.length - ((pageNumber-1) * 10) > 10 ? 10 : controller.userDataListView.length - ((pageNumber-1) * 10);
                          controller.update();
                        },
                        nextPageIcon: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                        previousPageIcon: Icon(Icons.keyboard_arrow_left, color: Colors.black,),
                        firstPageIcon: Icon(Icons.first_page, color: Colors.black,),
                        lastPageIcon: Icon(Icons.last_page, color: Colors.black,),
                        selectedButtonColor: mainColor,
                        selectedNumberColor: Colors.white,
                        buttonRadius: 10,
                        visiblePagesCount: 10,
                        totalPages: (controller.userDataListView.length / 10).ceil(),
                        currentPage: controller.selectedPage.value,
                        // enableInteraction: false,

                      ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  Widget textWithTextField({required String text, required Size fontSize, required TextEditingController controller, required double width, required double controllerWidth, required bool isSubscribe, required bool isForward,String? lastText, Function()? onChanged}){ {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(fontSize: fontSize.width * (16/1920), color: gray700, fontWeight: FontWeight.w600),),
          Row(
            children: [
              Container(
                width: controllerWidth,
                height: 28,
                decoration: BoxDecoration(
                  color: isSubscribe ? gray200 : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: gray300),
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: fontSize.width * (14/1920), color: gray900, fontWeight: FontWeight.w600),
                  readOnly: isSubscribe,
                  controller: controller,
                  onChanged: onChanged == null ? null : (String value){
                    onChanged();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: -15),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if(isForward)
                SizedBox(width: 5,),
              if(isForward && lastText != null)
                Text(lastText, style: TextStyle(
                    fontSize: fontSize.width * (16/1920), color: lastText == null ? Colors.transparent : gray900, fontWeight: FontWeight.w600),),
            ],
          ),
        ],
      ),
    );
  }
  }
}
