import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> addUserData(UserData userData) async {
    try{
      await db.collection('user').doc().set(userData.toJson());
    }
    catch(e){
      print(e);
    }
  }

  Future<void> updateUserData(UserData userData) async {
    try{
      await db.collection('user').doc(userData.documentId).update({
        'phone': userData.phone,
      });
    }
    catch(e){
      print(e);
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