import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/data/models/staff.dart';
import 'package:white_gym_web/global/global.dart';

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
}