import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/models/userData.dart';

class UserDataManagement{
  final db = FirebaseFirestore.instance;

  // 사용자 데이터 get
  Future<List<UserData>> getUserDataList() async {
    try{
      final result = await db.collection('user').orderBy('createDate', descending: true).get();
      return result.docs.map((doc) => UserData.fromJson(doc)).toList();
    }
    catch(e){
      print(e);
      return [];
    }
  }

  Future<bool> addUserData(UserData userData) async {
    try{
      final snapshot = await db.collection('user').where('phone', isEqualTo: userData.phone).get();
      if(snapshot.docs.isNotEmpty){
        if(!Get.isSnackbarOpen){
          Get.snackbar('회원 추가 실패', '이미 등록된 전화번호입니다.');
        }
        return false;
      }
      await db.collection('user').doc().set(userData.toJson());
      return true;
    }
    catch(e){
      print(e);
      if(!Get.isSnackbarOpen){
        Get.snackbar('회원 추가 실패', '잠시 후 다시 시도해주세요.');
      }
      return false;
    }
  }

  Future<bool> updateUserData(UserData userData) async {
    try{
      final snapshot = await db.collection('user').where('phone', isEqualTo: userData.phone).get();
      if(snapshot.docs.isNotEmpty){
        if(!Get.isSnackbarOpen){
          Get.snackbar('회원 추가 실패', '이미 등록된 전화번호입니다.');
        }
        return false;
      }
      await db.collection('user').doc(userData.documentId).update({
        'phone': userData.phone,
      });
      return true;
    }
    catch(e){
      print(e);
      if(!Get.isSnackbarOpen){
        Get.snackbar('회원 추가 실패', '잠시 후 다시 시도해주세요.');
      }
      return false;
    }
  }

  Future<void> updateUserTicket(UserData userData, bool isPause) async {
    try{
      if(isPause){
        userData.ticket.pause -= 1;
      }
      await db.collection('user').doc(userData.documentId).update({
        'ticket': userData.ticket.toJson(),
      });
    }
    catch(e){
      print(e);
    }
  }
}