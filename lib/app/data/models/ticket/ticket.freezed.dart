// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ticket {
  String get documentId;
  String get userDocumentId;
  String get spotDocumentId;
  String get paymentBranch;
  int get admission;
  int get lockerNum;
  int get pause;
  bool get locker;
  bool get sportswear;
  bool get status;
  bool get subscribe;
  bool get passTicket;
  @DateListConverter()
  List<DateTime> get pauseStartDate;
  @DateListConverter()
  List<DateTime> get pauseEndDate;
  DateTime get endDate;
  DateTime get createDate;
  SpotItem get spotItem;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TicketCopyWith<Ticket> get copyWith =>
      _$TicketCopyWithImpl<Ticket>(this as Ticket, _$identity);

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Ticket &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.userDocumentId, userDocumentId) ||
                other.userDocumentId == userDocumentId) &&
            (identical(other.spotDocumentId, spotDocumentId) ||
                other.spotDocumentId == spotDocumentId) &&
            (identical(other.paymentBranch, paymentBranch) ||
                other.paymentBranch == paymentBranch) &&
            (identical(other.admission, admission) ||
                other.admission == admission) &&
            (identical(other.lockerNum, lockerNum) ||
                other.lockerNum == lockerNum) &&
            (identical(other.pause, pause) || other.pause == pause) &&
            (identical(other.locker, locker) || other.locker == locker) &&
            (identical(other.sportswear, sportswear) ||
                other.sportswear == sportswear) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.subscribe, subscribe) ||
                other.subscribe == subscribe) &&
            (identical(other.passTicket, passTicket) ||
                other.passTicket == passTicket) &&
            const DeepCollectionEquality()
                .equals(other.pauseStartDate, pauseStartDate) &&
            const DeepCollectionEquality()
                .equals(other.pauseEndDate, pauseEndDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.spotItem, spotItem) ||
                other.spotItem == spotItem));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      userDocumentId,
      spotDocumentId,
      paymentBranch,
      admission,
      lockerNum,
      pause,
      locker,
      sportswear,
      status,
      subscribe,
      passTicket,
      const DeepCollectionEquality().hash(pauseStartDate),
      const DeepCollectionEquality().hash(pauseEndDate),
      endDate,
      createDate,
      spotItem);

  @override
  String toString() {
    return 'Ticket(documentId: $documentId, userDocumentId: $userDocumentId, spotDocumentId: $spotDocumentId, paymentBranch: $paymentBranch, admission: $admission, lockerNum: $lockerNum, pause: $pause, locker: $locker, sportswear: $sportswear, status: $status, subscribe: $subscribe, passTicket: $passTicket, pauseStartDate: $pauseStartDate, pauseEndDate: $pauseEndDate, endDate: $endDate, createDate: $createDate, spotItem: $spotItem)';
  }
}

/// @nodoc
abstract mixin class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) _then) =
      _$TicketCopyWithImpl;
  @useResult
  $Res call(
      {String documentId,
      String userDocumentId,
      String spotDocumentId,
      String paymentBranch,
      int admission,
      int lockerNum,
      int pause,
      bool locker,
      bool sportswear,
      bool status,
      bool subscribe,
      bool passTicket,
      @DateListConverter() List<DateTime> pauseStartDate,
      @DateListConverter() List<DateTime> pauseEndDate,
      DateTime endDate,
      DateTime createDate,
      SpotItem spotItem});

  $SpotItemCopyWith<$Res> get spotItem;
}

