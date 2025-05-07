// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotItem {
  String get documentId;
  String get name; // 멤버쉽 이름
  String get descriptions; // 설명1
  String get descriptions2; // 설명2
  int get price; // 가격
  @RxBoolConverter()
  RxBool get discountCheck; // 할인 여부
  int get beforeDiscount; // 할인 전 가격 (할인 여부가 False일 경우 0)
  int get admission; // 일일 입장횟수
  int get index; // 순서
  @RxBoolConverter()
  RxBool get isSubscribe; // 구독 여부
  int? get pause; // 일시정지 가능 횟수 (구독 여부가 True일 경우 0)
  int get locker; // 사물함 가격
  int? get monthly; // 개월 수
  int? get day; // 일일
  @RxBoolConverter()
  RxBool get passTicket; // 전지점 이용 가능 여부
  int get sportswear; // 운동복 가격
  String get spotDocumentId; // spotDocumentId
  @DateTimeConverter()
  DateTime get createDate;

  /// Create a copy of SpotItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SpotItemCopyWith<SpotItem> get copyWith =>
      _$SpotItemCopyWithImpl<SpotItem>(this as SpotItem, _$identity);

  /// Serializes this SpotItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SpotItem &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.descriptions, descriptions) ||
                other.descriptions == descriptions) &&
            (identical(other.descriptions2, descriptions2) ||
                other.descriptions2 == descriptions2) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.discountCheck, discountCheck) ||
                other.discountCheck == discountCheck) &&
            (identical(other.beforeDiscount, beforeDiscount) ||
                other.beforeDiscount == beforeDiscount) &&
            (identical(other.admission, admission) ||
                other.admission == admission) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.isSubscribe, isSubscribe) ||
                other.isSubscribe == isSubscribe) &&
            (identical(other.pause, pause) || other.pause == pause) &&
            (identical(other.locker, locker) || other.locker == locker) &&
            (identical(other.monthly, monthly) || other.monthly == monthly) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.passTicket, passTicket) ||
                other.passTicket == passTicket) &&
            (identical(other.sportswear, sportswear) ||
                other.sportswear == sportswear) &&
            (identical(other.spotDocumentId, spotDocumentId) ||
                other.spotDocumentId == spotDocumentId) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      name,
      descriptions,
      descriptions2,
      price,
      discountCheck,
      beforeDiscount,
      admission,
      index,
      isSubscribe,
      pause,
      locker,
      monthly,
      day,
      passTicket,
      sportswear,
      spotDocumentId,
      createDate);

  @override
  String toString() {
    return 'SpotItem(documentId: $documentId, name: $name, descriptions: $descriptions, descriptions2: $descriptions2, price: $price, discountCheck: $discountCheck, beforeDiscount: $beforeDiscount, admission: $admission, index: $index, isSubscribe: $isSubscribe, pause: $pause, locker: $locker, monthly: $monthly, day: $day, passTicket: $passTicket, sportswear: $sportswear, spotDocumentId: $spotDocumentId, createDate: $createDate)';
  }
}

/// @nodoc
abstract mixin class $SpotItemCopyWith<$Res> {
  factory $SpotItemCopyWith(SpotItem value, $Res Function(SpotItem) _then) =
      _$SpotItemCopyWithImpl;
  @useResult
  $Res call(
      {String documentId,
      String name,
      String descriptions,
      String descriptions2,
      int price,
      @RxBoolConverter() RxBool discountCheck,
      int beforeDiscount,
      int admission,
      int index,
      @RxBoolConverter() RxBool isSubscribe,
      int? pause,
      int locker,
      int? monthly,
      int? day,
      @RxBoolConverter() RxBool passTicket,
      int sportswear,
      String spotDocumentId,
      @DateTimeConverter() DateTime createDate});
}

/// @nodoc
class _$SpotItemCopyWithImpl<$Res> implements $SpotItemCopyWith<$Res> {
  _$SpotItemCopyWithImpl(this._self, this._then);

  final SpotItem _self;
  final $Res Function(SpotItem) _then;

