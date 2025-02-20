import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementController.dart';
import 'package:jns_package/jns_package.dart' as jns;


class SpotDetailView extends GetView<SpotManagementController> {
  const SpotDetailView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 110, top: 60, bottom: 60),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 60,
          children: [
            Container(
              width: 960,
              height: 960,
              padding: EdgeInsets.only(left: 80, top: 60, bottom: 60),
              decoration: BoxDecoration(
                border: Border.all(color: gray200, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Container(
                      height: 149,
                      child: Container(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  controller.pickImage();
                                },
                                child: Container(
                                  width: 149,
                                  height: 149,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: bg,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 8,
                                    children: [
                                      Icon(Symbols.camera_alt, size: 47, color: gray200, fill: 1,),
                                      Text('사진 추가', style: TextStyle(fontSize: 20, color: gray500, fontWeight: FontWeight.w500),),
                                      Text('(4:3비율 권장)', style: TextStyle(fontSize: 16, color: gray400, fontWeight: FontWeight.w500),)
                                    ],
                                  ),
                                ),
                              ),
                              Obx(() => Row(
                                children: [
                                  if(controller.image.isNotEmpty)
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller.image.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              ImageExpansionDialog(context, imageData: controller.image[index]!);
                                            },
                                            child: Container(
                                              width: 149,
                                              height: 149,
                                              margin: EdgeInsets.only(left: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                image: DecorationImage(
                                                  image: MemoryImage(controller.image[index]!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(right: 120),
                                      itemCount: controller.selectedSpot.value.imageUrlList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            ImageExpansionDialog(context, imageUrl: controller.selectedSpot.value.imageUrlList[index]);
                                          },
                                          child: Container(
                                            width: 149,
                                            height: 149,
                                            margin: EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              image: DecorationImage(
                                                image: NetworkImage(controller.selectedSpot.value.imageUrlList[index]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 40,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 18,
                            children: [
                              Text('지점명', style: TextStyle(fontSize: 24, color: gray900, fontWeight: FontWeight.w600),),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: bg,
                                  border: null,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextField(
                                  controller: controller.selectedNameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 26),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                Text('지점 주소', style: TextStyle(fontSize: 24, color: gray900, fontWeight: FontWeight.w600),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){ // TODO: 주소검색
                                        controller.openDaumPostcode();
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: 560,
                                        height: 50,
                                        padding: EdgeInsets.only(left: 26),
                                        decoration: BoxDecoration(
                                          color: bg,
                                          border: null,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: TextField(
                                          controller: controller.selectedAddressController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: '주소를 검색하세요',
                                            hintStyle: TextStyle(fontSize: 20, color: gray500, fontWeight: FontWeight.w400),
                                            // contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 18),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                        // child: Obx(() => Text(controller.selectedSpot.value.address == '' ? '주소를 검색하세요' : controller.selectedSpot.value.address,
                                        //     style: TextStyle(
                                        //       fontSize: 20,
                                        //       color: controller.selectedSpot.value.address == '' ? gray500 : gray900,
                                        //     ),
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                    jns.ConfirmButton(
                                        color: mainColor,
                                        radius: 10,
                                        fontSize: 18,
                                        text: '주소검색',
                                        width: 180,
                                        height: 50,
                                        onPressed: (){
                                          controller.openDaumPostcode();
                                        }
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: bg,
                                    border: null,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller: controller.selectedAddressDetailController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      hintText: '상세주소를 입력하세요 (ex. 1층 101호)',
                                      hintStyle: TextStyle(fontSize: 20, color: gray500, fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 18,
                            children: [
                              Text('지점 소개', style: TextStyle(fontSize: 24, color: gray900, fontWeight: FontWeight.w600),),
                              Container(
                                height: 184,
                                // alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  color: bg,
                                  border: null,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextField(
                                  controller: controller.selectedDescriptionController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 26, vertical: 26),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('장비 일련변호', style: TextStyle(fontSize: 24, color: gray900, fontWeight: FontWeight.w600),),
                                  IconButton(
                                    icon: Icon(Icons.add, size: 24, color: mainColor, fill: 1,),
                                    onPressed: (){
                                      // controller.devSnList.add('');
                                      controller.devSnControllerList.add(TextEditingController());
                                      // controller.devSnWidgetList.add(controller.textField(controller.devSnControllerList.last));
                                    },
                                  ),
                                ],
                              ),
                              Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 10,
                                children: [
                                  for(int i = 0; i < controller.devSnControllerList.length; i++)
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          height: 50,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: bg,
                                            border: null,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: TextField(
                                            controller: controller.devSnControllerList[i],
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(horizontal: 26),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, size: 24, color: Colors.red, fill: 1,),
                                          onPressed: (){
                                            controller.devSnControllerList.removeAt(i);
                                            controller.devSnWidgetList.removeAt(i);
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                            
                    // Text('지번 주소: ${controller.selectedJibunAddress.value}'),
                    // Text('우편번호: ${controller.selectedZonecode.value}'),
                    // TextButton(onPressed: (){controller.openDaumPostcode();}, child: Text('asdf')),
                  ],
                ),
              ),
            ),
            jns.ConfirmButton(
                radius: 8,
                color: mainColor,
                text: '저장',
                fontSize: 26,
                fontWeight: FontWeight.w600,
                width: 205,
                height: 75,
                onPressed: () async {
                  if(controller.selectedNameController.text == '' || controller.selectedAddressController.text == '' || controller.selectedDescriptionController.text == '') {
                    Get.snackbar('저장 오류', '지점 상세 주소를 제외한 모든 항목을 입력해주세요');
                    return;
                  }
                  saving(context);
                  // List<String> imageUrlList = await controller.uploadImage();
                  if(controller.isUpdate){
                    print('update');
                    await controller.updateSpot();
                    controller.isDetailView.value = false;
                  }
                  else{
                    print('add');
                    await controller.addSpot();
                    controller.clearSelectedSpot();
                    controller.init();
                    controller.isDetailView.value = false;
                  }
                  Get.back();

                }
            ),
          ],
        ),
      ),
    );
  }
  ImageExpansionDialog(BuildContext context, {String? imageUrl, Uint8List? imageData}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(bottom: 18),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(Symbols.delete, size: 30, color: Colors.white, fill: 1,),
                    onPressed: (){
                      if(imageUrl != null) {
                        controller.selectedSpot.value.imageUrlList.remove(imageUrl);
                      } else {
                        controller.image.remove(imageData);
                      }
                      Get.back();
                    }
                ),
              ],
            ),
            content: Image(image: imageUrl != null ? NetworkImage(imageUrl) : MemoryImage(imageData!), fit: BoxFit.fitWidth, width: 645,),
          );
        }
    );
  }
}