import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global/global.dart';
import 'package:white_gym_web/app/data/models/ticket.dart';
import 'package:white_gym_web/app/data/models/user_data.dart';

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
        // int a = 0;
        // print('start');
        //
        // userDB.orderBy('createDate', descending: true).get().then((result) {
        //   print('시작');
        //   var controller = Get.find<UserManagementController>();
        //   for(var doc in result.docs){
        //     controller.userDataList.add(UserData.fromJson(doc));
        //     print(a);
        //     a++;
        //   }
        //
        //   controller.userListSort();
        // });

        // List locker = [];
        // for (var i in locker){
        //   if(i.userId == ''){
        //     userList.add(UserData.empty());
        //   }
        //    else{
        //     var q = await userDB.doc(i.userId).get();
        //     userList.add(UserData.fromJson(q));
        //   }
        // }
        final result = await userDB.orderBy('createDate', descending: true).get();
        // for(var doc in result.docs){
        //   userList.add(UserData.fromJson(doc));
        //   userList.
        // }
        return result.docs.map((doc) => UserData.fromJson(doc)).toList();
      }
    }
    catch(e){
      print(e);
      return [];
    }
  }
  Future<int> getAllUsersLength() async {
    try{
      return await userDB.where('ticket.spotDocumentId', whereIn: myInfo.value.position == '마스터' ? null : myInfo.value.spotIdList).count().get().then((value) => value.count!);
    }
    catch(e){
      print(e);
      return 0;
    }
  }

  Future<List<UserData>> refreshUserData(List<UserData> userDataList) async {
    try{
      List<UserData> temp = [];
        var snapshot = await userDB.orderBy('createDate', descending: true).endBeforeDocument(await userDB.doc(userDataList.first.documentId).get()).get();
        print('userDataList.first : ${userDataList.first.documentId}');
      print('snapshot.docs.length : ${snapshot.docs.length}');
      for(var doc in snapshot.docs){
        print(doc.id);
        print(doc.data()['name']);
      }
      print('userDataList.length : ${userDataList.length}');
      return temp;
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

  Future<void> updateUserTicket(UserData userData, bool isPause,{bool isStatusFalse = false, UserData? beforeUserData}) async {
    try{
      if(isPause){
        userData.ticket.pause -= 1;
        if(beforeUserData != null){
          beforeUserData.ticket.pause += 1;
        }
      }
      await db.collection('adminModifyHistory').doc().set({
        'userDocumentId': userData.documentId,
        'adminDocumentId': myInfo.value.documentId,
        'beforeTicket': beforeUserData?.ticket.toJson(),
        'afterTicket': userData.ticket.toJson(),
        'createDate': DateTime.now(),
      });
      await userDB.doc(userData.documentId).update({
        'ticket': userData.ticket.toJson(),
      });
    }
    catch(e){
      print(e);
    }
  }

  int count = 0;
  var a;
  Future<void> getDummyUserData() async {
    try{
      // List<UserData> userDataList = [];
      final snapshot = await db.collection('user').where('ticket.spotItem.isSubscribe', isEqualTo: true).where('ticket.status', isEqualTo: false).where('ticket.subscribe', isEqualTo: true).get();
      for(var i in snapshot.docs){
        // if(i.data()['phone'].toString().length > 2){
        //   print(i.data()['phone']);
        // }
        // print(i.data()['phone'].toString().substring(0, 3));
        print(i.data()['name']);
        a = i.id;
        // if(i.data()['phone'].toString() != '' && i.data()['phone'].toString().length > 3 && i.data()['phone'].toString().substring(0, 4).contains('99')){
        //   print('${i.data()['phone']} - ${i.data()['name']}');
          count++;
        // }
      }
      print(count);
      count = 0;
    }
    catch(e){
      print(a);
      print(count);
      count = 0;
      print(e);
    }
  }

  Future<List<UserData>> getUser(UserData lastUser) async {
    try{
      final snapshot = await db.collection('user')
          .orderBy('createDate', descending: true)
          .startAfterDocument(await db.collection('user').doc(lastUser.documentId).get())
          .limit(11)
          .get();

      List<UserData> userList = [];
      snapshot.docs.removeAt(0);
      for(var i in snapshot.docs){
        userList.add(UserData.fromJson(i));
      }
      return userList;
    }
    catch(e){
      print(e);
      return [];
    }
  }
}