  /// Create a copy of SpotItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentId = null,
    Object? name = null,
    Object? descriptions = null,
    Object? descriptions2 = null,
    Object? price = null,
    Object? discountCheck = null,
    Object? beforeDiscount = null,
    Object? admission = null,
    Object? index = null,
    Object? isSubscribe = null,
    Object? pause = freezed,
    Object? locker = null,
    Object? monthly = freezed,
    Object? day = freezed,
    Object? passTicket = null,
    Object? sportswear = null,
    Object? spotDocumentId = null,
    Object? createDate = null,
  }) {
    return _then(_self.copyWith(
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      descriptions: null == descriptions
          ? _self.descriptions
          : descriptions // ignore: cast_nullable_to_non_nullable
              as String,
      descriptions2: null == descriptions2
          ? _self.descriptions2
          : descriptions2 // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      discountCheck: null == discountCheck
          ? _self.discountCheck
          : discountCheck // ignore: cast_nullable_to_non_nullable
              as RxBool,
      beforeDiscount: null == beforeDiscount
          ? _self.beforeDiscount
          : beforeDiscount // ignore: cast_nullable_to_non_nullable
              as int,
      admission: null == admission
          ? _self.admission
          : admission // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      isSubscribe: null == isSubscribe
          ? _self.isSubscribe
          : isSubscribe // ignore: cast_nullable_to_non_nullable
              as RxBool,
      pause: freezed == pause
          ? _self.pause
          : pause // ignore: cast_nullable_to_non_nullable
              as int?,
      locker: null == locker
          ? _self.locker
          : locker // ignore: cast_nullable_to_non_nullable
              as int,
      monthly: freezed == monthly
          ? _self.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as int?,
      day: freezed == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as int?,
      passTicket: null == passTicket
          ? _self.passTicket
          : passTicket // ignore: cast_nullable_to_non_nullable
              as RxBool,
      sportswear: null == sportswear
          ? _self.sportswear
          : sportswear // ignore: cast_nullable_to_non_nullable
              as int,
      spotDocumentId: null == spotDocumentId
          ? _self.spotDocumentId
          : spotDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SpotItem implements SpotItem {
  const _SpotItem(
      {required this.documentId,
      required this.name,
      required this.descriptions,
      required this.descriptions2,
      required this.price,
      @RxBoolConverter() required this.discountCheck,
      required this.beforeDiscount,
      required this.admission,
      required this.index,
      @RxBoolConverter() required this.isSubscribe,
      required this.pause,
      required this.locker,
      required this.monthly,
      required this.day,
      @RxBoolConverter() required this.passTicket,
      required this.sportswear,
      required this.spotDocumentId,
      @DateTimeConverter() required this.createDate});
  factory _SpotItem.fromJson(Map<String, dynamic> json) =>
      _$SpotItemFromJson(json);

  @override
  final String documentId;
  @override
  final String name;
// 멤버쉽 이름
  @override
  final String descriptions;
// 설명1
  @override
  final String descriptions2;
// 설명2
  @override
  final int price;
// 가격
  @override
  @RxBoolConverter()
  final RxBool discountCheck;
// 할인 여부
  @override
  final int beforeDiscount;
// 할인 전 가격 (할인 여부가 False일 경우 0)
  @override
  final int admission;
// 일일 입장횟수
  @override
  final int index;
// 순서
  @override
  @RxBoolConverter()
  final RxBool isSubscribe;
// 구독 여부
  @override
  final int? pause;
// 일시정지 가능 횟수 (구독 여부가 True일 경우 0)
  @override
  final int locker;
// 사물함 가격
  @override
  final int? monthly;
// 개월 수
  @override
  final int? day;
// 일일
  @override
  @RxBoolConverter()
  final RxBool passTicket;
// 전지점 이용 가능 여부
  @override
  final int sportswear;
// 운동복 가격
  @override
  final String spotDocumentId;
// spotDocumentId
  @override
  @DateTimeConverter()
  final DateTime createDate;

  /// Create a copy of SpotItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SpotItemCopyWith<_SpotItem> get copyWith =>
      __$SpotItemCopyWithImpl<_SpotItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SpotItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SpotItem &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.descriptions, descriptions) ||
                other.descriptions == descriptions) &&
            (identical(other.descriptions2, descriptions2) ||
                other.descriptions2 == descriptions2) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.discountCheck, discountCheck) ||
                other.discountCheck == discountCheck) &&
            (identical(other.beforeDiscount, beforeDiscount) ||
                other.beforeDiscount == beforeDiscount) &&
            (identical(other.admission, admission) ||
                other.admission == admission) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.isSubscribe, isSubscribe) ||
                other.isSubscribe == isSubscribe) &&
            (identical(other.pause, pause) || other.pause == pause) &&
            (identical(other.locker, locker) || other.locker == locker) &&
            (identical(other.monthly, monthly) || other.monthly == monthly) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.passTicket, passTicket) ||
                other.passTicket == passTicket) &&
            (identical(other.sportswear, sportswear) ||
                other.sportswear == sportswear) &&
            (identical(other.spotDocumentId, spotDocumentId) ||
                other.spotDocumentId == spotDocumentId) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      name,
      descriptions,
      descriptions2,
      price,
      discountCheck,
      beforeDiscount,
      admission,
      index,
      isSubscribe,
      pause,
      locker,
      monthly,
      day,
      passTicket,
      sportswear,
      spotDocumentId,
      createDate);

  @override
  String toString() {
    return 'SpotItem(documentId: $documentId, name: $name, descriptions: $descriptions, descriptions2: $descriptions2, price: $price, discountCheck: $discountCheck, beforeDiscount: $beforeDiscount, admission: $admission, index: $index, isSubscribe: $isSubscribe, pause: $pause, locker: $locker, monthly: $monthly, day: $day, passTicket: $passTicket, sportswear: $sportswear, spotDocumentId: $spotDocumentId, createDate: $createDate)';
  }
}

