// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {
  String get documentId;
  String get name;
  String get phone;
  String get birth;
  String get storeDocumentId;
  String get paymentCard;
  String get fcmToken;
  int get gender;
  bool get pushAlarm;
  bool get smsAlarm;
  Ticket get ticket;
  @TimestampConverter()
  Timestamp get createDate;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserCopyWith<User> get copyWith =>
      _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is User &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.birth, birth) || other.birth == birth) &&
            (identical(other.storeDocumentId, storeDocumentId) ||
                other.storeDocumentId == storeDocumentId) &&
            (identical(other.paymentCard, paymentCard) ||
                other.paymentCard == paymentCard) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.pushAlarm, pushAlarm) ||
                other.pushAlarm == pushAlarm) &&
            (identical(other.smsAlarm, smsAlarm) ||
                other.smsAlarm == smsAlarm) &&
            (identical(other.ticket, ticket) || other.ticket == ticket) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      name,
      phone,
      birth,
      storeDocumentId,
      paymentCard,
      fcmToken,
      gender,
      pushAlarm,
      smsAlarm,
      ticket,
      createDate);

  @override
  String toString() {
    return 'User(documentId: $documentId, name: $name, phone: $phone, birth: $birth, storeDocumentId: $storeDocumentId, paymentCard: $paymentCard, fcmToken: $fcmToken, gender: $gender, pushAlarm: $pushAlarm, smsAlarm: $smsAlarm, ticket: $ticket, createDate: $createDate)';
  }
}

/// @nodoc
abstract mixin class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) _then) =
      _$UserCopyWithImpl;
  @useResult
  $Res call(
      {String documentId,
      String name,
      String phone,
      String birth,
      String storeDocumentId,
      String paymentCard,
      String fcmToken,
      int gender,
      bool pushAlarm,
      bool smsAlarm,
      Ticket ticket,
      @TimestampConverter() Timestamp createDate});

  $TicketCopyWith<$Res> get ticket;
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentId = null,
    Object? name = null,
    Object? phone = null,
    Object? birth = null,
    Object? storeDocumentId = null,
    Object? paymentCard = null,
    Object? fcmToken = null,
    Object? gender = null,
    Object? pushAlarm = null,
    Object? smsAlarm = null,
    Object? ticket = null,
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
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      birth: null == birth
          ? _self.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as String,
      storeDocumentId: null == storeDocumentId
          ? _self.storeDocumentId
          : storeDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentCard: null == paymentCard
          ? _self.paymentCard
          : paymentCard // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: null == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int,
      pushAlarm: null == pushAlarm
          ? _self.pushAlarm
          : pushAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      smsAlarm: null == smsAlarm
          ? _self.smsAlarm
          : smsAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      ticket: null == ticket
          ? _self.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as Ticket,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketCopyWith<$Res> get ticket {
    return $TicketCopyWith<$Res>(_self.ticket, (value) {
      return _then(_self.copyWith(ticket: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _User implements User {
  const _User(
      {required this.documentId,
      required this.name,
      required this.phone,
      required this.birth,
      required this.storeDocumentId,
      required this.paymentCard,
      required this.fcmToken,
      required this.gender,
      required this.pushAlarm,
      required this.smsAlarm,
      required this.ticket,
      @TimestampConverter() required this.createDate});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  final String documentId;
  @override
  final String name;
  @override
  final String phone;
  @override
  final String birth;
  @override
  final String storeDocumentId;
  @override
  final String paymentCard;
  @override
  final String fcmToken;
  @override
  final int gender;
  @override
  final bool pushAlarm;
  @override
  final bool smsAlarm;
  @override
  final Ticket ticket;
  @override
  @TimestampConverter()
  final Timestamp createDate;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.birth, birth) || other.birth == birth) &&
            (identical(other.storeDocumentId, storeDocumentId) ||
                other.storeDocumentId == storeDocumentId) &&
            (identical(other.paymentCard, paymentCard) ||
                other.paymentCard == paymentCard) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.pushAlarm, pushAlarm) ||
                other.pushAlarm == pushAlarm) &&
            (identical(other.smsAlarm, smsAlarm) ||
                other.smsAlarm == smsAlarm) &&
            (identical(other.ticket, ticket) || other.ticket == ticket) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      name,
      phone,
      birth,
      storeDocumentId,
      paymentCard,
      fcmToken,
      gender,
      pushAlarm,
      smsAlarm,
      ticket,
      createDate);

  @override
  String toString() {
    return 'User(documentId: $documentId, name: $name, phone: $phone, birth: $birth, storeDocumentId: $storeDocumentId, paymentCard: $paymentCard, fcmToken: $fcmToken, gender: $gender, pushAlarm: $pushAlarm, smsAlarm: $smsAlarm, ticket: $ticket, createDate: $createDate)';
  }
}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) =
      __$UserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String documentId,
      String name,
      String phone,
      String birth,
      String storeDocumentId,
      String paymentCard,
      String fcmToken,
      int gender,
      bool pushAlarm,
      bool smsAlarm,
      Ticket ticket,
      @TimestampConverter() Timestamp createDate});

  @override
  $TicketCopyWith<$Res> get ticket;
}

/// @nodoc
class __$UserCopyWithImpl<$Res> implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? documentId = null,
    Object? name = null,
    Object? phone = null,
    Object? birth = null,
    Object? storeDocumentId = null,
    Object? paymentCard = null,
    Object? fcmToken = null,
    Object? gender = null,
    Object? pushAlarm = null,
    Object? smsAlarm = null,
    Object? ticket = null,
    Object? createDate = null,
  }) {
    return _then(_User(
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      birth: null == birth
          ? _self.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as String,
      storeDocumentId: null == storeDocumentId
          ? _self.storeDocumentId
          : storeDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentCard: null == paymentCard
          ? _self.paymentCard
          : paymentCard // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: null == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int,
      pushAlarm: null == pushAlarm
          ? _self.pushAlarm
          : pushAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      smsAlarm: null == smsAlarm
          ? _self.smsAlarm
          : smsAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      ticket: null == ticket
          ? _self.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as Ticket,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketCopyWith<$Res> get ticket {
    return $TicketCopyWith<$Res>(_self.ticket, (value) {
      return _then(_self.copyWith(ticket: value));
    });
  }
}

// dart format on