/// @nodoc
class _$TicketCopyWithImpl<$Res> implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._self, this._then);

  final Ticket _self;
  final $Res Function(Ticket) _then;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentId = null,
    Object? userDocumentId = null,
    Object? spotDocumentId = null,
    Object? paymentBranch = null,
    Object? admission = null,
    Object? lockerNum = null,
    Object? pause = null,
    Object? locker = null,
    Object? sportswear = null,
    Object? status = null,
    Object? subscribe = null,
    Object? passTicket = null,
    Object? pauseStartDate = null,
    Object? pauseEndDate = null,
    Object? endDate = null,
    Object? createDate = null,
    Object? spotItem = null,
  }) {
    return _then(_self.copyWith(
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      userDocumentId: null == userDocumentId
          ? _self.userDocumentId
          : userDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      spotDocumentId: null == spotDocumentId
          ? _self.spotDocumentId
          : spotDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentBranch: null == paymentBranch
          ? _self.paymentBranch
          : paymentBranch // ignore: cast_nullable_to_non_nullable
              as String,
      admission: null == admission
          ? _self.admission
          : admission // ignore: cast_nullable_to_non_nullable
              as int,
      lockerNum: null == lockerNum
          ? _self.lockerNum
          : lockerNum // ignore: cast_nullable_to_non_nullable
              as int,
      pause: null == pause
          ? _self.pause
          : pause // ignore: cast_nullable_to_non_nullable
              as int,
      locker: null == locker
          ? _self.locker
          : locker // ignore: cast_nullable_to_non_nullable
              as bool,
      sportswear: null == sportswear
          ? _self.sportswear
          : sportswear // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      subscribe: null == subscribe
          ? _self.subscribe
          : subscribe // ignore: cast_nullable_to_non_nullable
              as bool,
      passTicket: null == passTicket
          ? _self.passTicket
          : passTicket // ignore: cast_nullable_to_non_nullable
              as bool,
      pauseStartDate: null == pauseStartDate
          ? _self.pauseStartDate
          : pauseStartDate // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      pauseEndDate: null == pauseEndDate
          ? _self.pauseEndDate
          : pauseEndDate // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      spotItem: null == spotItem
          ? _self.spotItem
          : spotItem // ignore: cast_nullable_to_non_nullable
              as SpotItem,
    ));
  }

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpotItemCopyWith<$Res> get spotItem {
    return $SpotItemCopyWith<$Res>(_self.spotItem, (value) {
      return _then(_self.copyWith(spotItem: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Ticket implements Ticket {
  const _Ticket(
      {required this.documentId,
      required this.userDocumentId,
      required this.spotDocumentId,
      required this.paymentBranch,
      required this.admission,
      required this.lockerNum,
      required this.pause,
      required this.locker,
      required this.sportswear,
      required this.status,
      required this.subscribe,
      required this.passTicket,
      @DateListConverter() required final List<DateTime> pauseStartDate,
      @DateListConverter() required final List<DateTime> pauseEndDate,
      required this.endDate,
      required this.createDate,
      required this.spotItem})
      : _pauseStartDate = pauseStartDate,
        _pauseEndDate = pauseEndDate;
  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  @override
  final String documentId;
  @override
  final String userDocumentId;
  @override
  final String spotDocumentId;
  @override
  final String paymentBranch;
  @override
  final int admission;
  @override
  final int lockerNum;
  @override
  final int pause;
  @override
  final bool locker;
  @override
  final bool sportswear;
  @override
  final bool status;
  @override
  final bool subscribe;
  @override
  final bool passTicket;
  final List<DateTime> _pauseStartDate;
  @override
  @DateListConverter()
  List<DateTime> get pauseStartDate {
    if (_pauseStartDate is EqualUnmodifiableListView) return _pauseStartDate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pauseStartDate);
  }

  final List<DateTime> _pauseEndDate;
  @override
  @DateListConverter()
  List<DateTime> get pauseEndDate {
    if (_pauseEndDate is EqualUnmodifiableListView) return _pauseEndDate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pauseEndDate);
  }

  @override
  final DateTime endDate;
  @override
  final DateTime createDate;
  @override
  final SpotItem spotItem;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TicketCopyWith<_Ticket> get copyWith =>
      __$TicketCopyWithImpl<_Ticket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TicketToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Ticket &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.userDocumentId, userDocumentId) ||
                other.userDocumentId == userDocumentId) &&
            (identical(other.spotDocumentId, spotDocumentId) ||
                other.spotDocumentId == spotDocumentId) &&
            (identical(other.paymentBranch, paymentBranch) ||
                other.paymentBranch == paymentBranch) &&
            (identical(other.admission, admission) ||
                other.admission == admission) &&
            (identical(other.lockerNum, lockerNum) ||
                other.lockerNum == lockerNum) &&
            (identical(other.pause, pause) || other.pause == pause) &&
            (identical(other.locker, locker) || other.locker == locker) &&
            (identical(other.sportswear, sportswear) ||
                other.sportswear == sportswear) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.subscribe, subscribe) ||
                other.subscribe == subscribe) &&
            (identical(other.passTicket, passTicket) ||
                other.passTicket == passTicket) &&
            const DeepCollectionEquality()
                .equals(other._pauseStartDate, _pauseStartDate) &&
            const DeepCollectionEquality()
                .equals(other._pauseEndDate, _pauseEndDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.spotItem, spotItem) ||
                other.spotItem == spotItem));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      userDocumentId,
      spotDocumentId,
      paymentBranch,
      admission,
      lockerNum,
      pause,
      locker,
      sportswear,
      status,
      subscribe,
      passTicket,
      const DeepCollectionEquality().hash(_pauseStartDate),
      const DeepCollectionEquality().hash(_pauseEndDate),
      endDate,
      createDate,
      spotItem);

  @override
  String toString() {
    return 'Ticket(documentId: $documentId, userDocumentId: $userDocumentId, spotDocumentId: $spotDocumentId, paymentBranch: $paymentBranch, admission: $admission, lockerNum: $lockerNum, pause: $pause, locker: $locker, sportswear: $sportswear, status: $status, subscribe: $subscribe, passTicket: $passTicket, pauseStartDate: $pauseStartDate, pauseEndDate: $pauseEndDate, endDate: $endDate, createDate: $createDate, spotItem: $spotItem)';
  }
}

