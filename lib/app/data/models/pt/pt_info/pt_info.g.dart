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
      trainerName: json['trainerName'] as String,
      trainerDocumentId: json['trainerDocumentId'] as String,
      attendanceDate: const DateTimeConverter()
          .fromJson(json['attendanceDate'] as Timestamp),
      attendanceTimeList: (json['attendanceTimeList'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      trainingTime: (json['trainingTime'] as num).toInt(),
      trainingPart: (json['trainingPart'] as num).toInt(),
      comment: json['comment'] as String,
      status: (json['status'] as num).toInt(),
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
      'trainerName': instance.trainerName,
      'trainerDocumentId': instance.trainerDocumentId,
      'attendanceDate':
          const DateTimeConverter().toJson(instance.attendanceDate),
      'attendanceTimeList':
          instance.attendanceTimeList.map((e) => e.toIso8601String()).toList(),
      'trainingTime': instance.trainingTime,
      'trainingPart': instance.trainingPart,
      'comment': instance.comment,
      'status': instance.status,
      'createDate': const DateTimeConverter().toJson(instance.createDate),
    };
