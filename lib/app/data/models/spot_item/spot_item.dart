import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:white_gym_web/app/data/util/converter.dart';

part 'spot_item.freezed.dart';
part 'spot_item.g.dart';

@freezed
abstract class SpotItem with _$SpotItem {
  const factory SpotItem({
    required final String documentId,
    required String name,               // 멤버쉽 이름
    required String descriptions,       // 설명1
    required String descriptions2,      // 설명2
    required int price,                 // 가격
    @RxBoolConverter()
    required RxBool discountCheck,      // 할인 여부
    required int beforeDiscount,        // 할인 전 가격 (할인 여부가 False일 경우 0)
    required int admission,             // 일일 입장횟수
    required int index,                 // 순서
    @RxBoolConverter()
    required RxBool isSubscribe,        // 구독 여부
    required int? pause,                // 일시정지 가능 횟수 (구독 여부가 True일 경우 0)
    required int locker,                // 사물함 가격
    required int? monthly,              // 개월 수
    required int? day,                  // 일일
    @RxBoolConverter()
    required RxBool passTicket,         // 전지점 이용 가능 여부
    required int sportswear,            // 운동복 가격
    required String spotDocumentId,     // spotDocumentId
    @DateTimeConverter()
    required final DateTime createDate, // 생성일
  }) = _SpotItem;

  factory SpotItem.fromJson(Map<String, dynamic> json) => _$SpotItemFromJson(json);
}

class RxBoolConverter implements JsonConverter<RxBool, bool> {
  const RxBoolConverter();

  @override
  RxBool fromJson(bool json) => RxBool(json);

  @override
  bool toJson(RxBool object) => object.value;
}