/// @nodoc
abstract mixin class _$SpotItemCopyWith<$Res>
    implements $SpotItemCopyWith<$Res> {
  factory _$SpotItemCopyWith(_SpotItem value, $Res Function(_SpotItem) _then) =
      __$SpotItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String documentId,
      String name,
      String descriptions,
      String descriptions2,
      int price,
      @RxBoolConverter() RxBool discountCheck,
      int beforeDiscount,
      int admission,
      int index,
      @RxBoolConverter() RxBool isSubscribe,
      int? pause,
      int locker,
      int? monthly,
      int? day,
      @RxBoolConverter() RxBool passTicket,
      int sportswear,
      String spotDocumentId,
      @DateTimeConverter() DateTime createDate});
}

/// @nodoc
class __$SpotItemCopyWithImpl<$Res> implements _$SpotItemCopyWith<$Res> {
  __$SpotItemCopyWithImpl(this._self, this._then);

  final _SpotItem _self;
  final $Res Function(_SpotItem) _then;

  /// Create a copy of SpotItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? documentId = null,
    Object? name = null,
    Object? descriptions = null,
    Object? descriptions2 = null,
    Object? price = null,
    Object? discountCheck = null,
    Object? beforeDiscount = null,
    Object? admission = null,
    Object? index = null,
    Object? isSubscribe = null,
    Object? pause = freezed,
    Object? locker = null,
    Object? monthly = freezed,
    Object? day = freezed,
    Object? passTicket = null,
    Object? sportswear = null,
    Object? spotDocumentId = null,
    Object? createDate = null,
  }) {
    return _then(_SpotItem(
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      descriptions: null == descriptions
          ? _self.descriptions
          : descriptions // ignore: cast_nullable_to_non_nullable
              as String,
      descriptions2: null == descriptions2
          ? _self.descriptions2
          : descriptions2 // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      discountCheck: null == discountCheck
          ? _self.discountCheck
          : discountCheck // ignore: cast_nullable_to_non_nullable
              as RxBool,
      beforeDiscount: null == beforeDiscount
          ? _self.beforeDiscount
          : beforeDiscount // ignore: cast_nullable_to_non_nullable
              as int,
      admission: null == admission
          ? _self.admission
          : admission // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      isSubscribe: null == isSubscribe
          ? _self.isSubscribe
          : isSubscribe // ignore: cast_nullable_to_non_nullable
              as RxBool,
      pause: freezed == pause
          ? _self.pause
          : pause // ignore: cast_nullable_to_non_nullable
              as int?,
      locker: null == locker
          ? _self.locker
          : locker // ignore: cast_nullable_to_non_nullable
              as int,
      monthly: freezed == monthly
          ? _self.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as int?,
      day: freezed == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as int?,
      passTicket: null == passTicket
          ? _self.passTicket
          : passTicket // ignore: cast_nullable_to_non_nullable
              as RxBool,
      sportswear: null == sportswear
          ? _self.sportswear
          : sportswear // ignore: cast_nullable_to_non_nullable
              as int,
      spotDocumentId: null == spotDocumentId
          ? _self.spotDocumentId
          : spotDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
