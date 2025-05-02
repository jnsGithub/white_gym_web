// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pt_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PtInfo _$PtInfoFromJson(Map<String, dynamic> json) => _PtInfo(
      documentId: json['documentId'] as String,
      userDocumentId: json['userDocumentId'] as String,
      spotDocumentId: json['spotDocumentId'] as String,
      spotName: json['spotName'] as String,
      userName: json['userName'] as String,
      userPhone: json['userPhone'] as String,
      ptCount: (json['ptCount'] as num).toInt(),
      createDate:
          const DateTimeConverter().fromJson(json['createDate'] as Timestamp),
    );

Map<String, dynamic> _$PtInfoToJson(_PtInfo instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'userDocumentId': instance.userDocumentId,
      'spotDocumentId': instance.spotDocumentId,
      'spotName': instance.spotName,
      'userName': instance.userName,
      'userPhone': instance.userPhone,
      'ptCount': instance.ptCount,
      'createDate': const DateTimeConverter().toJson(instance.createDate),
    };
