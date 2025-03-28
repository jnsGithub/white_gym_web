import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/staff.dart';

class Sign{
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<void> test() async {
    var snapShot = db.collection('user').doc('cTuOZ9gXCXd6dGVs4M3Z').get();

    var data = snapShot.then((value) => print(value.data()));
  }

  Future<bool> signUp(String email, String password, String name, String position, List<String> spotIdList, String hp) async {
    try {

      UserCredential user =  await auth.createUserWithEmailAndPassword(email: email, password: password);
      await staffDB.doc(user.user!.uid).set({
        'email': email,
        'name': name,
        'position': position,
        'spotIdList': spotIdList,
        'isApproved': false,
        'createDate': DateTime.now(),
        'hp': hp,
      });
      return true;
    } catch (e) {
      print(e);
      final emailSnapshot = await staffDB.where('email', isEqualTo: email).get();
      if (emailSnapshot.docs.isEmpty && e.toString().contains('email-already-in-use')) {
        UserCredential user =  await auth.signInWithEmailAndPassword(email: email, password: password);
        await staffDB.doc(user.user!.uid).set({
          'email': email,
          'name': name,
          'position': position,
          'spotIdList': spotIdList,
          'isApproved': false,
          'createDate': DateTime.now(),
          'hp': hp,
        });
        auth.signOut();
        return true;
      }
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final emailSnapshot = await staffDB.where('email', isEqualTo: email).get();
      if (emailSnapshot.docs.isEmpty) {
        return false;
      }
      UserCredential user =  await auth.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot snapshot = await staffDB.doc(user.user!.uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      myInfo.value = Staff.fromJson(snapshot);
      print(myInfo.toString());
      if (data['isApproved'] == false) {
        Get.snackbar('로그인 에러', '승인 대기중인 계정입니다.');
        return false;
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> findPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<void> resetSex() async {
  //   print('resetSex');
  //   try{
  //    var snapshot = await db.collection('user').where('createDate', isLessThan: DateTime(2025,03,07,23,59)).where('createDate', isGreaterThan: DateTime(2025,03,06,15,53)).orderBy('createDate', descending: true).get();
  //     print(snapshot.docs[0].data()['name']);
  //     print(snapshot.docs[snapshot.docs.length-1].data()['name']);
  //
  //     int i = 0;
  //     print(snapshot.docs.length);
  //     for(var doc in snapshot.docs){
  //       if(doc.data()['gender'] == 0){
  //         await db.collection('user').doc(doc.id).update({
  //           'gender': 1
  //         });
  //       }
  //       else{
  //         await db.collection('user').doc(doc.id).update({
  //           'gender': 0
  //         });
  //       }
  //       print('${snapshot.docs.length}개중 ${i}번째 완료');
  //     }
  //     print('resetSex done');
  //   } catch(e){
  //     print('resetSex error : ${e}');
  //   }
  // }
}