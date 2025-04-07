import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jns_package/jns_package.dart' as jns;
import 'package:white_gym_web/app/modules/membership/controllers/membership_management_controller.dart';
import 'package:white_gym_web/app/theme/app_color.dart';
import 'package:white_gym_web/global/global.dart';

class MembershipManagementDetailPage extends GetView<MembershipManagementController> {
  MembershipManagementDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !controller.isDetailView.value,
      onPopInvokedWithResult: (bool, result) {
        controller.isDetailView.value = false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 60,
              children: [
                Container(
                  width: 960,
                  // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: gray200, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => componentColumn('멤버쉽 유형',
                        Row(
                          spacing: 45,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Checkbox(
                                    activeColor: mainColor,
                                    value: controller.selectedSpotItem.value.isSubscribe.value,
                                    onChanged: (bool? bool){
                                      controller.selectedSpotItem.value.isSubscribe.value = !controller.selectedSpotItem.value.isSubscribe.value;
                                    }),
                                GestureDetector(
                                    onTap: (){
                                      controller.selectedSpotItem.value.isSubscribe.value = !controller.selectedSpotItem.value.isSubscribe.value;
                                    },
                                    child: Text('구독형 멤버쉽(장기 결제)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),))
                              ],
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Checkbox(
                                    activeColor: mainColor,
                                    value: !controller.selectedSpotItem.value.isSubscribe.value,
                                    onChanged: (bool? bool){
                                      controller.selectedSpotItem.value.isSubscribe.value = !controller.selectedSpotItem.value.isSubscribe.value;
                                    }),
                                GestureDetector(
                                    onTap: (){
                                      controller.selectedSpotItem.value.isSubscribe.value = !controller.selectedSpotItem.value.isSubscribe.value;
                                    },
                                    child: Text('일반 멤버쉽(단건 결제)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),))
                              ],

                            )
                          ],
                        ),
                      ),),
                      Container(height: 1, color: gray200,),
                      componentColumn('멤버쉽 상품 이름',
                        SizedBox(
                          width: 880,
                          child: TextField(
                            controller: controller.nameController,
                            onChanged: (text){
                              controller.selectedSpotItem.value.name = text;
                            },
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            maxLength: 20,
                            decoration: InputDecoration(
                              hintText: '20글자 이내로 작성해주세요.',
                              hintStyle: TextStyle(fontSize: 18, color: gray300, fontWeight: FontWeight.w400),
                              counter: SizedBox(),
                            ),
                          ),
                        ),
                      ),
                      Container(height: 1, color: gray200,),
                      componentColumn('멤버쉽 상세 설명',
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // spacing: 40,
                            children: [
                              Row(
                                spacing: 14,
                                children: [
                                  Text('상세 설명1:', style: childStyle,),
                                  componentTextField(300, '18글자 이내로 작성해주세요.', controller.descriptions1Controller, childStyle, 20, TextAlign.start, maxLength: 18,
                                    onChanged: (text){
                                      controller.selectedSpotItem.value.descriptions1 = text;
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 14,
                                children: [
                                  Text('상세 설명2:', style: childStyle,),
                                  componentTextField(300, '18글자 이내로 작성해주세요.', controller.descriptions2Controller, childStyle, 20, TextAlign.start, maxLength: 18,
                                    onChanged: (text){
                                      controller.selectedSpotItem.value.descriptions2 = text;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                      Container(height: 1, color: gray200,),
                      componentColumn('멤버쉽 옵션 설정',
                          Obx(() => Column(
                            children: [
                              if(!controller.selectedSpotItem.value.isSubscribe.value)
                                Row(
                                  children: [
                                    Text('이용권 개월 수', style: childStyle,),
                                    componentTextField(95, '숫자만 입력', controller.monthlyController, childStyle, 14, TextAlign.right, keyboardType: TextInputType.number,
                                      onChanged: (text){
                                        controller.selectedSpotItem.value.monthly = int.parse(text);
                                      },
                                    ),
                                    Text('개월', style: childStyle,),
                                  ],
                                ),
                              Row(
                                spacing: !controller.selectedSpotItem.value.isSubscribe.value ? 50 : 0,
                                children: [
                                  if(!controller.selectedSpotItem.value.isSubscribe.value)
                                    Row(
                                      children: [
                                        Text('이용권 일시정지 가능 횟수', style: childStyle,),
                                        componentTextField(95, '숫자만 입력', controller.pauseController, childStyle, 14, TextAlign.right, keyboardType: TextInputType.number,
                                          onChanged: (text){
                                            controller.selectedSpotItem.value.pause = int.parse(text);
                                          },
                                        ),
                                        Text('회', style: childStyle,),
                                      ],
                                    ),
                                  Row(
                                    children: [
                                      Text('일일 입장 가능 횟수', style: childStyle,),
                                      componentTextField(95, '숫자만 입력', controller.admissionController, childStyle, 14, TextAlign.right, keyboardType: TextInputType.number,
                                        onChanged: (text){
                                          controller.selectedSpotItem.value.admission = int.parse(text);
                                        },
                                      ),
                                      Text('회', style: childStyle,),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                          )),
                      Container(height: 1, color: gray200,),
                      Obx(() => componentColumn('이용 가능 지점',
                        Row(
                          spacing: 45,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Checkbox(
                                    activeColor: mainColor,
                                    value: controller.selectedSpotItem.value.passTicket.value,
                                    onChanged: (bool? bool){
                                      controller.selectedSpotItem.value.passTicket.value = !controller.selectedSpotItem.value.passTicket.value;
                                    }),
                                GestureDetector(
                                    onTap: (){
                                      controller.selectedSpotItem.value.passTicket.value = !controller.selectedSpotItem.value.passTicket.value;
                                    },
                                    child: Text('전체 지점 이용가능', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),))
                              ],
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Checkbox(
                                    activeColor: mainColor,
                                    value: !controller.selectedSpotItem.value.passTicket.value,
                                    onChanged: (bool? bool){
                                      controller.selectedSpotItem.value.passTicket.value = !controller.selectedSpotItem.value.passTicket.value;
                                    }),
                                GestureDetector(
                                    onTap: (){
                                      controller.selectedSpotItem.value.passTicket.value = !controller.selectedSpotItem.value.passTicket.value;
                                    },
                                    child: Text('해당 지점만 이용 가능', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),))
                              ],

                            )
                          ],
                        ),
                      ),),
                      Container(height: 1, color: gray200,),
                      componentColumn('기타 서비스',
                          Obx(() => SizedBox(
                              width: 270,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('개인 락커 비용${controller.selectedSpotItem.value.isSubscribe.value ? '(월)' : ''} ', style: childStyle,),
                                      Row(
                                        children: [
                                          componentTextField(95, '숫자만 입력', controller.lockerController, childStyle, 14, TextAlign.center, keyboardType: TextInputType.number,
                                            onChanged: (text){
                                              controller.selectedSpotItem.value.locker = int.parse(text);
                                            },
                                          ),
                                          Text('원', style: childStyle,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('회원복 비용${controller.selectedSpotItem.value.isSubscribe.value ? '(월)' : ''}', style: childStyle,),
                                      Row(
                                        children: [
                                          componentTextField(95, '숫자만 입력', controller.sportswearController, childStyle, 14, TextAlign.center, keyboardType: TextInputType.number,
                                            onChanged: (text){
                                              controller.selectedSpotItem.value.sportswear = int.parse(text);
                                            },
                                          ),
                                          Text('원', style: childStyle,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Container(height: 1, color: gray200,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 30,
                          children: [
                            Text.rich(
                                TextSpan(
                                    children:
                                    [
                                      TextSpan(text: '이벤트 여부', style: titleStyle),
                                      TextSpan(text: ' (선택) ', style: TextStyle(fontSize: 20, color: gray500, fontWeight: FontWeight.w600)),
                                      TextSpan(text: ' 이벤트 선택 시, 멤버쉽 선택 화면에서 EVENT 스티커가 부착되며, 할인 전 가격을 설정할 수 있습니다.',
                                          style: TextStyle(fontSize: 16, color: gray500, fontWeight: FontWeight.w400)),
                                    ]
                                )
                            ),
                            Obx(() => Row(
                              children: [
                                Checkbox(
                                    activeColor: mainColor,
                                    value: controller.selectedSpotItem.value.discountCheck.value,
                                    onChanged: (bool? bool){
                                      controller.selectedSpotItem.value.discountCheck.value = !controller.selectedSpotItem.value.discountCheck.value;
                                      if(controller.selectedSpotItem.value.discountCheck.value == false){
                                        controller.selectedSpotItem.value.beforeDiscount = 0;
                                      }
                                    }),
                                GestureDetector(
                                    onTap: (){
                                      controller.selectedSpotItem.value.discountCheck.value = !controller.selectedSpotItem.value.discountCheck.value;
                                      if(controller.selectedSpotItem.value.discountCheck.value == false){
                                        controller.selectedSpotItem.value.beforeDiscount = 0;
                                      }
                                    },
                                    child: Text('할인 전 가격' , style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w500),)),
                                componentTextField(128, '숫자만 입력', controller.beforeDiscountController, childStyle, 18, TextAlign.center, keyboardType: TextInputType.number,
                                  onChanged: (text){
                                    controller.selectedSpotItem.value.beforeDiscount = int.parse(text);
                                  },
                                ),
                                Text('원', style: childStyle,)
                              ],
                            ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 1, color: gray200,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 30,
                          children: [
                            Text.rich(
                                TextSpan(
                                    children:
                                    [
                                      TextSpan(text: '판매 금액', style: titleStyle),
                                      TextSpan(text: ' 기타 서비스 비용을 제외한, 멤버쉽 판매 금액을 입력해주세요.', style: TextStyle(fontSize: 16, color: gray500, fontWeight: FontWeight.w400)),
                                    ]
                                )
                            ),
                            Obx(() => Row(
                              children: [
                                Text(controller.selectedSpotItem.value.isSubscribe.value ? '멤버쉽 요금(월)' : '멤버쉽 요금', style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w500),),
                                componentTextField(128, '숫자만 입력', controller.priceController, childStyle, 18, TextAlign.center, keyboardType: TextInputType.number,
                                  onChanged: (text){
                                    controller.selectedSpotItem.value.price = int.parse(text);
                                  },
                                ),
                                Text('원', style: childStyle,)
                              ],
                            ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                jns.ConfirmButton(text: '저장', radius: 8, fontSize:26, fontWeight: FontWeight.w600, color: mainColor, width: 205, height: 60, onPressed: () async {
                  if(controller.nameController.text.isEmpty){
                    Get.snackbar('멤버쉽 상품 이름을 입력해주세요.', '멤버쉽 상품 이름을 입력해주세요.');
                    return;
                  }
                  if(controller.isUpdate){
                    await controller.updateSpotItem();
                  }
                  else{
                    await controller.addSpotItem();
                  }
                  // await controller.getSpotList();
                  // await controller.getSpotItemList();
                  controller.init();
                  controller.isDetailView.value = false;
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle titleStyle = TextStyle(fontSize: 24, color: gray700, fontWeight: FontWeight.w600);
  TextStyle childStyle = TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w500);

  Widget componentTextField (double width, String hintText, TextEditingController controller, TextStyle style, double fontsize, TextAlign textAlign, {int? maxLength, TextInputType? keyboardType, Function(String)? onChanged}) {
    return SizedBox(
      width: width,
      child: TextField(
        textAlign: textAlign,
        controller: controller,
        style: style,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: keyboardType != null ? [
          FilteringTextInputFormatter.digitsOnly
        ] : null,
        onChanged: onChanged,
        //     (text){
        //   if(keyboardType == TextInputType.number){
        //     controller.text = text.replaceAll(RegExp(r'[^0-9]'), '');
        //   }
        // },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: fontsize, color: gray300, fontWeight: FontWeight.w400),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          counter: SizedBox(),
        ),
      ),
    );
  }

  Widget componentColumn(String text, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 30,
        children: [
          Text(text, style: titleStyle),
          widget
        ],
      ),
    );
  }
}
