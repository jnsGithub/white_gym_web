// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pt_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PtInfo {
  String get documentId;
  String get userDocumentId;
  String get spotDocumentId;
  String get spotName;
  String get userName;
  String get userPhone;
  String get trainerName;
  String get trainerDocumentId;
  @DateTimeConverter()
  DateTime get attendanceDate;
  List<DateTime> get attendanceTimeList;
  int get trainingTime;
  int get trainingPart;
  String get comment;
  int get status;
  @DateTimeConverter()
  DateTime get createDate;

  /// Create a copy of PtInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PtInfoCopyWith<PtInfo> get copyWith =>
      _$PtInfoCopyWithImpl<PtInfo>(this as PtInfo, _$identity);

  /// Serializes this PtInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PtInfo &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.userDocumentId, userDocumentId) ||
                other.userDocumentId == userDocumentId) &&
            (identical(other.spotDocumentId, spotDocumentId) ||
                other.spotDocumentId == spotDocumentId) &&
            (identical(other.spotName, spotName) ||
                other.spotName == spotName) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.trainerName, trainerName) ||
                other.trainerName == trainerName) &&
            (identical(other.trainerDocumentId, trainerDocumentId) ||
                other.trainerDocumentId == trainerDocumentId) &&
            (identical(other.attendanceDate, attendanceDate) ||
                other.attendanceDate == attendanceDate) &&
            const DeepCollectionEquality()
                .equals(other.attendanceTimeList, attendanceTimeList) &&
            (identical(other.trainingTime, trainingTime) ||
                other.trainingTime == trainingTime) &&
            (identical(other.trainingPart, trainingPart) ||
                other.trainingPart == trainingPart) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      userDocumentId,
      spotDocumentId,
      spotName,
      userName,
      userPhone,
      trainerName,
      trainerDocumentId,
      attendanceDate,
      const DeepCollectionEquality().hash(attendanceTimeList),
      trainingTime,
      trainingPart,
      comment,
      status,
      createDate);

  @override
  String toString() {
    return 'PtInfo(documentId: $documentId, userDocumentId: $userDocumentId, spotDocumentId: $spotDocumentId, spotName: $spotName, userName: $userName, userPhone: $userPhone, trainerName: $trainerName, trainerDocumentId: $trainerDocumentId, attendanceDate: $attendanceDate, attendanceTimeList: $attendanceTimeList, trainingTime: $trainingTime, trainingPart: $trainingPart, comment: $comment, status: $status, createDate: $createDate)';
  }
}

/// @nodoc
abstract mixin class $PtInfoCopyWith<$Res> {
  factory $PtInfoCopyWith(PtInfo value, $Res Function(PtInfo) _then) =
      _$PtInfoCopyWithImpl;
  @useResult
  $Res call(
      {String documentId,
      String userDocumentId,
      String spotDocumentId,
      String spotName,
      String userName,
      String userPhone,
      String trainerName,
      String trainerDocumentId,
      @DateTimeConverter() DateTime attendanceDate,
      List<DateTime> attendanceTimeList,
      int trainingTime,
      int trainingPart,
      String comment,
      int status,
      @DateTimeConverter() DateTime createDate});
}

/// @nodoc
class _$PtInfoCopyWithImpl<$Res> implements $PtInfoCopyWith<$Res> {
  _$PtInfoCopyWithImpl(this._self, this._then);

  final PtInfo _self;
  final $Res Function(PtInfo) _then;

  /// Create a copy of PtInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentId = null,
    Object? userDocumentId = null,
    Object? spotDocumentId = null,
    Object? spotName = null,
    Object? userName = null,
    Object? userPhone = null,
    Object? trainerName = null,
    Object? trainerDocumentId = null,
    Object? attendanceDate = null,
    Object? attendanceTimeList = null,
    Object? trainingTime = null,
    Object? trainingPart = null,
    Object? comment = null,
    Object? status = null,
    Object? createDate = null,
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
      spotName: null == spotName
          ? _self.spotName
          : spotName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _self.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      trainerName: null == trainerName
          ? _self.trainerName
          : trainerName // ignore: cast_nullable_to_non_nullable
              as String,
      trainerDocumentId: null == trainerDocumentId
          ? _self.trainerDocumentId
          : trainerDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceDate: null == attendanceDate
          ? _self.attendanceDate
          : attendanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attendanceTimeList: null == attendanceTimeList
          ? _self.attendanceTimeList
          : attendanceTimeList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      trainingTime: null == trainingTime
          ? _self.trainingTime
          : trainingTime // ignore: cast_nullable_to_non_nullable
              as int,
      trainingPart: null == trainingPart
          ? _self.trainingPart
          : trainingPart // ignore: cast_nullable_to_non_nullable
              as int,
      comment: null == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PtInfo implements PtInfo {
  const _PtInfo(
      {required this.documentId,
      required this.userDocumentId,
      required this.spotDocumentId,
      required this.spotName,
      required this.userName,
      required this.userPhone,
      required this.trainerName,
      required this.trainerDocumentId,
      @DateTimeConverter() required this.attendanceDate,
      required final List<DateTime> attendanceTimeList,
      required this.trainingTime,
      required this.trainingPart,
      required this.comment,
      required this.status,
      @DateTimeConverter() required this.createDate})
      : _attendanceTimeList = attendanceTimeList;
  factory _PtInfo.fromJson(Map<String, dynamic> json) => _$PtInfoFromJson(json);

  @override
  final String documentId;
  @override
  final String userDocumentId;
  @override
  final String spotDocumentId;
  @override
  final String spotName;
  @override
  final String userName;
  @override
  final String userPhone;
  @override
  final String trainerName;
  @override
  final String trainerDocumentId;
  @override
  @DateTimeConverter()
  final DateTime attendanceDate;
  final List<DateTime> _attendanceTimeList;
  @override
  List<DateTime> get attendanceTimeList {
    if (_attendanceTimeList is EqualUnmodifiableListView)
      return _attendanceTimeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendanceTimeList);
  }

