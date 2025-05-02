import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:white_gym_web/app/data/util/converter.dart';

part 'spot.freezed.dart';
part 'spot.g.dart';

@freezed
abstract class Spot with _$Spot {
  const factory Spot({
    required final String documentId,
    required String name,
    required String address,
    required String addressDetail,
    required String descriptions,
    @RxListConverter()
    required RxList<String> imageUrlList,
    required double lat,
    required double lon,
    @DateTimeConverter()
    required final DateTime createDate,
    required List<String> devSnList,
  }) = _Spot;

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);
}

class RxListConverter implements JsonConverter<RxList<String>, List<String>> {
  const RxListConverter();

  @override
  RxList<String> fromJson(List<String> json) => RxList<String>(json);

  @override
  List<String> toJson(RxList<String> object) => object;
}