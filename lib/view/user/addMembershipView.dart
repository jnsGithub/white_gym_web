// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:white_gym_web/global.dart';
// import 'package:white_gym_web/models/spotItem.dart';
// import 'package:white_gym_web/models/ticket.dart';
// import 'package:white_gym_web/models/userData.dart';
// import 'package:white_gym_web/view/user/userManagementController.dart';
// import 'package:jns_package/jns_package.dart' as jns;
//
// class AddMembershipView extends GetView<UserManagementController> {
//   AddMembershipView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     UserData selectedUser = controller.addUserData.copyWith();
//     Ticket selectedTicket = Ticket.empty();// selectedUser.ticket;
//     SpotItem selectedSpotItem = SpotItem.empty();//selectedTicket.spotItem;
//     selectedTicket.status = true;
//     selectedTicket.paymentBranch = selectedUser.ticket.paymentBranch;
//     selectedTicket.userDocumentId = selectedUser.documentId;
//     selectedTicket.spotDocumentId = selectedUser.ticket.spotDocumentId;
//
//     TextEditingController nameController = TextEditingController();
//     TextEditingController descriptions1Controller = TextEditingController();
//     TextEditingController descriptions2Controller = TextEditingController();
//     TextEditingController admissionController = TextEditingController();
//     TextEditingController lockerController = TextEditingController();
//     TextEditingController sportswearController = TextEditingController();
//     TextEditingController beforeDiscountController = TextEditingController();
//     TextEditingController priceController = TextEditingController();
//     TextEditingController monthlyController = TextEditingController();
//     TextEditingController pauseController = TextEditingController();
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             spacing: 60,
//             children: [
//               Container(
//                 width: 960,
//                 // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: gray200, width: 1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(height: 1, color: gray200,),
//                     ComponentColumn('멤버쉽 상품 이름',
//                       Container(
//                         width: 880,
//                         child: TextField(
//                           controller: nameController,
//                           onChanged: (text){
//                             selectedSpotItem.name = text;
//                           },
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                           maxLength: 20,
//                           decoration: InputDecoration(
//                             hintText: '20글자 이내로 작성해주세요.',
//                             hintStyle: TextStyle(fontSize: 18, color: gray300, fontWeight: FontWeight.w400),
//                             counter: SizedBox(),
//                             // contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                             // border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(height: 1, color: gray200,),
//                     ComponentColumn('멤버쉽 상세 설명',
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           // spacing: 40,
//                           children: [
//                             Row(
//                               spacing: 14,
//                               children: [
//                                 Text('상세 설명1:', style: childStyle,),
//                                 ComponentTextField(300, '18글자 이내로 작성해주세요.', descriptions1Controller, childStyle, 20, TextAlign.start, maxLength: 18,
//                                   onChanged: (text){
//                                     selectedSpotItem.descriptions1 = text;
//                                   },
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               spacing: 14,
//                               children: [
//                                 Text('상세 설명2:', style: childStyle,),
//                                 ComponentTextField(300, '18글자 이내로 작성해주세요.', descriptions2Controller, childStyle, 20, TextAlign.start, maxLength: 18,
//                                   onChanged: (text){
//                                     selectedSpotItem.descriptions2 = text;
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )
//                     ),
//                     Container(height: 1, color: gray200,),
//                     ComponentColumn('멤버쉽 옵션 설정',
//                         Obx(() => Column(
//                           children: [
//                             if(!selectedSpotItem.isSubscribe.value)
//                               Row(
//                                 children: [
//                                   Text('이용권 개월 수', style: childStyle,),
//                                   ComponentTextField(95, '숫자만 입력', monthlyController, childStyle, 14, TextAlign.right, keyboardType: TextInputType.number,
//                                     onChanged: (text){
//                                       selectedSpotItem.monthly = int.parse(text);
//                                       selectedTicket.endDate = DateTime.now().add(Duration(days: 30 * int.parse(text) - 1));
//                                     },
//                                   ),
//                                   Text('개월', style: childStyle,),
//                                 ],
//                               ),
//                             Row(
//                               spacing: !selectedSpotItem.isSubscribe.value ? 50 : 0,
//                               children: [
//                                 if(!selectedSpotItem.isSubscribe.value)
//                                   Row(
//                                     children: [
//                                       Text('이용권 일시정지 가능 횟수', style: childStyle,),
//                                       ComponentTextField(95, '숫자만 입력', pauseController, childStyle, 14, TextAlign.right, keyboardType: TextInputType.number,
//                                         onChanged: (text){
//                                           selectedSpotItem.pause = int.parse(text);
//                                           selectedTicket.pause = int.parse(text);
//                                         },
//                                       ),
//                                       Text('회', style: childStyle,),
//                                     ],
//                                   ),
//                                 Row(
//                                   children: [
//                                     Text('일일 입장 가능 횟수', style: childStyle,),
//                                     ComponentTextField(95, '숫자만 입력', admissionController, childStyle, 14, TextAlign.right, keyboardType: TextInputType.number,
//                                       onChanged: (text){
//                                         selectedSpotItem.admission = int.parse(text);
//                                         selectedTicket.admission = int.parse(text);
//                                       },
//                                     ),
//                                     Text('회', style: childStyle,),
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                           ],
//                         ),
//                         )),
//                     Container(height: 1, color: gray200,),
//                     Obx(() => ComponentColumn('이용 가능 지점',
//                       Row(
//                         spacing: 45,
//                         children: [
//                           Row(
//                             spacing: 10,
//                             children: [
//                               Checkbox(
//                                   activeColor: mainColor,
//                                   value: !selectedSpotItem.passTicket.value,
//                                   onChanged: (bool){
//                                     selectedSpotItem.passTicket.value = !selectedSpotItem.passTicket.value;
//                                     selectedTicket.passTicket = !selectedSpotItem.passTicket.value;
//                                     print(selectedTicket.passTicket);
//                                   }),
//                               GestureDetector(
//                                   onTap: (){
//                                     selectedSpotItem.passTicket.value = !selectedSpotItem.passTicket.value;
//                                     selectedTicket.passTicket = !selectedSpotItem.passTicket.value;
//                                   },
//                                   child: Text('전체 지점 이용가능', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),))
//                             ],
//                           ),
//                           Row(
//                             spacing: 10,
//                             children: [
//                               Checkbox(
//                                   activeColor: mainColor,
//                                   value: selectedSpotItem.passTicket.value,
//                                   onChanged: (bool){
//                                     selectedSpotItem.passTicket.value = !selectedSpotItem.passTicket.value;
//                                     selectedTicket.passTicket = !selectedSpotItem.passTicket.value;
//                                     print(selectedTicket.passTicket);
//                                   }),
//                               GestureDetector(
//                                   onTap: (){
//                                     selectedSpotItem.passTicket.value = !selectedSpotItem.passTicket.value;
//                                     selectedTicket.passTicket = !selectedSpotItem.passTicket.value;
//                                   },
//                                   child: Text('해당 지점만 이용 가능', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),))
//                             ],
//
//                           )
//                         ],
//                       ),
//                     ),),
//                     Container(height: 1, color: gray200,),
//                     ComponentColumn('기타 서비스',
//                         Obx(() => Container(
//                           width: 270,
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text('개인 락커 비용${selectedSpotItem.isSubscribe.value ? '(월)' : ''} ', style: childStyle,),
//                                   Row(
//                                     children: [
//                                       ComponentTextField(95, '숫자만 입력', lockerController, childStyle, 14, TextAlign.center, keyboardType: TextInputType.number,
//                                         onChanged: (text){
//                                           selectedSpotItem.locker = int.parse(text);
//                                           selectedTicket.locker = text != '0' && text != '';
//                                         },
//                                       ),
//                                       Text('원', style: childStyle,),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text('회원복 비용${selectedSpotItem.isSubscribe.value ? '(월)' : ''}', style: childStyle,),
//                                   Row(
//                                     children: [
//                                       ComponentTextField(95, '숫자만 입력', sportswearController, childStyle, 14, TextAlign.center, keyboardType: TextInputType.number,
//                                         onChanged: (text){
//                                           selectedSpotItem.sportswear = int.parse(text);
//                                           selectedTicket.sportswear = text != '0' && text != '';
//                                         },
//                                       ),
//                                       Text('원', style: childStyle,),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         )),
//                     Container(height: 1, color: gray200,),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         spacing: 30,
//                         children: [
//                           Text.rich(
//                               TextSpan(
//                                   children:
//                                   [
//                                     TextSpan(text: '이벤트 여부', style: titleStyle),
//                                     TextSpan(text: ' (선택) ', style: TextStyle(fontSize: 20, color: gray500, fontWeight: FontWeight.w600)),
//                                     TextSpan(text: ' 이벤트 선택 시, 멤버쉽 선택 화면에서 EVENT 스티커가 부착되며, 할인 전 가격을 설정할 수 있습니다.',
//                                         style: TextStyle(fontSize: 16, color: gray500, fontWeight: FontWeight.w400)),
//                                   ]
//                               )
//                           ),
//                           Obx(() => Row(
//                             children: [
//                               Checkbox(
//                                   activeColor: mainColor,
//                                   value: selectedSpotItem.discountCheck.value,
//                                   onChanged: (bool){
//                                     selectedSpotItem.discountCheck.value = !selectedSpotItem.discountCheck.value;
//                                     if(selectedSpotItem.discountCheck.value == false){
//                                       selectedSpotItem.beforeDiscount = 0;
//                                       beforeDiscountController.text = '';
//                                     }
//                                   }),
//                               GestureDetector(
//                                   onTap: (){
//                                     selectedSpotItem.discountCheck.value = !selectedSpotItem.discountCheck.value;
//                                     if(selectedSpotItem.discountCheck.value == false){
//                                       selectedSpotItem.beforeDiscount = 0;
//                                       beforeDiscountController.text = '';
//                                     }
//                                   },
//                                   child: Text('할인 전 가격' , style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w500),)),
//                               ComponentTextField(128, '숫자만 입력', beforeDiscountController, childStyle, 18, TextAlign.center, keyboardType: TextInputType.number,
//                                 onChanged: (text){
//                                   if(!selectedSpotItem.discountCheck.value){
//                                     beforeDiscountController.text = '';
//                                   }
//                                   selectedSpotItem.beforeDiscount = int.parse(text);
//                                 },
//                               ),
//                               Text('원', style: childStyle,)
//                             ],
//                           ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(height: 1, color: gray200,),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         spacing: 30,
//                         children: [
//                           Text.rich(
//                               TextSpan(
//                                   children:
//                                   [
//                                     TextSpan(text: '판매 금액', style: titleStyle),
//                                     TextSpan(text: ' 기타 서비스 비용을 제외한, 멤버쉽 판매 금액을 입력해주세요.', style: TextStyle(fontSize: 16, color: gray500, fontWeight: FontWeight.w400)),
//                                   ]
//                               )
//                           ),
//                           Obx(() => Row(
//                             children: [
//                               Text(selectedSpotItem.isSubscribe.value ? '멤버쉽 요금(월)' : '멤버쉽 요금', style: TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w500),),
//                               ComponentTextField(128, '숫자만 입력', priceController, childStyle, 18, TextAlign.center, keyboardType: TextInputType.number,
//                                 onChanged: (text){
//                                   selectedSpotItem.price = int.parse(text);
//                                 },
//                               ),
//                               Text('원', style: childStyle,)
//                             ],
//                           ),
//                           ),
//
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               jns.ConfirmButton(text: '저장', radius: 8, fontSize:26, fontWeight: FontWeight.w600, color: mainColor, width: 205, height: 60, onPressed: () async {
//                 bool isReady = nameController.text.isNotEmpty
//                     && admissionController.text.isNotEmpty
//                     && priceController.text.isNotEmpty
//                     && monthlyController.text.isNotEmpty
//                     && pauseController.text.isNotEmpty;
//                 print(
//                     'name: ${nameController.text.isNotEmpty}, '
//                         'admission: ${admissionController.text.isNotEmpty}, '
//                         'price: ${priceController.text.isNotEmpty}, '
//                         'monthly: ${monthlyController.text.isNotEmpty}, '
//                         'pause: ${pauseController.text.isNotEmpty}');
//
//                 if(!isReady){
//                   Get.snackbar('회원 이용권 등록 실패', '멤버쉽 상세설명, 기타서비스, 이벤트 여부를 제외한 모든 항목을 입력해주세요.');
//                   return;
//                 }
//                 saving(context);
//                 selectedSpotItem.spotDocumentId = 'custom';
//                 selectedTicket.userDocumentId = selectedUser.documentId;
//                 selectedTicket.spotItem = selectedSpotItem;
//                 selectedTicket.status = true;
//                 selectedUser.ticket = selectedTicket;
//                 await controller.userDataManagement.updateUserTicket(selectedUser, false);
//                 controller.isAddView.value = false;
//                 controller.init();
//                 Get.back();
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   TextStyle titleStyle = TextStyle(fontSize: 24, color: gray700, fontWeight: FontWeight.w600);
//   TextStyle childStyle = TextStyle(fontSize: 20, color: gray900, fontWeight: FontWeight.w500);
//
//   Widget ComponentTextField (double width, String hintText, TextEditingController controller, TextStyle style, double fontsize, TextAlign textAlign, {int? maxLength, TextInputType? keyboardType, Function(String)? onChanged}) {
//     return Container(
//       width: width,
//       child: TextField(
//         textAlign: textAlign,
//         controller: controller,
//         style: style,
//         maxLength: maxLength,
//         keyboardType: keyboardType,
//         inputFormatters: keyboardType != null ? [
//           FilteringTextInputFormatter.digitsOnly
//         ] : null,
//         onChanged: onChanged,
//         //     (text){
//         //   if(keyboardType == TextInputType.number){
//         //     controller.text = text.replaceAll(RegExp(r'[^0-9]'), '');
//         //   }
//         // },
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: TextStyle(fontSize: fontsize, color: gray300, fontWeight: FontWeight.w400),
//           contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           counter: SizedBox(),
//         ),
//       ),
//     );
//   }
//
//   Widget ComponentColumn(String text, Widget widget) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 30,
//         children: [
//           Text(text, style: titleStyle),
//           widget
//         ],
//       ),
//     );
//   }
// }
