import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/spotManagement/controllers/spot_management_controller.dart';
import 'package:white_gym_web/global/global.dart';
import 'package:jns_package/jns_package.dart' as jns;

class SpotListPage extends GetView<SpotManagementController> {
  const SpotListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Get.lazyPut(() => SpotManagementController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 110, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 35,
          children: [
            Text('지점 관리', style: TextStyle(fontSize: 30, color: gray900, fontWeight: FontWeight.w600),),
            Obx(() => Container(
                width: 1080,
                height: 600,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.spotList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // controller.selectedSpot.value = controller.spotList[index].copyWith();
                        controller.setSelecedSpot(controller.spotList[index]);
                        controller.isUpdate = true;
                        controller.isDetailView.value = true;
                      },
                      child: Container(
                        height: 140,
                        margin: EdgeInsets.only(bottom: index == controller.spotList.length - 1 ? 0 : 30),
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Color(0xffCBD0D7), width: 1),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Row(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                image: controller.spotList[index].imageUrlList.isNotEmpty ? DecorationImage(
                                    image: NetworkImage(controller.spotList[index].imageUrlList[0]),
                                    fit: BoxFit.cover
                                ) : null,
                                color: controller.spotList[index].imageUrlList.isEmpty ? gray400 : null,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                              ),
                            ),
                            Container(
                              width: 940,
                              padding: EdgeInsets.only(left: 30),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffCBD0D7), width: 1),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 30,
                                children: [
                                  Text(controller.spotList[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                  Row(
                                    children: [
                                      Text(controller.spotList[index].address, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                                      Text(' ${controller.spotList[index].addressDetail}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },),
              ),
            ),
            if(myInfo.value.position == '마스터')
              GestureDetector(
                onTap: () {
                  controller.isDetailView.value = true;
                },
                child: Container(
                  width: 1080,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xffEEF3FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 21,
                    children: [
                      Icon(Icons.add, color: mainColor, size: 23,),
                      Text('지점 추가하기', style: TextStyle(fontSize: 23, color: mainColor, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
