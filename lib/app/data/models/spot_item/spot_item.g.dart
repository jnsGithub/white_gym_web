// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotItem _$SpotItemFromJson(Map<String, dynamic> json) => _SpotItem(
      documentId: json['documentId'] as String,
      name: json['name'] as String,
      descriptions1: json['descriptions1'] as String,
      descriptions2: json['descriptions2'] as String,
      price: (json['price'] as num).toInt(),
      discountCheck:
          const RxBoolConverter().fromJson(json['discountCheck'] as bool),
      beforeDiscount: (json['beforeDiscount'] as num).toInt(),
      admission: (json['admission'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      isSubscribe:
          const RxBoolConverter().fromJson(json['isSubscribe'] as bool),
      pause: (json['pause'] as num?)?.toInt(),
      locker: (json['locker'] as num).toInt(),
      daily: (json['daily'] as num?)?.toInt(),
      passTicket: const RxBoolConverter().fromJson(json['passTicket'] as bool),
      sportswear: (json['sportswear'] as num).toInt(),
      spotDocumentId: json['spotDocumentId'] as String,
      createDate:
          const DateTimeConverter().fromJson(json['createDate'] as Timestamp),
    );

Map<String, dynamic> _$SpotItemToJson(_SpotItem instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'name': instance.name,
      'descriptions1': instance.descriptions1,
      'descriptions2': instance.descriptions2,
      'price': instance.price,
      'discountCheck': const RxBoolConverter().toJson(instance.discountCheck),
      'beforeDiscount': instance.beforeDiscount,
      'admission': instance.admission,
      'index': instance.index,
      'isSubscribe': const RxBoolConverter().toJson(instance.isSubscribe),
      'pause': instance.pause,
      'locker': instance.locker,
      'daily': instance.daily,
      'passTicket': const RxBoolConverter().toJson(instance.passTicket),
      'sportswear': instance.sportswear,
      'spotDocumentId': instance.spotDocumentId,
      'createDate': const DateTimeConverter().toJson(instance.createDate),
    };
