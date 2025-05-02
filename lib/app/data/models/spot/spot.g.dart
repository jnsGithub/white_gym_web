// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Spot _$SpotFromJson(Map<String, dynamic> json) => _Spot(
      documentId: json['documentId'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      addressDetail: json['addressDetail'] as String,
      descriptions: json['descriptions'] as String,
      imageUrlList: const RxListConverter()
          .fromJson(json['imageUrlList'] as List<String>),
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      createDate:
          const DateTimeConverter().fromJson(json['createDate'] as Timestamp),
      devSnList:
          (json['devSnList'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SpotToJson(_Spot instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'name': instance.name,
      'address': instance.address,
      'addressDetail': instance.addressDetail,
      'descriptions': instance.descriptions,
      'imageUrlList': const RxListConverter().toJson(instance.imageUrlList),
      'lat': instance.lat,
      'lon': instance.lon,
      'createDate': const DateTimeConverter().toJson(instance.createDate),
      'devSnList': instance.devSnList,
    };
