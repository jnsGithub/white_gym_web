import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementController.dart';
import 'package:white_gym_web/view/user/userManagementController.dart';

import 'signInController.dart';





class Login extends GetView<LoginController> {
  const Login ({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: size.width * 0.3938,
          height: size.height * 0.8111,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: bg, width: 1.5),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('./assets/images/logoIcon.png'), width: size.width * 0.0938, fit: BoxFit.fitWidth,),
              Text('Admin 관리자페이지', style: TextStyle(fontSize: size.width * 0.0125, color: gray600, fontWeight: FontWeight.w400),),
              SizedBox(height: size.height * 0.0139,),
              Image(image: AssetImage('./assets/images/logoText.png'), width: size.width * 0.1563, fit: BoxFit.fitWidth,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text('이메일', style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: gray900
                  ),),
                  const SizedBox(
                    height: 9,
                  ),
                  Container(
                    width: size.width * 0.2917,
                    // height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xfff6f6fa)),
                    child: TextField(
                      controller: controller.idController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffAEAEB2)),
                        border: InputBorder.none,
                        // 밑줄 없애기
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        // TextField 내부의 패딩 적용
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5, color: mainColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text('비밀번호', style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: gray900
                  ),),
                  const SizedBox(
                    height: 9,
                  ),
                  Container(
                    width: size.width * 0.2917,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xfff6f6fa)),
                    child: TextFormField(
                      obscureText: true,
                      onFieldSubmitted: (e) async {
                        // login(context);
                        if(controller.idController.text == '' || controller.passwordController.text == '') {
                          Get.snackbar('로그인 실패', '아이디와 비밀번호를 입력해주세요.');
                          return;
                        }
                        if(await controller.sign.signIn(controller.idController.text, controller.passwordController.text)) {
                          var controller1 = Get.find<SpotManagementController>();
                          var controller2 = Get.find<UserManagementController>();
                          controller1.init();
                          controller2.init();
                          Get.offAllNamed('/mainPage');
                        } else {
                        Get.snackbar('로그인 실패', '아이디와 비밀번호를 확인해주세요.');
                        }
                      },
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // 밑줄 없애기
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        // TextField 내부의 패딩 적용
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5, color: mainColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/signUp');
                    },
                    child: Text('회원가입', style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000)
                    ),),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('|', style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000)
                  ),),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/findPassword');
                    },
                    child: const Text('비밀번호 찾기', style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000)
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () async {
                  if(controller.idController.text == '' || controller.passwordController.text == '') {
                    Get.snackbar('로그인 실패', '아이디와 비밀번호를 입력해주세요.');
                    return;
                  }
                  if(await controller.sign.signIn(controller.idController.text, controller.passwordController.text)) {
                    var controller1 = Get.find<SpotManagementController>();
                    var controller2 = Get.find<UserManagementController>();
                    controller1.init();
                    controller2.init();
                    Get.offAllNamed('/mainPage');
                  } else {
                    Get.snackbar('로그인 실패', '아이디와 비밀번호를 확인해주세요.');
                  }
                  // Get.toNamed('/mainPage');
                  // login(context);
                },
                child: Container(
                  width: size.width * 0.2917,
                  height: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      // left: 16,
                      // right: 16,
                      bottom: 16,),
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.white)
                  ),
                  child: const Text('로그인', style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white
                  ),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
