import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/view/sign/findPassword/findPasswordController.dart';
import 'package:jns_package/jns_package.dart' as jns;

class FindPasswordView extends GetView<FindPasswordController> {
  const FindPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => FindPasswordController());
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width * 0.3,
          height: size.height * 0.5046,
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border.all(color: Colors.black, width: 1.5),
          //     borderRadius: BorderRadius.circular(8)
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.1111,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: size.height * 0.0148,
                children: [
                  Image(image: AssetImage('./assets/images/logoText.png'), width: size.width * 0.1563, fit: BoxFit.fitWidth,),
                  Text('관리자 비밀번호 찾기',
                    style: TextStyle(fontSize: size.width * 0.0125, fontFamily: 'GmarketSans', fontWeight: FontWeight.w500, color: gray600),),
                  Text('비밀번호 찾기는 가입하신 이메일 입력 시, 메일을 통해 안내해 드립니다.',
                    style: TextStyle(fontSize: size.width * 0.0094, fontFamily: 'GmarketSans', fontWeight: FontWeight.w500,color: gray600),),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 9,
                children: [
                  Text('이메일', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: gray900),),
                  Container(
                    width: size.width,
                    height: size.height * 0.0556,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: bg
                    ),
                    child: TextField(
                      controller: controller.emailController,
                      style: TextStyle(fontWeight: FontWeight.w400, color: gray900),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: size.width * 0.0078, fontWeight: FontWeight.w400, color: gray500),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5, color: mainColor),
                          )
                      ),
                    ),
                  ),
                ],
              ),
              jns.ConfirmButton(
                  color: mainColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  radius: 10,
                  text: '메일 발송',
                  width: size.width,
                  height: 64,
                  onPressed: () async {
                    if(await controller.sign.findPassword(controller.emailController.text)){
                      Get.offAllNamed('/signIn');
                      if(!Get.isSnackbarOpen){
                        Get.snackbar('비밀번호 재설정 메일 발송', '메일을 확인해주세요.', backgroundColor: mainColor, colorText: Colors.white);
                      }
                    }
                    else{
                      if(!Get.isSnackbarOpen){
                        Get.snackbar('비밀번호 재설정 메일 발송 실패', '메일 발송에 실패했습니다. 이메일을 확인해주세요.', backgroundColor: mainColor, colorText: Colors.white);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
