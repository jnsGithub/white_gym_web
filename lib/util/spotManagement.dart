import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SpotManagement{
  final db = FirebaseFirestore.instance;

  Future<List<Spot>> getSpotList() async {
    List<Spot> spotList = [];
    try {
      QuerySnapshot snapshot = await db.collection('spot').get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['documentId'] = doc.id;
        data['devSnList'] = List<String>.from(data['devSnList'] ?? []);
        spotList.add(Spot.fromMap(data));
      }
      return spotList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> addSpot(Spot spot) async {
    try {
      await db.collection('spot').add(spot.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateSpot(Spot spot, List<Uint8List?> imageUrlList, bool isSet) async {
    try {
      await db.collection('spot').doc(spot.documentId).update({
        'name': spot.name,
        'address': spot.address,
        'addressDetail': spot.addressDetail,
        'descriptions': spot.descriptions,
        'lat': spot.lat,
        'lon': spot.lon,
        'imageUrlList': isSet ? await uploadImage(imageUrlList) : FieldValue.arrayUnion(await uploadImage(imageUrlList)),
        'devSnList': spot.devSnList,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> uploadImage(List<Uint8List?> imageUrlList) async {
    List<String> uploadedImageUrlList = [];
    try {
      for (Uint8List? image in imageUrlList) {
        if (image != null) {
          final ref = FirebaseStorage.instance.ref().child('spot').child(DateTime.now().toString());
          await ref.putData(image);
          String imageUrl = await ref.getDownloadURL();
          uploadedImageUrlList.add(imageUrl);
        }
      }
      return uploadedImageUrlList;
    } catch (e) {
      print(e);
      return [];
    }
  }
}