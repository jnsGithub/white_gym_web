import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/staff.dart';

class Sign{
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<bool> signUp(String email, String password, String name, String position, List<String> spotIdList, String hp) async {
    try {
      UserCredential user =  await auth.createUserWithEmailAndPassword(email: email, password: password);
      await db.collection('staff').doc(user.user!.uid).set({
        'email': email,
        'name': name,
        'position': position,
        'spotIdList': spotIdList,
        'isApproved': false,
        'hp': hp,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential user =  await auth.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot snapshot = await db.collection('staff').doc(user.user!.uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print(1);
      data['documentId'] = snapshot.id;
      data['spotIdList'] = List<String>.from(data['spotIdList']);
      myInfo.value = Staff.fromJson(data);
      print(2);
      if (data['isApproved'] == false) {
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

  Future<void> findPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }
}