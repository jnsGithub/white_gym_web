import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_gym_web/models/spotItem.dart';

class SpotItemManagement{
  final db = FirebaseFirestore.instance;

  Future<List<SpotItem>> getSpotItemList() async {
    List<SpotItem> spotItemList = [];
    try {
      QuerySnapshot snapshot = await db.collection('spotItem').orderBy('index', descending: false).get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['documentId'] = doc.id;
        spotItemList.add(SpotItem.fromMap(data));
      }
      print(spotItemList);
      return spotItemList;
    } catch (e) {
      print('SpotItem 가져올때 걸림 : ${e}');
      return [];
    }
  }

  Future<void> addSpotItem(SpotItem spotItem) async {
    try {
      await db.collection('spotItem').add(spotItem.toMap());
    } catch (e) {
      print('SpotItem 추가할때 걸림 : ${e}');
    }
  }

  Future<void> updateSpotItem(SpotItem spotItem) async {
    try {
      await db.collection('spotItem').doc(spotItem.documentId).update(spotItem.toMap());
    } catch (e) {
      print('SpotItem 업데이트할때 걸림 : ${e}');
    }
  }

  Future<void> updateIndex(List<SpotItem> list) async {
    try {
      int index = 0;
      for (SpotItem spotItem in list) {
        await db.collection('spotItem').doc(spotItem.documentId).update({'index': index});
        index++;
      }
    } catch (e) {
      print('SpotItem index 업데이트할때 걸림 : ${e}');
    }
  }
}