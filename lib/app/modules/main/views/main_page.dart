import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/main/bindings/main_binding.dart';
import 'package:white_gym_web/app/theme/app_color.dart';
import 'package:white_gym_web/global/global.dart';


import '../controllers/main_controller.dart';





class MainPage extends GetView<MainController> {
  final Widget child;
  const MainPage({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MainBinding().dependencies();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Row(
              children: [
                Container(
                  width: 292,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: bg,
                  ),
                  child:  Column(
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      SizedBox(
                        width: 300,
                        height: 300,
                        child:
                          ListView.builder(
                              itemCount: controller.menuItem.length,
                              itemBuilder: (context, index) {
                                return Obx(()=>
                                  GestureDetector(
                                    onTap: (){
                                      controller.changeMenu(index);
                                    },
                                    child: Container(
                                      height: 52,
                                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 24),
                                      decoration: BoxDecoration(
                                          color: controller.menuIndex == index ? mainColor : null,
                                      ),
                                      child: Row(
                                        spacing: 14,
                                        children: [
                                          Icon(controller.menuIcon[index], color: controller.menuIndex == index ? Colors.white : gray300, fill: 1, size: 24,),
                                          Text('${controller.menuItem[index]}',style:
                                          TextStyle(
                                              color: controller.menuIndex == index ? Colors.white : null,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: child,
                  // child: controller.menuWidget[controller.menuIndex.value],
                )
              ],
            ),
          ),
        ),
      );
  }
}
