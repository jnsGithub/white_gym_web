import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spotItem.dart';

class SpotItemManagement{
  final db = FirebaseFirestore.instance;

  Future<List<SpotItem>> getSpotItemList() async {
    List<SpotItem> spotItemList = [];
    try {
      QuerySnapshot snapshot = await spotItemDB.orderBy('index', descending: false).get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['documentId'] = doc.id;
        spotItemList.add(SpotItem.fromMap(data));
      }
      return spotItemList;
    } catch (e) {
      print('SpotItem 가져올때 걸림 : ${e}');
      return [];
    }
  }

  Future<void> addSpotItem(SpotItem spotItem) async {
    try {
      await spotItemDB.add(spotItem.toMap());
    } catch (e) {
      print('SpotItem 추가할때 걸림 : ${e}');
    }
  }

  Future<void> updateSpotItem(SpotItem spotItem) async {
    try {
      await spotItemDB.doc(spotItem.documentId).update(spotItem.toMap());
    } catch (e) {
      print('SpotItem 업데이트할때 걸림 : ${e}');
    }
  }

  Future<void> updateSpotItemIndex(List<SpotItem> list) async {
    try {
      int index = 0;
      for (SpotItem spotItem in list) {
        await spotItemDB.doc(spotItem.documentId).update({'index': index});
        index++;
      }
    } catch (e) {
      print('SpotItem index 업데이트할때 걸림 : ${e}');
    }
  }
}