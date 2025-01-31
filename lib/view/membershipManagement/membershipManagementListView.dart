import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementController.dart';
import 'package:jns_package/jns_package.dart' as jns;

class MembershipManagementListView extends GetView<MembershipManagementController> {
  const MembershipManagementListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 50,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '마스터 계정',
                        style: TextStyle(
                          fontSize: 30,
                          color: gray900,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontSize: 30,
                          color: gray900,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: '님',
                        style: TextStyle(
                          fontSize: 26,
                          color: gray500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Text('마스터 계정'),
                // Text('님'),
                Obx(() => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        '${controller.selectedSpot.value.name}점',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
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
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )).toList(),
                    // value: value,
                    onChanged: (String? value) {
                      print(value);
                      // controller.selectedSpot.value = controller.spotList.firstWhere((element) => element.documentId == value);
                      controller.searchSpotItem(controller.spotList.firstWhere((element) => element.documentId == value));
                      // if(controller.selectedSpotItemList.isEmpty){
                      //   controller.selectedSpotItem.value.index = 0;
                      // }
                      // else{
                      //   controller.selectedSpotItem.value.index =  controller.selectedSpotItemList[controller.selectedSpotItemList.length - 1].index + 1;
                      // }
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      width: 130,
                    ),
                    dropdownStyleData: const DropdownStyleData(
                      decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.all(Radius.circular(16))
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
            Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('멤버쉽 관리', style: TextStyle(fontSize: 30, color: gray900, fontWeight: FontWeight.w600),),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23),
                          child: ElevatedButton(
                            onPressed: (){
                              controller.isDetailView.value = true;
                              controller.selectedSpotItem.value.spotDocumentId = controller.selectedSpot.value.documentId;
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(225, 54),
                              maximumSize: Size(225, 54),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: mainColor, width: 1),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: mainColor, size: 30,),
                                Text('멤버쉽 생성', style: TextStyle(fontSize: 28, color: mainColor, fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        jns.ConfirmButton(
                            text: '저장',
                            fontSize: 28,
                            color: mainColor,
                            fontWeight: FontWeight.w600,
                            width: 128,
                            height: 54,
                            radius: 8,
                            onPressed: () async {
                              await controller.updateSpotItemIndex();
                              controller.isUpdate = false;
                            })
                      ],
                    )
                  ],
                ),
                Container(
                  height: 1,
                  color: gray200,
                ),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() =>
                      Container(
                        width: 960,
                        height: 330,
                        child: ReorderableListView.builder(
                          itemCount: controller.selectedSpotItemList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              key: ValueKey(controller.selectedSpotItemList[index].documentId),
                              onTap: (){
                                controller.selectedSpotItem.value = controller.selectedSpotItemList[index].copyWith();
                                controller.setController();
                                controller.isDetailView.value = true;
                                controller.isUpdate = true;
                              },
                              child: Container(
                                width: 960,
                                height: 138,
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: gray200, width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Text(controller.selectedSpotItemList[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                    Text(controller.selectedSpotItemList[index].descriptions1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ),
                            );
                          },
                          onReorder: (oldIndex, newIndex) {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            print(1);
                            final item = controller.selectedSpotItemList.removeAt(oldIndex);
                            controller.selectedSpotItemList.insert(newIndex, item);
                            for(int i = 0 ; i < controller.selectedSpotItemList.length; i++){
                              controller.selectedSpotItemList[i].index = i;
                            }
                            // controller.updateTodoList();
                          },

                        ),
                      )
                  ),
                  Container(
                    width: 217,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.drag_handle, color: gray700, size: 20,),
                        Text(': 노출 순서 변경', style: TextStyle(fontSize: 24, color: gray500, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
