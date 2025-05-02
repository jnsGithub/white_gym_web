// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Staff _$StaffFromJson(Map<String, dynamic> json) => _Staff(
      documentId: json['documentId'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      spotIdList: (json['spotIdList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      position: json['position'] as String,
      hp: json['hp'] as String,
      createDate:
          const DateTimeConverter().fromJson(json['createDate'] as Timestamp),
      isApproved: json['isApproved'] as bool,
    );

Map<String, dynamic> _$StaffToJson(_Staff instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'email': instance.email,
      'name': instance.name,
      'spotIdList': instance.spotIdList,
      'position': instance.position,
      'hp': instance.hp,
      'createDate': const DateTimeConverter().toJson(instance.createDate),
      'isApproved': instance.isApproved,
    };
