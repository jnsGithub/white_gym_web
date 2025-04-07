
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:white_gym_web/app/data/models/staff.dart';

String version = 'v1.0.9';

CollectionReference<Map<String, dynamic>> userDB = FirebaseFirestore.instance.collection('user');
CollectionReference<Map<String, dynamic>> staffDB = FirebaseFirestore.instance.collection('staff');
CollectionReference<Map<String, dynamic>> spotDB = FirebaseFirestore.instance.collection('spot');
CollectionReference<Map<String, dynamic>> spotItemDB = FirebaseFirestore.instance.collection('spotItem');
CollectionReference<Map<String, dynamic>> visitHistoryDB = FirebaseFirestore.instance.collection('visitHistory');



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

Future<void> getMyInfo(String uid) async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('staff').doc(uid).get();
    myInfo.value = Staff.fromJson(snapshot);
  } catch (e) {
    print('내 정보 가져올때 걸림 : ${e}');
  }
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
