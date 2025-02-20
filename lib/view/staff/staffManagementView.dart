import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/staff.dart';
import 'package:white_gym_web/view/staff/staffManagementController.dart';
import 'package:number_pagination/number_pagination.dart';





class StaffManagementView extends GetView<StaffManagementController> {
  const StaffManagementView ({super.key});

  @override
  Widget build(BuildContext context) {
    double staffTypeWidth = 200;
    double spotWidth = 200;
    double nameWidth = 150;
    double emailWidth = 260;
    double phoneWidth = 250;
    double createdWidth = 200;
    double approvedWidth = 159;

    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => StaffManagementController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text('직원 관리',style: TextStyle(fontSize: 30, color: gray900, fontWeight: FontWeight.w600),),
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
                    hintText: '직원 이름으로 검색',
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
                  onChanged: (String value) {
                    controller.searchStaff();
                  },
                  onSubmitted: (String value) {
                    // search();
                  },
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  controller.staffTypeTab(650),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 5,
                      children: [
                        Icon(Icons.refresh, color: gray500,),
                        Container(
                          height: 1,
                          color: gray100,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
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
                              width: staffTypeWidth,
                              alignment: Alignment.center,
                              child: Text('직원유형', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: spotWidth,
                              alignment: Alignment.center,
                              child: Text('지점', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: nameWidth,
                              alignment: Alignment.center,
                              child: Text('이름', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: emailWidth,
                              alignment: Alignment.center,
                              child: Text('이메일', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: phoneWidth,
                              alignment: Alignment.center,
                              child: Text('휴대폰 번호', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: createdWidth,
                              alignment: Alignment.center,
                              child: Text('생성 일자', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              width: approvedWidth,
                              alignment: Alignment.center,
                              child: Icon(Icons.more_vert, color: Colors.white,),
                            ),
                          ],
                        ),
                      ),
                      Obx(() => ListView.separated(
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
                            String spotName = controller.spotList.where((element) => element.documentId == controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].spotIdList[0]).first.name;
                              return Container(
                                height: 59,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    left: BorderSide(color: gray100, width: 1),
                                    right: BorderSide(color: gray100, width: 1),
                                    bottom: index == 9
                                        ? BorderSide(color: gray100, width: 1)
                                        : (index + (controller.selectedPageNumber.value - 1) * 10) == controller.selectedStaffList.length - 1
                                        ? BorderSide(color: gray100, width: 1)
                                        : BorderSide.none,
                                  ),
                                  borderRadius: index == 9
                                      ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                                      : (index + (controller.selectedPageNumber.value - 1) * 10) == controller.selectedStaffList.length - 1
                                      ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                                      : null,
                                ),
                                child: Obx(() => Row(
                                    children: [
                                      Container(
                                        width: staffTypeWidth,
                                        alignment: Alignment.center,
                                        child: Text(controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].position, style: TextStyle(fontSize: 16, color: gray900, fontWeight: FontWeight.w600),),
                                      ),
                                      Container(
                                        width: spotWidth,
                                        alignment: Alignment.center,
                                        child: Text(
                                          controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].spotIdList.length == 1
                                              ? controller.spotList.where((element) => element.documentId == controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].spotIdList[0]).first.name
                                              : '${controller.spotList.where((element) => element.documentId == controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].spotIdList[0]).first.name} 외 ${controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].spotIdList.length - 1}개',
                                          style: TextStyle(fontSize: 16, color: gray900, fontWeight: FontWeight.w600),),
                                      ),
                                      Container(
                                        width: nameWidth,
                                        alignment: Alignment.center,
                                        child: Text(controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].name, style: TextStyle(fontSize: 16, color: gray900, fontWeight: FontWeight.w600),),
                                      ),
                                      Container(
                                        width: emailWidth,
                                        alignment: Alignment.center,
                                        child: Text(controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].email , style: TextStyle(fontSize: 16, color: gray900, fontWeight: FontWeight.w600),),
                                      ),
                                      Container(
                                        width: phoneWidth,
                                        alignment: Alignment.center,
                                        child: Text(controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].hp, style: TextStyle(fontSize: 16, color: gray900, fontWeight: FontWeight.w600),),
                                      ),
                                      Container(
                                        width: createdWidth,
                                        alignment: Alignment.center,
                                        child: Text(formatDate(controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].createDate), style: TextStyle(fontSize: 16, color: gray900, fontWeight: FontWeight.w600),),
                                      ),
                                      Container(
                                        width: approvedWidth,
                                        padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 14.5),
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom( // TODO: 버튼 스타일 수정해야함.
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              side: BorderSide(color: controller.tabController.index == 0 ? mainColor : Color(0xffFF3C3C))
                                            ),
                                          ),
                                            onPressed: () async {
                                              if(controller.tabController.index == 0){
                                                controller.staffList.where((element) => element.documentId == controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].documentId).first.isApproved = true;
                                                await controller.staffManagement.approveStaff(controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].documentId);
                                                controller.init();
                                              }else{
                                                controller.deleteApprovedDialog(context, size, controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index]);
                                                // controller.staffList.removeWhere((element) => element.documentId == controller.selectedStaffList[index].documentId);
                                                // await controller.staffManagement.deleteStaff(controller.selectedStaffList[(controller.selectedPageNumber.value - 1) * 10 + index].documentId);
                                                // controller.init();
                                              }
                                            }, child: Text(controller.tabController.index == 0 ? '승인' : '삭제', style: TextStyle(fontSize: 13, color: controller.tabController.index == 0 ? mainColor : Color(0xffFF3C3C), fontWeight: FontWeight.w500),))
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Obx(() => NumberPagination(
                          onPageChanged: (int pageNumber) {
                            //To optimize further, use a package that supports partial updates instead of setState (e.g. riverpod)
                              controller.selectedPageNumber.value = pageNumber;
                              controller.a.value = controller.selectedStaffList.length - ((pageNumber-1) * 10) > 10 ? 10 : controller.selectedStaffList.length - ((pageNumber-1) * 10);
                          },
                          nextPageIcon: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                          previousPageIcon: Icon(Icons.keyboard_arrow_left, color: Colors.black,),
                          firstPageIcon: Icon(Icons.first_page, color: Colors.black,),
                          lastPageIcon: Icon(Icons.last_page, color: Colors.black,),
                          selectedButtonColor: mainColor,
                          selectedNumberColor: Colors.white,
                          buttonRadius: 10,
                          visiblePagesCount: 10,
                          totalPages: controller.selectedStaffList.length ~/ 10 + 1,
                          currentPage: controller.selectedPageNumber.value,
                          // enableInteraction: false,

                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
