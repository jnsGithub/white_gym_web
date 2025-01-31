
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:white_gym_web/models/staff.dart';

const mainColor = Color(0xff2969FF);
const bg = Color(0xffF7F7F9);
const text22 = Color(0xff222222);
const text7D = Color(0xff7D8697);
const gray900 = Color(0xff1A1A1A);
const gray800 = Color(0xff303030);
const gray700 = Color(0xff4A4A4A);
const gray600 = Color(0xff636366);
const gray500 = Color(0xff848487);
const gray400 = Color(0xff8E8E93);
const gray300 = Color(0xffAEAEB2);
const gray100 = Color(0xffE5E5EA);
const gray200 = Color(0xffD4D4D4);

Rx<Staff> myInfo = Staff(
  documentId: '',
  name: '',
  email: '',
  position: '',
  hp: '',
  spotIdList: [],
  createDate: DateTime.now(),
  isApproved: false,
).obs;

String uid = '';
// late MyInfo myInfo ;
int cash = 0;
// String formatTimestamp(Timestamp timestamp) {
//   DateTime dateTime = timestamp.toDate();
//   DateFormat dateFormat = DateFormat('MM.dd (EEE)', 'ko_KR');
//   return dateFormat.format(dateTime);
// }
String formatPhoneNumber(String phoneNumber) {
  if (phoneNumber.length == 11) {
    return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7, 11)}';
  } else {
    return phoneNumber;
  }
}

String formatNumber(int number) {
  final formatter = NumberFormat('#,###');
  return '${formatter.format(number)} 원';
}
String formatPoint(int number) {
  final formatter = NumberFormat('#,###');
  return '${formatter.format(number)} P';
}
void saving(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible:false,
      builder: (BuildContext context) {
        return const AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            elevation: 0, // 그림자 효과 없애기
            content: Center(
              child: CircularProgressIndicator(color: Colors.white,),
            )
        );
      });
}
