import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/view/visitRecordManagement/visitRecordController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitRecordView extends GetView<VisitRecordController> {
  const VisitRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime afterOneYear = DateTime.now().add(Duration(days: 365));
    DateTime today = DateTime.now();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 60, top: 50),
        child: GetBuilder<VisitRecordController>(
          builder: (controller) {
            controller.init();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(width: 50),
                      Obx(() => DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            items: controller.spotList.map((e) => DropdownMenuItem<String>(
                              value: e.documentId,
                              child: Text(e.name, style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w600),),
                            )).toList(),
                            hint: Text(controller.selectedSpot.value.name, style: TextStyle(fontSize: 26, color: gray900, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                            onChanged: controller.spotList.length == 1
                                ? null
                                : (String? value){
                              controller.selectedSpot.value = controller.spotList.firstWhere((element) => element.documentId == value);
                              print(value);
                              controller.selectedPage.value = 1;
                              controller.update();
                            },
                            iconStyleData: IconStyleData(icon: Icon(Icons.keyboard_arrow_down_outlined, color: gray600,), iconSize: 24),
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
                              width: 150,
                              maxHeight: 300,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  StreamBuilder(
                    stream: visitHistoryDB
                        .where('createDate', isLessThan: Timestamp.fromDate(afterOneYear))
                        .orderBy('createDate', descending: true)//.limit(1000)
                        .snapshots(),
                        // : visitHistoryDB
                        // .where('createDate', isLessThan: Timestamp.fromDate(afterOneYear))
                        // .orderBy('createDate', descending: true)
                        // .limit(1)
                        // .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      // List data = controller.test;
                      // if(controller.test.isEmpty){
                      //   var data1 = snapshot.data!.docs.where((element) => myInfo.value.position == '마스터' ? true : myInfo.value.spotIdList.contains(element['spotDocumentId'])).toList();
                      //   data = data1.where((element) => element['spotDocumentId'] == controller.selectedSpot.value.documentId || controller.selectedSpot.value.documentId == '').toList();
                      //   controller.test = data.obs;
                      // }
                      // else{
                      //   data.add(snapshot.data!.docs[0]);
                      // }
                      var data1 = snapshot.data!.docs.where((element) => myInfo.value.position == '마스터' ? true : myInfo.value.spotIdList.contains(element['spotDocumentId'])).toList();
                      List data = data1.where((element) => element['spotDocumentId'] == controller.selectedSpot.value.documentId || controller.selectedSpot.value.documentId == '').toList();


                      int todayUserCount = 0;
                      int monthUserCount = 0;
              
                      for (int i = 0; i < data.length; i++) {
                        if (data[i]['createDate'].toDate().day == today.day && data[i]['createDate'].toDate().month == today.month && data[i]['createDate'].toDate().year == today.year) {
                          todayUserCount++;
                          // print('오늘 유저 카운트 : ${todayUserCount}');
                          // print(today.day);
                          // print((data[i]['createDate'] as Timestamp).toDate().hour);
                          // print(data[i]['userName']);
                        }
                        if (data[i]['createDate'].toDate().month == today.month && data[i]['createDate'].toDate().year == today.year) {
                          monthUserCount++;
                        }
                      }
              
                      int crossAxisCount = 2; // ✅ 가로 2줄 (세로 10줄)
                      int rowCount = 10; // ✅ 세로 10개
                      int totalItems = 20; // ✅ 항상 20개의 그리드 유지
              
                      List<dynamic> temp = List.filled(totalItems, null); // ✅ 빈 데이터로 초기화
              
                      // ✅ 페이지의 시작 인덱스 (i의 범위 조정)
                      int startIndex = 20 * (controller.selectedPage.value - 1);
                      int endIndex = startIndex + totalItems > data.length ? data.length : startIndex + totalItems;
              
                      // ✅ `i`를 0부터 다시 시작하도록 보정
                      for (int i = 0; i < totalItems; i++) {
                        int realIndex = startIndex + i;  // 🚀 실제 데이터의 인덱스 보정
              
                        if (realIndex < endIndex) {  // 🚀 데이터 개수 범위 내에서만 실행
                          int row = i % rowCount;  // ✅ 항상 0~9 유지
                          int column = i ~/ rowCount;  // ✅ 항상 0~1 유지
                          int newIndex = row * crossAxisCount + column;  // ✅ 세로 우선 정렬
              
                          temp[newIndex] = data[realIndex];  // 🚀 insert() 대신 직접 할당
                        }
                      }
              
                      // print('-------------------------');
                      // for(int i = 0; i < temp.length; i++) {
                      //   print('temp[$i]: ${temp[i]?.data()['createDate'].toDate()}');
                      // }
                      return Container(
                        width: 1026,
                        height: 800,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 20,
                          children: [
                            Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: gray500),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 20,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 30,
                                    children: [
                                      Text('방문자 현황', style: TextStyle(fontSize: 24, color: gray900, fontWeight: FontWeight.w600),),
                                      Row(
                                        spacing: 30,
                                        children: [
                                          Text('월 $monthUserCount명', style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w500)),
                                          Text('오늘 $todayUserCount명', style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(), // 내부 스크롤 방지
                                    itemCount: totalItems, // 20개로 고정
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount, // 가로 2개
                                      crossAxisSpacing: 100,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 10, // 셀 크기 설정
                                    ),
                                    itemBuilder: (context, index) {
                                      var visitData = temp[index]; // ✅ 페이지 번호에 따라 인덱스 계산
              
                                      if (visitData == null) {
                                        return Container(); // 빈 칸은 SizedBox로 표시
                                      }
              
                                      return Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border(bottom: BorderSide(color: gray500)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          // spacing: 60,
                                          children: [
                                            Text(
                                              // visitData['createDate'].toDate().toString().substring(0, 16),
                                              DateFormat('M/d H:mm').format(visitData['createDate'].toDate()),
                                              style: TextStyle(fontSize: 18, color: gray900, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              visitData['userName'] ?? 'Unknown Spot',
                                              style: TextStyle(fontSize: 18, color: gray900, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              visitData['spotName'] ?? 'Unknown Spot',
                                              style: TextStyle(fontSize: 18, color: gray600, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              visitData['ticket']['sportswear'] ? '회원복 O' : '회원복 X',
                                              style: TextStyle(fontSize: 18, color: gray600, fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Obx(() => NumberPagination(
                              onPageChanged: (int pageNumber) {
                                controller.selectedPage.value = pageNumber;
                                controller.update();
                              },
                              nextPageIcon: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                              previousPageIcon: Icon(Icons.keyboard_arrow_left, color: Colors.black,),
                              firstPageIcon: Icon(Icons.first_page, color: Colors.black,),
                              lastPageIcon: Icon(Icons.last_page, color: Colors.black,),
                              currentPage: controller.selectedPage.value,
                              totalPages: (data.length / 20).ceil(), // 페이지 개수 계산
                              selectedButtonColor: mainColor,
                              selectedNumberColor: Colors.white,
                              buttonRadius: 10,
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
