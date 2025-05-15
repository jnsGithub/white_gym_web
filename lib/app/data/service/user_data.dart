import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global/global.dart';

import '../models/spot/spot.dart';
import '../models/user/user.dart';

class UserDataManagement{

  // 사용자 데이터 get
  Future<List<User>> getUserDataList() async {
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
        List<User> allUserData = [];

        for (var result in results) {
          for (var doc in result.docs) {
            if (!documentIds.contains(doc.id)) {
              documentIds.add(doc.id);
              allUserData.add(User.fromJson(doc.data() as Map<String, dynamic>));
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
        return result.docs.map((doc) => User.fromJson(doc.data())).toList();
      }
    }
    catch(e){
      print('getUserDataList 걸림');
      print(e);
      return [];
    }
  }

  Future<int> getAllUsersLength(Spot selectedSpot) async {
    try{
      List<String>? sort = [];
      if(myInfo.value.position == '마스터'){
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
      print('getAllUsersLength 걸림');
      print(e);
      return 0;
    }
  }

  Future<List<User>> refreshUserData(List<User> userDataList) async {
    try{
      List<User> temp = [];
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
      print('refreshUserData 걸림');
      print(e);
      return [];
    }
  }

  Future<bool> addUserData(User userData) async {
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
      print('addUserData 걸림');
      print(e);
      if(!Get.isSnackbarOpen){
        Get.snackbar('회원 추가 실패', '잠시 후 다시 시도해주세요.');
      }
      return false;
    }
  }

  Future<bool> updateUserData(User userData) async {
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
      print('updateUserData 걸림');
      print(e);
      if(!Get.isSnackbarOpen){
        Get.snackbar('회원 추가 실패', '잠시 후 다시 시도해주세요.');
      }
      return false;
    }
  }

  Future<void> updateUserTicket(User userData, bool isPause,{bool isStatusFalse = false, User? beforeUserData}) async {
    try{
      if(isPause){
        userData = userData.copyWith(ticket: userData.ticket.copyWith(pause: userData.ticket.pause - 1)); //.pause -= 1;
        if(beforeUserData != null){
          beforeUserData = beforeUserData.copyWith(ticket: beforeUserData.ticket.copyWith(pause: beforeUserData.ticket.pause + 1)); //.ticket.pause += 1;
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
      print('updateUserTicket 걸림');
      print(e);
    }
  }

  int count = 0;
  var a;

  Future<List<User>> getUserList({User? lastUser, Spot? selectedSpot, bool init = true, required int maxListCount}) async {
    String docId = '';
    int count = 0;
    String phone = '';
    Map<String, dynamic> beforData = {};
    Map<String, dynamic> afterData = {};
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
          if(selectedSpot!.documentId.isEmpty){
            snapshot = await userDB
                .orderBy('createDate', descending: true)
                .where('ticket.spotDocumentId', whereIn: myInfo.value.spotIdList + [''],)
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

        List<User> userList = [];

        for(var i in snapshot.docs){
          Map<String, dynamic> data = i.data() as Map<String, dynamic>;
          beforData = afterData;
          afterData = data;
          data['documentId'] = i.id;
          count++;
          docId = data['documentId'];
          phone = data['phone'];
          print(data['ticket']['spotItem']['daily']);
          if(data['ticket']['spotItem']['daily'] == null){
            data['ticket']['spotItem']['daily'] = data['ticket']['spotItem']['monthly'] * 30;
          }
          // if(count < 1){
          //   print(i.data());
          // }
          userList.add(User.fromJson(data));
          if(count < 1){
            print('여긴 되나?');
          }
        }
        print('완료?');
        print(userList.length);
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
                .where('ticket.spotDocumentId', whereIn: myInfo.value.spotIdList + [''])
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

        List<User> userList = [];
        snapshot.docs.removeAt(0);
        for(var i in snapshot.docs){
          userList.add(User.fromJson(i.data() as Map<String, dynamic>));
        }
        return userList;
      }
    }
    catch(e){
      print(e);
      return [];
    }
  }

  // Future<List<UserData>> searchUserList(Spot selectedSpot, String userName, List<UserData> userList, List<DocumentSnapshot> docList) async {
  //   try{
  //     late QuerySnapshot snapshot;
  //       if(myInfo.value.position == '마스터'){
  //         if(userList.isEmpty){
  //           print(1);
  //           snapshot = await userDB
  //               .where('name', isGreaterThanOrEqualTo: userName)
  //               .limit(1)
  //               .get();
  //           if(snapshot.docs.isNotEmpty){
  //             print(2);
  //             userList.add(UserData.fromJson(snapshot.docs.first));
  //             docList.add(snapshot.docs.first);
  //             searchUserList(selectedSpot, userName, userList, docList);
  //           }
  //         }
  //         else{
  //           print(3);
  //           snapshot = await userDB
  //               .orderBy('name')
  //               .where('name', isGreaterThanOrEqualTo: userName)
  //               .startAfterDocument(docList.last)
  //               .limit(2)
  //               .get();
  //           print(snapshot.docs.isNotEmpty);
  //           if(snapshot.docs.isNotEmpty){
  //             print(4);
  //             userList.add(UserData.fromJson(snapshot.docs.last));
  //             searchUserList(selectedSpot, userName, userList,docList);
  //           }
  //         }
  //         print(5);
  //       }
  //     return userList;
  //   }
  //   catch(e){
  //     print(e);
  //     return [];
  //   }
  // }

  Future<List<User>> searchUserList(Spot selectedSpot, String userName) async {
    try{
      late QuerySnapshot snapshot;
      List<User> userList = [];
      if(selectedSpot.documentId.isEmpty){
        if(myInfo.value.position == '마스터'){
          snapshot = await userDB
              .orderBy('createDate', descending: true)
              .where('name', isGreaterThanOrEqualTo: userName)
              .where('name', isLessThanOrEqualTo: '$userName\uf8ff')
              .get();
        }
        else{
          snapshot = await userDB
              .orderBy('createDate', descending: true)
              .where('ticket.spotDocumentId', whereIn: myInfo.value.spotIdList + [''])
              .where('name', isGreaterThanOrEqualTo: userName)
              .where('name', isLessThanOrEqualTo: '$userName\uf8ff')
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
            .where('name', isGreaterThanOrEqualTo: userName)
            .where('name', isLessThanOrEqualTo: '$userName\uf8ff')
            .get();
      }

      for(var i in snapshot.docs){
        userList.add(User.fromJson(i.data() as Map<String, dynamic>));
      }
      return userList;
    }
    catch(e){
      print('searchUserList 걸림');
      print(e);
      return [];
    }
  }

  Future<void> getDummyUserData() async {
    try{
      // List<UserData> userDataList = [];
      final snapshot = await userDB.doc('SRRFoBom6AtLpaL9txTz').get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print(data['phone']);

      // var a = snapshot.docs.first.data();
      // a['phone'] = '01053410964';
      // a['name'] = '백영훈';
      // await FirebaseFirestore.instance.collection('user').doc().set(a);

    }
    catch(e){
      print('getDummyUserData 걸림');
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
}