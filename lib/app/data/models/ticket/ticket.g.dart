// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ticket _$TicketFromJson(Map<String, dynamic> json) => _Ticket(
      documentId: json['documentId'] as String,
      userDocumentId: json['userDocumentId'] as String,
      spotDocumentId: json['spotDocumentId'] as String,
      paymentBranch: json['paymentBranch'] as String,
      admission: (json['admission'] as num).toInt(),
      lockerNum: (json['lockerNum'] as num).toInt(),
      pause: (json['pause'] as num).toInt(),
      locker: json['locker'] as bool,
      sportswear: json['sportswear'] as bool,
      status: json['status'] as bool,
      subscribe: json['subscribe'] as bool,
      passTicket: json['passTicket'] as bool,
      pauseStartDate: (json['pauseStartDate'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      pauseEndDate: (json['pauseEndDate'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      endDate: DateTime.parse(json['endDate'] as String),
      createDate: DateTime.parse(json['createDate'] as String),
      spotItem: SpotItem.fromJson(json['spotItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketToJson(_Ticket instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'userDocumentId': instance.userDocumentId,
      'spotDocumentId': instance.spotDocumentId,
      'paymentBranch': instance.paymentBranch,
      'admission': instance.admission,
      'lockerNum': instance.lockerNum,
      'pause': instance.pause,
      'locker': instance.locker,
      'sportswear': instance.sportswear,
      'status': instance.status,
      'subscribe': instance.subscribe,
      'passTicket': instance.passTicket,
      'pauseStartDate':
          instance.pauseStartDate.map((e) => e.toIso8601String()).toList(),
      'pauseEndDate':
          instance.pauseEndDate.map((e) => e.toIso8601String()).toList(),
      'endDate': instance.endDate.toIso8601String(),
      'createDate': instance.createDate.toIso8601String(),
      'spotItem': instance.spotItem,
    };