  @override
  final int trainingTime;
  @override
  final int trainingPart;
  @override
  final String comment;
  @override
  final int status;
  @override
  @DateTimeConverter()
  final DateTime createDate;

  /// Create a copy of PtInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PtInfoCopyWith<_PtInfo> get copyWith =>
      __$PtInfoCopyWithImpl<_PtInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PtInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PtInfo &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.userDocumentId, userDocumentId) ||
                other.userDocumentId == userDocumentId) &&
            (identical(other.spotDocumentId, spotDocumentId) ||
                other.spotDocumentId == spotDocumentId) &&
            (identical(other.spotName, spotName) ||
                other.spotName == spotName) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.trainerName, trainerName) ||
                other.trainerName == trainerName) &&
            (identical(other.trainerDocumentId, trainerDocumentId) ||
                other.trainerDocumentId == trainerDocumentId) &&
            (identical(other.attendanceDate, attendanceDate) ||
                other.attendanceDate == attendanceDate) &&
            const DeepCollectionEquality()
                .equals(other._attendanceTimeList, _attendanceTimeList) &&
            (identical(other.trainingTime, trainingTime) ||
                other.trainingTime == trainingTime) &&
            (identical(other.trainingPart, trainingPart) ||
                other.trainingPart == trainingPart) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      userDocumentId,
      spotDocumentId,
      spotName,
      userName,
      userPhone,
      trainerName,
      trainerDocumentId,
      attendanceDate,
      const DeepCollectionEquality().hash(_attendanceTimeList),
      trainingTime,
      trainingPart,
      comment,
      status,
      createDate);

  @override
  String toString() {
    return 'PtInfo(documentId: $documentId, userDocumentId: $userDocumentId, spotDocumentId: $spotDocumentId, spotName: $spotName, userName: $userName, userPhone: $userPhone, trainerName: $trainerName, trainerDocumentId: $trainerDocumentId, attendanceDate: $attendanceDate, attendanceTimeList: $attendanceTimeList, trainingTime: $trainingTime, trainingPart: $trainingPart, comment: $comment, status: $status, createDate: $createDate)';
  }
}

/// @nodoc
abstract mixin class _$PtInfoCopyWith<$Res> implements $PtInfoCopyWith<$Res> {
  factory _$PtInfoCopyWith(_PtInfo value, $Res Function(_PtInfo) _then) =
      __$PtInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String documentId,
      String userDocumentId,
      String spotDocumentId,
      String spotName,
      String userName,
      String userPhone,
      String trainerName,
      String trainerDocumentId,
      @DateTimeConverter() DateTime attendanceDate,
      List<DateTime> attendanceTimeList,
      int trainingTime,
      int trainingPart,
      String comment,
      int status,
      @DateTimeConverter() DateTime createDate});
}

/// @nodoc
class __$PtInfoCopyWithImpl<$Res> implements _$PtInfoCopyWith<$Res> {
  __$PtInfoCopyWithImpl(this._self, this._then);

  final _PtInfo _self;
  final $Res Function(_PtInfo) _then;

  /// Create a copy of PtInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? documentId = null,
    Object? userDocumentId = null,
    Object? spotDocumentId = null,
    Object? spotName = null,
    Object? userName = null,
    Object? userPhone = null,
    Object? trainerName = null,
    Object? trainerDocumentId = null,
    Object? attendanceDate = null,
    Object? attendanceTimeList = null,
    Object? trainingTime = null,
    Object? trainingPart = null,
    Object? comment = null,
    Object? status = null,
    Object? createDate = null,
  }) {
    return _then(_PtInfo(
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
      spotName: null == spotName
          ? _self.spotName
          : spotName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _self.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      trainerName: null == trainerName
          ? _self.trainerName
          : trainerName // ignore: cast_nullable_to_non_nullable
              as String,
      trainerDocumentId: null == trainerDocumentId
          ? _self.trainerDocumentId
          : trainerDocumentId // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceDate: null == attendanceDate
          ? _self.attendanceDate
          : attendanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attendanceTimeList: null == attendanceTimeList
          ? _self._attendanceTimeList
          : attendanceTimeList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      trainingTime: null == trainingTime
          ? _self.trainingTime
          : trainingTime // ignore: cast_nullable_to_non_nullable
              as int,
      trainingPart: null == trainingPart
          ? _self.trainingPart
          : trainingPart // ignore: cast_nullable_to_non_nullable
              as int,
      comment: null == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
