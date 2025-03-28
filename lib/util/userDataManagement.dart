import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/userData.dart';

class UserDataManagement{
  final db = FirebaseFirestore.instance;

  // 사용자 데이터 get
  Future<List<UserData>> getUserDataList() async {
    try{
      if(myInfo.value.position != '마스터'){
        var future1 = userDB
            .where('ticket.spotDocumentId', whereIn: myInfo.value.spotIdList)
            .orderBy('createDate', descending: true)
            .get();

        var future2 = userDB
            .where('ticket.paymentBranch', isEqualTo: '')
            .orderBy('createDate', descending: true)
            .get();

        // 병렬 실행 후 결과 취합
        List<QuerySnapshot> results = await Future.wait([future1, future2]);

        // Set을 사용하여 중복 제거
        Set<String> documentIds = {};
        List<UserData> allUserData = [];

        for (var result in results) {
          for (var doc in result.docs) {
            if (!documentIds.contains(doc.id)) {
              documentIds.add(doc.id);
              allUserData.add(UserData.fromJson(doc));
            }
          }
        }
        allUserData.sort((a, b) => b.createDate.compareTo(a.createDate));
        // for(var data in allUserData){
        //   print(data.createDate.toDate());
        // }

        return allUserData;
      }
      else{
        final result = await userDB.orderBy('createDate', descending: true).get();
        return result.docs.map((doc) => UserData.fromJson(doc)).toList();
      }
    }
    catch(e){
      print(e);
      return [];
    }
  }

  Future<bool> addUserData(UserData userData) async {
    try{
      final snapshot = await userDB.where('phone', isEqualTo: userData.phone).get();
      if(snapshot.docs.isNotEmpty){
        if(!Get.isSnackbarOpen){
          Get.snackbar('회원 추가 실패', '이미 등록된 전화번호입니다.');
        }
        return false;
      }
      var data = userData.toJson();
      data['createAdminId'] = myInfo.value.documentId;
      await userDB.doc().set(data);
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
      final snapshot = await userDB.where('phone', isEqualTo: userData.phone).get();
      final snapshot2 = await userDB.doc(userData.documentId).get();
      print(userData.phone);
      print(snapshot2.data()!['phone']);
      if(snapshot.docs.isNotEmpty && userData.phone != snapshot2.data()!['phone']){
        if(!Get.isSnackbarOpen){
          Get.snackbar('전화번호 변경 실패', '이미 등록된 전화번호입니다.');
        }
        return false;
      }
      await userDB.doc(userData.documentId).update({
        'phone': userData.phone,
        'gender': userData.gender
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
      await userDB.doc(userData.documentId).update({
        'ticket': userData.ticket.toJson(),
      });
    }
    catch(e){
      print(e);
    }
  }
}