/// @nodoc
abstract mixin class _$TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$TicketCopyWith(_Ticket value, $Res Function(_Ticket) _then) =
      __$TicketCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String documentId,
      String userDocumentId,
      String spotDocumentId,
      String paymentBranch,
      int admission,
      int lockerNum,
      int pause,
      bool locker,
      bool sportswear,
      bool status,
      bool subscribe,
      bool passTicket,
      @DateListConverter() List<DateTime> pauseStartDate,
      @DateListConverter() List<DateTime> pauseEndDate,
      DateTime endDate,
      DateTime createDate,
      SpotItem spotItem});

  @override
  $SpotItemCopyWith<$Res> get spotItem;
}

/// @nodoc
class __$TicketCopyWithImpl<$Res> implements _$TicketCopyWith<$Res> {
  __$TicketCopyWithImpl(this._self, this._then);

  final _Ticket _self;
  final $Res Function(_Ticket) _then;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? documentId = null,
    Object? userDocumentId = null,
    Object? spotDocumentId = null,
    Object? paymentBranch = null,
    Object? admission = null,
    Object? lockerNum = null,
    Object? pause = null,
    Object? locker = null,
    Object? sportswear = null,
    Object? status = null,
    Object? subscribe = null,
    Object? passTicket = null,
    Object? pauseStartDate = null,
    Object? pauseEndDate = null,
    Object? endDate = null,
    Object? createDate = null,
    Object? spotItem = null,
  }) {
    return _then(_Ticket(
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      userDocumentId: null == userDocumentId
          ? _self.userDocumentId
          : userDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      spotDocumentId: null == spotDocumentId
          ? _self.spotDocumentId
          : spotDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentBranch: null == paymentBranch
          ? _self.paymentBranch
          : paymentBranch // ignore: cast_nullable_to_non_nullable
              as String,
      admission: null == admission
          ? _self.admission
          : admission // ignore: cast_nullable_to_non_nullable
              as int,
      lockerNum: null == lockerNum
          ? _self.lockerNum
          : lockerNum // ignore: cast_nullable_to_non_nullable
              as int,
      pause: null == pause
          ? _self.pause
          : pause // ignore: cast_nullable_to_non_nullable
              as int,
      locker: null == locker
          ? _self.locker
          : locker // ignore: cast_nullable_to_non_nullable
              as bool,
      sportswear: null == sportswear
          ? _self.sportswear
          : sportswear // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      subscribe: null == subscribe
          ? _self.subscribe
          : subscribe // ignore: cast_nullable_to_non_nullable
              as bool,
      passTicket: null == passTicket
          ? _self.passTicket
          : passTicket // ignore: cast_nullable_to_non_nullable
              as bool,
      pauseStartDate: null == pauseStartDate
          ? _self._pauseStartDate
          : pauseStartDate // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      pauseEndDate: null == pauseEndDate
          ? _self._pauseEndDate
          : pauseEndDate // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      spotItem: null == spotItem
          ? _self.spotItem
          : spotItem // ignore: cast_nullable_to_non_nullable
              as SpotItem,
    ));
  }

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpotItemCopyWith<$Res> get spotItem {
    return $SpotItemCopyWith<$Res>(_self.spotItem, (value) {
      return _then(_self.copyWith(spotItem: value));
    });
  }
}

// dart format on
