import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_gym_web/models/staff.dart';

class StaffManagement{
  final db = FirebaseFirestore.instance;

  // 직원 데이터 get
  Future<List<Staff>> getStaffList() async {
    try{
      final snapshot = await db.collection('staff').orderBy('createDate', descending: true).get();
      return snapshot.docs.map((doc) => Staff.fromJson(doc)).toList();
    }
    catch(e){
      print(e);
      return [];
    }
  }

  Future<void> approveStaff(String documentId) async {
    try {
      await db.collection('staff').doc(documentId).update({
        'isApproved': true,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteStaff(String documentId) async {
    try {
      await db.collection('staff').doc(documentId).delete();
    } catch (e) {
      print(e);
    }
  }
}