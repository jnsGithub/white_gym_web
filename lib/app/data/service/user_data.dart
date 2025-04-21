import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/data/models/spot.dart';
import 'package:white_gym_web/global/global.dart';
import 'package:white_gym_web/app/data/models/ticket.dart';
import 'package:white_gym_web/app/data/models/user_data.dart';

class UserDataManagement{

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

  Future<int> getAllUsersLength(Spot selectedSpot) async {
    try{
      List<String>? sort = [];
      if(myInfo.value.position == '마스터' || (myInfo.value.position == '지점장' && myInfo.value.spotIdList.length > 1)){
        if(selectedSpot.documentId.isEmpty){
          sort = null;
        }
        else{
          sort = [selectedSpot.documentId];
        }
      }
      else{
        sort = myInfo.value.spotIdList;
      }
      return await userDB.where('ticket.spotDocumentId', whereIn: sort).count().get().then((value) => value.count!);
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
      await adminHistoryDB.doc().set({
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

  Future<List<UserData>> getUserList({UserData? lastUser, Spot? selectedSpot, bool init = true, required int maxListCount}) async {
    try{
      print('add함');
      if(init){
        late QuerySnapshot snapshot;
        if(myInfo.value.position == '마스터'){
          if(selectedSpot!.documentId.isEmpty){
            snapshot = await userDB
                .orderBy('createDate', descending: true)
                .limit(maxListCount)
                .get();
          }
          else{
            snapshot = await userDB
                .where('ticket.spotDocumentId', isEqualTo: selectedSpot.documentId)
                .orderBy('createDate', descending: true)
                .limit(maxListCount)
                .get();
          }
        }
        else{
          snapshot = await userDB
              .where('ticket.spotDocumentId', whereIn: myInfo.value.spotIdList)
              .orderBy('createDate', descending: true)
              .limit(maxListCount)
              .get();
        }

        List<UserData> userList = [];
        for(var i in snapshot.docs){
          userList.add(UserData.fromJson(i));
        }
        return userList;
      }
      else{
        late QuerySnapshot snapshot;
        if(selectedSpot!.documentId.isEmpty){
          if(myInfo.value.position == '마스터'){
            snapshot = await userDB
                .orderBy('createDate', descending: true)
                .limit(maxListCount+1)
                .startAfterDocument(await userDB.doc(lastUser!.documentId).get())
                .get();
          }
          else{
            snapshot = await userDB
                .where('ticket.spotDocumentId', whereIn: myInfo.value.spotIdList)
                .orderBy('createDate', descending: true)
                .limit(maxListCount+1)
                .startAfterDocument(await userDB.doc(lastUser!.documentId).get())
                .get();
          }
        }
        else{
          snapshot = await userDB
              .where('ticket.spotDocumentId', isEqualTo: selectedSpot.documentId)
              .orderBy('createDate', descending: true)
              .limit(maxListCount+1)
              .startAfterDocument(await userDB.doc(lastUser!.documentId).get())
              .get();
        }

        List<UserData> userList = [];
        snapshot.docs.removeAt(0);
        for(var i in snapshot.docs){
          userList.add(UserData.fromJson(i));
        }
        return userList;
      }
    }
    catch(e){
      print(e);
      return [];
    }
  }

  Future<List<UserData>> searchUserList(Spot selectedSpot, String userName) async {
    try{
      late QuerySnapshot snapshot;
      if(selectedSpot.documentId.isEmpty){
        if(myInfo.value.position == '마스터'){
          snapshot = await userDB
              .orderBy('createDate', descending: true)
              .where('name', isEqualTo: userName)
              .get();
        }
        else{
          snapshot = await userDB
              .orderBy('createDate', descending: true)
              .where('ticket.spotDocumentId', whereIn: myInfo.value.spotIdList)
              .where('name', isEqualTo: userName)
              .get();
        }
        // snapshot = await db.collection('user')
        //     .orderBy('createDate', descending: true)
        //     .where('ticket.spotDocumentId', whereIn: myInfo.value.spotIdList)
        //     .where('name', isEqualTo: userName)
        //     .get();
      }
      else{
        snapshot = await userDB
            .orderBy('createDate', descending: true)
            .where('ticket.spotDocumentId', isEqualTo: selectedSpot.documentId)
            .where('name', isEqualTo: userName)
            .get();
      }

      List<UserData> userList = [];
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

  Future<void> getDummyUserData() async {
    try{
      // List<UserData> userDataList = [];
      final snapshot = await userDB.where('name', isEqualTo: '소정후').get();
      final snapshot2 = await userDB.where('name', isEqualTo: '성승화').get();

      // final snapshot = await userDB.where('ticket.spotItem.isSubscribe', isEqualTo: true).where('ticket.status', isEqualTo: false).where('ticket.subscribe', isEqualTo: true).get();
      for(var i in snapshot.docs){
        await FirebaseFirestore.instance.collection('user_test').doc(i.id).set(i.data());
        // }
      }
      for(var i in snapshot2.docs){
        await FirebaseFirestore.instance.collection('user_test').doc(i.id).set(i.data());
        // }
      }
    }
    catch(e){
      print(a);
      print(count);
      count = 0;
      print(e);
    }
  }


// Future<void> setTestDB() async{
//   QuerySnapshot userSnapshot = await db.collection('user').limit(1000).get();
//   QuerySnapshot spotSnapshot = await db.collection('spot').get();
//   QuerySnapshot staffSnapshot = await db.collection('staff').get();
//   QuerySnapshot adminModifyHistorySnapshot = await db.collection('adminModifyHistory').get();
//   QuerySnapshot spotItemSnapshot = await db.collection('spotItem').get();
//
//   String userTest = 'user_test';
//   String spotTest = 'spot_test';
//   String staffTest = 'staff_test';
//   String adminModifyHistoryTest = 'adminModifyHistory_test';
//   String spotItemTest = 'spotItem_test';
//
//
//   log(name: 'INFO', 'Data load success!');
//   log(name: 'INFO', '--------------------------------------------------------------------');
//   log(name: 'USER', 'User data set start!');
//   int count = 0;
//   var endCount = userSnapshot.docs.length;
//   for(var i in userSnapshot.docs){
//     await db.collection(userTest).doc(i.id).set(i.data() as Map<String, dynamic>);
//     count ++;
//     log(name: 'USER', '${count} / ${endCount}');
//   }
//   log(name: 'USER', 'User data set success!');
//   log(name: 'INFO', '--------------------------------------------------------------------');
//   log(name: 'SPOT', 'Spot data set start!');
//   endCount = spotSnapshot.docs.length;
//   for(var i in spotSnapshot.docs){
//     await db.collection(spotTest).doc(i.id).set(i.data() as Map<String, dynamic>);
//     count ++;
//     log(name: 'SPOT', '${count} / ${endCount}');
//   }
//   log(name: 'SPOT', 'Staff data set success!');
//   log(name: 'INFO', '--------------------------------------------------------------------');
//   log(name: 'STAFF', 'Staff data set start!');
//   endCount = staffSnapshot.docs.length;
//   count = 0;
//   for(var i in staffSnapshot.docs){
//     await db.collection(staffTest).doc(i.id).set(i.data() as Map<String, dynamic>);
//     count ++;
//     log(name: 'STAFF', '${count} / ${endCount}');
//   }
//   log(name: 'STAFF', 'Staff data set success!');
//   log(name: 'INFO', '--------------------------------------------------------------------');
//   log(name: 'ADMIN_HISTORY', 'Admin history data set start!');
//   endCount = adminModifyHistorySnapshot.docs.length;
//   count = 0;
//   for(var i in adminModifyHistorySnapshot.docs){
//     await db.collection(adminModifyHistoryTest).doc(i.id).set(i.data() as Map<String, dynamic>);
//     count ++;
//     log(name: 'ADMINHISTORY', '${count} / ${endCount}');
//   }
//   log(name: 'ADMIN_HISTORY', 'Admin history data set success!');
//   log(name: 'INFO', '--------------------------------------------------------------------');
//   log(name: 'SPOT_ITEM', 'SpotItem data set start!');
//
//   endCount = spotItemSnapshot.docs.length;
//   count = 0;
//
//   for(var i in spotItemSnapshot.docs){
//     await db.collection(spotItemTest).doc(i.id).set(i.data() as Map<String, dynamic>);
//     count ++;
//     log(name: 'SPOT_ITEM', '${count} / ${endCount}');
//   }
//   log(name: 'SPOT_ITEM', 'SpotItem data set success!');
//
//
// }
  // Future<void> setTestDB() async{
  //   QuerySnapshot userSnapshot = await db.collection('user').limit(1000).get();
  //   QuerySnapshot spotSnapshot = await db.collection('spot').get();
  //   QuerySnapshot staffSnapshot = await db.collection('staff').get();
  //   QuerySnapshot adminModifyHistorySnapshot = await db.collection('adminModifyHistory').get();
  //   QuerySnapshot spotItemSnapshot = await db.collection('spotItem').get();
  //
  //   String userTest = 'user_test';
  //   String spotTest = 'spot_test';
  //   String staffTest = 'staff_test';
  //   String adminModifyHistoryTest = 'adminModifyHistory_test';
  //   String spotItemTest = 'spotItem_test';
  //
  //
  //   log(name: 'INFO', 'Data load success!');
  //   log(name: 'INFO', '--------------------------------------------------------------------');
  //   log(name: 'USER', 'User data set start!');
  //   int count = 0;
  //   var endCount = userSnapshot.docs.length;
  //   for(var i in userSnapshot.docs){
  //     await db.collection(userTest).doc(i.id).set(i.data() as Map<String, dynamic>);
  //     count ++;
  //     log(name: 'USER', '${count} / ${endCount}');
  //   }
  //   log(name: 'USER', 'User data set success!');
  //   log(name: 'INFO', '--------------------------------------------------------------------');
  //   log(name: 'SPOT', 'Spot data set start!');
  //   endCount = spotSnapshot.docs.length;
  //   for(var i in spotSnapshot.docs){
  //     await db.collection(spotTest).doc(i.id).set(i.data() as Map<String, dynamic>);
  //     count ++;
  //     log(name: 'SPOT', '${count} / ${endCount}');
  //   }
  //   log(name: 'SPOT', 'Staff data set success!');
  //   log(name: 'INFO', '--------------------------------------------------------------------');
  //   log(name: 'STAFF', 'Staff data set start!');
  //   endCount = staffSnapshot.docs.length;
  //   count = 0;
  //   for(var i in staffSnapshot.docs){
  //     await db.collection(staffTest).doc(i.id).set(i.data() as Map<String, dynamic>);
  //     count ++;
  //     log(name: 'STAFF', '${count} / ${endCount}');
  //   }
  //   log(name: 'STAFF', 'Staff data set success!');
  //   log(name: 'INFO', '--------------------------------------------------------------------');
  //   log(name: 'ADMIN_HISTORY', 'Admin history data set start!');
  //   endCount = adminModifyHistorySnapshot.docs.length;
  //   count = 0;
  //   for(var i in adminModifyHistorySnapshot.docs){
  //     await db.collection(adminModifyHistoryTest).doc(i.id).set(i.data() as Map<String, dynamic>);
  //     count ++;
  //     log(name: 'ADMINHISTORY', '${count} / ${endCount}');
  //   }
  //   log(name: 'ADMIN_HISTORY', 'Admin history data set success!');
  //   log(name: 'INFO', '--------------------------------------------------------------------');
  //   log(name: 'SPOT_ITEM', 'SpotItem data set start!');
  //
  //   endCount = spotItemSnapshot.docs.length;
  //   count = 0;
  //
  //   for(var i in spotItemSnapshot.docs){
  //     await db.collection(spotItemTest).doc(i.id).set(i.data() as Map<String, dynamic>);
  //     count ++;
  //     log(name: 'SPOT_ITEM', '${count} / ${endCount}');
  //   }
  //   log(name: 'SPOT_ITEM', 'SpotItem data set success!');
  //
  //
  // }
}