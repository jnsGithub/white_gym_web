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

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      documentId: json["documentId"],
      email: json["email"],
      name:json["name"],
      spotIdList:json["spotIdList"],
      position:json["position"],
      hp:json["hp"],
      createDate: (json["createDate"] as Timestamp).toDate(),
      isApproved: json["isApproved"],
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

