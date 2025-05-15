// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      documentId: json['documentId'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      birth: json['birth'] as String,
      storeDocumentId: json['storeDocumentId'] as String?,
      paymentCard: json['paymentCard'] as String?,
      fcmToken: json['fcmToken'] as String?,
      gender: (json['gender'] as num).toInt(),
      pushAlarm: json['pushAlarm'] as bool,
      smsAlarm: json['smsAlarm'] as bool,
      ticket: Ticket.fromJson(json['ticket'] as Map<String, dynamic>),
      createDate: const TimestampConverter().fromJson(json['createDate']),
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'name': instance.name,
      'phone': instance.phone,
      'birth': instance.birth,
      'storeDocumentId': instance.storeDocumentId,
      'paymentCard': instance.paymentCard,
      'fcmToken': instance.fcmToken,
      'gender': instance.gender,
      'pushAlarm': instance.pushAlarm,
      'smsAlarm': instance.smsAlarm,
      'ticket': instance.ticket,
      'createDate': const TimestampConverter().toJson(instance.createDate),
    };
