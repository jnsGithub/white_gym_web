import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_gym_web/app/data/models/temp/ticket.dart';

class UserData {
  final String documentId;
  String name;
  String phone;
  final String birth;
  String storeDocumentId;
  String paymentCard;
  String fcmToken;
  int gender;
  final bool pushAlarm;
  bool smsAlarm;
  Ticket ticket;
  final Timestamp createDate;


  UserData({
    required this.documentId,
    required this.name,
    required this.phone,
    required this.birth,
    required this.ticket,
    required this.storeDocumentId,
    required this.paymentCard,
    required this.fcmToken,
    required this.gender,
    required this.pushAlarm,
    required this.smsAlarm,
    required this.createDate,
  });

  /// JSON(맵)으로부터 객체를 생성
  factory UserData.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserData(
      documentId: doc.id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      birth: data['birth'] ?? '',
      storeDocumentId: data['storeDocumentId'] ?? '',
      paymentCard: data['paymentCard'] ?? '',
      fcmToken: data['fcmToken'] ?? '',
      gender: data['gender'] ?? 0,
      pushAlarm: data['pushAlarm'] ?? false,
      smsAlarm: data['smsAlarm'] ?? false,
      ticket: Ticket.fromJson(data['ticket']),
      createDate: data['createDate'] ?? Timestamp.now(),
    );
  }

  /// 객체를 JSON(맵)으로 변환
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'birth': birth,
      'ticket': ticket.toJson(),
      'storeDocumentId': storeDocumentId,
      'paymentCard': paymentCard,
      'fcmToken': fcmToken,
      'gender': gender,
      'pushAlarm': pushAlarm,
      'smsAlarm': smsAlarm,
      'createDate': createDate,
    };
  }

  factory UserData.empty() {
    return UserData(
      documentId: '',
      name: '',
      phone: '',
      birth: '',
      ticket: Ticket.empty(),
      storeDocumentId: '',
      paymentCard: '',
      fcmToken: '',
      gender: 0,
      pushAlarm: true,
      smsAlarm: true,
      createDate: Timestamp.now(),
    );
  }

  /// 수정 가능한 copyWith 메서드 (옵션)
  UserData copyWith({
    String? documentId,
    String? name,
    String? phone,
    String? birth,
    Ticket? ticket,
    String? storeDocumentId,
    String? paymentCard,
    String? fcmToken,
    int? gender,
    bool? pushAlarm,
    bool? smsAlarm,
    Timestamp? createDate,
  }) {
    return UserData(
      documentId: documentId ?? this.documentId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      birth: birth ?? this.birth,
      ticket: ticket ?? this.ticket.copyWith(),
      storeDocumentId: storeDocumentId ?? this.storeDocumentId,
      paymentCard: paymentCard ?? this.paymentCard,
      fcmToken: fcmToken ?? this.fcmToken,
      gender: gender ?? this.gender,
      pushAlarm: pushAlarm ?? this.pushAlarm,
      smsAlarm: smsAlarm ?? this.smsAlarm,
      createDate: createDate ?? this.createDate,
    );
  }

  @override
  String toString() {
    return 'UserInfo(documentId: $documentId, name: $name, phone: $phone, birth: $birth, ticket: $ticket,paymentCard:$paymentCard, gender: $gender, pushAlarm: $pushAlarm, smsAlarm: $smsAlarm, createDate: $createDate)';
  }
}
