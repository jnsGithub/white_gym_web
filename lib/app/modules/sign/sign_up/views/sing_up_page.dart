import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/sign/sign_up/controllers/sign_up_controller.dart';
import 'package:white_gym_web/app/routes/app_routes.dart';
import 'package:white_gym_web/app/theme/app_color.dart';
import 'package:white_gym_web/global/global.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:jns_package/jns_package.dart' as jns;

import '../../../../data/models/spot/spot.dart';


class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => SignUpController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: size.width * 0.0469),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      spacing: size.height * 0.0266,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(image: AssetImage('./assets/images/logoText.png'), width: size.width * 0.1563, fit: BoxFit.fitWidth,),
                        Text('관리자 회원가입', style: TextStyle(fontSize: size.width * 0.0125, color: gray800, fontFamily: 'GmarketSans', fontWeight: FontWeight.w500),),
                      ],
                    )),
              ),
            ), // 왼쪽 여백
            SingleChildScrollView(
              child: Container(
                width: size.width * 0.2917,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 30,
                  children: [
                    Text('관리자 회원가입', style: TextStyle(fontSize: size.width * 0.0259, fontWeight: FontWeight.w600, color: gray900),),
                    Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          checkBox(size: size, index: 0, type: '트레이너'),
                          checkBox(size: size, index: 1, type: '인포'),
                          checkBox(size: size, index: 2, type: '매니저'),
                          checkBox(size: size, index: 3, type: '지점장'),
                        ],
                      ),
                    ),
              
                    _inputField(hint: '이메일', controller: controller.emailController, isPassword: false, size: size),
                    _inputField(hint: '비밀번호', controller: controller.passwordController, isPassword: true, size: size),
                    _inputField(hint: '비밀번호 확인', controller: controller.passwordCheckController, isPassword: true, size: size),
                    _inputField(hint: '이름', controller: controller.nameController, isPassword: false, size: size),
                    _inputField(hint: '전화번호', controller: controller.hpController, isPassword: false, size: size),
                    Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: size.height * 0.0148,
                      children: [
                        Text('소속 지점', style: TextStyle(fontSize: size.width * 0.0104, fontWeight: FontWeight.w600, color: gray900),),DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: bg,
                              ),
                              maxHeight: size.height * 0.2926,
                            ),
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: bg,
                              ),
                            ),
                            items: controller.items.map((Spot item) => DropdownMenuItem<String>(
                              value: item.name,
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: size.width * 0.0104,
                                  fontWeight: FontWeight.w500,
                                  color: gray700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )).toList(),
                            hint: Text(controller.selectedType.value == 3 ? controller.selectedItems.value : controller.selectedItem.value, style: TextStyle(fontSize: size.width * 0.0104, fontWeight: FontWeight.w500, color: gray700),),
                            onChanged: (String? value) {
                              print(value);
                              if(controller.selectedType.value == 3){
                                if(controller.selectedItems.contains('소속지점')){
                                  controller.selectedItems.value = controller.selectedItems.value.replaceAll('소속지점', '');
                                }
                                if(controller.selectedItems.value.contains(value!)){
                                  controller.selectedItems.value = controller.selectedItems.value.replaceAll(value, '');
                                  controller.selectedSpotIdList.remove(controller.items.where((element) => element.name == value).first.documentId);
                                }
                                else{
                                  controller.selectedItems.value = controller.selectedItems.value + value;
                                  controller.selectedSpotIdList.add(controller.items.where((element) => element.name == value).first.documentId);
                                }

                                // 1️⃣ 쉼표(`,`) 뒤에 공백이 없으면 추가
                                controller.selectedItems.value = controller.selectedItems.value.replaceAllMapped(RegExp(r'점(?!,)'), (match) => '점,');

                                // 2️⃣ 쉼표(`,`)가 연속되면 하나만 남기기
                                controller.selectedItems.value = controller.selectedItems.value.replaceAll(RegExp(r',\s*,+'), ',');

                                // 3️⃣ 맨 앞과 맨 뒤에 쉼표(`,`)가 있으면 제거
                                controller.selectedItems.value = controller.selectedItems.value.replaceAll(RegExp(r'^,|,$'), '').trim();
                              }
                              else {
                                controller.selectedItem(value!);
                                if(controller.selectedSpotIdList.isNotEmpty){
                                  controller.selectedSpotIdList[0] = controller.items.where((element) => element.name == value).first.documentId;
                                }
                                else {
                                  controller.selectedSpotIdList.add(controller.items.where((element) => element.name == value).first.documentId);
                                }
                              }
                              print(controller.selectedSpotIdList);
                            },
                          ),
                        ),
                      ],
                    ),
                    ),
                    jns.ConfirmButton(
                      color: mainColor,
                        radius: 10,
                        text: '가입하기',
                        fontSize: size.width * 0.01,
                        fontWeight: FontWeight.w600,
                        width: size.width,
                        height: 60,
                        onPressed: () async { // TODO: saving버그 수정해야함
                          saving(context);
                          if(controller.selectedSpotIdList.isEmpty){
                            Get.back();
                            if(!Get.isSnackbarOpen){
                              Get.snackbar('입력 오류', '지점을 선택해주세요.', backgroundColor: Colors.red, colorText: Colors.white);
                            }
                            else{
                              Get.back();
                            }
                            return;
                          }
                          if(controller.emailController.text.isEmpty || controller.hpController.text.isEmpty || controller.passwordController.text.isEmpty || controller.passwordCheckController.text.isEmpty || controller.nameController.text.isEmpty){
                            Get.back();
                            if(!Get.isSnackbarOpen){
                              Get.snackbar('입력 오류', '모든 항목을 입력해주세요.', backgroundColor: Colors.red, colorText: Colors.white);
                            }else{
                              Get.back();
                            }
                            return;
                          }
                          if(controller.passwordController.text.length < 6){
                            Get.back();
                            if(!Get.isSnackbarOpen){
                              Get.snackbar('비밀번호 오류', '비밀번호는 6자리 이상이어야 합니다.', backgroundColor: Colors.red, colorText: Colors.white);
                            }else{
                              Get.back();
                            }
                            return;
                          }
                          if(controller.passwordController.text != controller.passwordCheckController.text){
                            Get.back();
                            if(!Get.isSnackbarOpen){
                              Get.snackbar('비밀번호 불일치', '비밀번호가 일치하지 않습니다.', backgroundColor: Colors.red, colorText: Colors.white);
                            }else{
                              Get.back();
                            }
                            return;
                          }
                          if(await controller.sign.signUp(controller.emailController.text, controller.passwordController.text, controller.nameController.text, controller.positionList[controller.selectedType.value], controller.selectedSpotIdList, controller.hpController.text)){
                            Get.offAllNamed(Routes.SIGN_IN_PAGE);
                            Get.snackbar('회원가입 성공', '승인이 완료되면 로그인 할 수 있습니다.');
                          }
                          else{
                            Get.back();
                            if(!Get.isSnackbarOpen){
                              Get.snackbar('회원가입 실패', '회원가입에 실패하였습니다.', backgroundColor: Colors.red, colorText: Colors.white);
                            }else{
                              Get.back();
                            }
                          }
                        }
                    )
                  ],
                ),
              ),
            ),
            Expanded(flex: 1, child: Container()), // 오른쪽 여백
          ],
        ),
      ),
    );
  }
  Widget checkBox({required Size size, required int index, required String type}){
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: mainColor,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return mainColor; // 체크된 상태일 때 색상
            }
            return Color(0xffd4d4d4); // 체크 해제된 상태일 때 배경색
          }),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          splashRadius: 10,
          side: BorderSide.none,
          value: index == controller.selectedType.value,
          onChanged: (value) {
            controller.selectedType.value = index;
            if(controller.selectedType.value != 3){
              if(controller.selectedSpotIdList.isNotEmpty && controller.selectedSpotIdList.length == 1){
                String temp = controller.selectedSpotIdList[0];
                controller.selectedSpotIdList.clear();
                controller.selectedSpotIdList.add(temp);
              }
              else{
                controller.selectedSpotIdList.clear();
                controller.selectedItem.value = '소속지점';
              }
              // controller.selectedItem.value = controller.items[0].name;
            }
            else{
              controller.selectedSpotIdList.clear();
              controller.selectedItems.value = '소속지점';
            }
            print(controller.selectedSpotIdList);
          },
        ),
        Text(type, style: TextStyle(fontSize: size.width * 0.0104, fontWeight: FontWeight.w500, color: gray700), maxLines: 1,),
      ],
    );
  }

  Widget _inputField({required String hint, required TextEditingController controller, required bool isPassword, required Size size}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 9,
      children: [
        Text(hint, style: TextStyle(fontSize: size.width * 0.0104, fontWeight: FontWeight.w600, color: gray900),),
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: bg
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            style: TextStyle(fontSize: size.width * 0.0078, fontWeight: FontWeight.w400, color: gray900),
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
    );
  }
}
