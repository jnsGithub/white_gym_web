import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  final String documentId;
  final String email;
  final String name;
  final List<String> spotIdList;
  final String position;
  final String hp;
  final DateTime createDate;
  bool isApproved;

  Staff({
    required this.documentId,
    required this.email,
    required this.name,
    required this.spotIdList,
    required this.position,
    required this.hp,
    required this.createDate,
    required this.isApproved,
  });

  factory Staff.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['documentId'] = doc.id;
    data['spotIdList'] = List<String>.from(data['spotIdList']);
    return Staff(
      documentId: data["documentId"],
      email: data["email"],
      name:data["name"],
      spotIdList:data["spotIdList"],
      position:data["position"],
      hp:data["hp"],
      createDate: (data["createDate"] as Timestamp).toDate(),
      isApproved: data["isApproved"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "documentId": documentId,
      "email": email,
      "name":name,
      "spotIdList":spotIdList,
      "position":position,
      "hp":hp,
      "creatDate": createDate,
      "isApproved": isApproved,
    };
  }
}

