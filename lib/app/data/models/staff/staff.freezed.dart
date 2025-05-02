// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Staff {
  String get documentId;
  String get email;
  String get name;
  List<String> get spotIdList;
  String get position;
  String get hp;
  @DateTimeConverter()
  DateTime get createDate;
  bool get isApproved;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StaffCopyWith<Staff> get copyWith =>
      _$StaffCopyWithImpl<Staff>(this as Staff, _$identity);

  /// Serializes this Staff to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Staff &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.spotIdList, spotIdList) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      email,
      name,
      const DeepCollectionEquality().hash(spotIdList),
      position,
      hp,
      createDate,
      isApproved);

  @override
  String toString() {
    return 'Staff(documentId: $documentId, email: $email, name: $name, spotIdList: $spotIdList, position: $position, hp: $hp, createDate: $createDate, isApproved: $isApproved)';
  }
}

/// @nodoc
abstract mixin class $StaffCopyWith<$Res> {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) _then) =
      _$StaffCopyWithImpl;
  @useResult
  $Res call(
      {String documentId,
      String email,
      String name,
      List<String> spotIdList,
      String position,
      String hp,
      @DateTimeConverter() DateTime createDate,
      bool isApproved});
}

/// @nodoc
class _$StaffCopyWithImpl<$Res> implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._self, this._then);

  final Staff _self;
  final $Res Function(Staff) _then;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentId = null,
    Object? email = null,
    Object? name = null,
    Object? spotIdList = null,
    Object? position = null,
    Object? hp = null,
    Object? createDate = null,
    Object? isApproved = null,
  }) {
    return _then(_self.copyWith(
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      spotIdList: null == spotIdList
          ? _self.spotIdList
          : spotIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      hp: null == hp
          ? _self.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isApproved: null == isApproved
          ? _self.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Staff implements Staff {
  const _Staff(
      {required this.documentId,
      required this.email,
      required this.name,
      required final List<String> spotIdList,
      required this.position,
      required this.hp,
      @DateTimeConverter() required this.createDate,
      required this.isApproved})
      : _spotIdList = spotIdList;
  factory _Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  @override
  final String documentId;
  @override
  final String email;
  @override
  final String name;
  final List<String> _spotIdList;
  @override
  List<String> get spotIdList {
    if (_spotIdList is EqualUnmodifiableListView) return _spotIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spotIdList);
  }

  @override
  final String position;
  @override
  final String hp;
  @override
  @DateTimeConverter()
  final DateTime createDate;
  @override
  final bool isApproved;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StaffCopyWith<_Staff> get copyWith =>
      __$StaffCopyWithImpl<_Staff>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StaffToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Staff &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._spotIdList, _spotIdList) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      documentId,
      email,
      name,
      const DeepCollectionEquality().hash(_spotIdList),
      position,
      hp,
      createDate,
      isApproved);

  @override
  String toString() {
    return 'Staff(documentId: $documentId, email: $email, name: $name, spotIdList: $spotIdList, position: $position, hp: $hp, createDate: $createDate, isApproved: $isApproved)';
  }
}

/// @nodoc
abstract mixin class _$StaffCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$StaffCopyWith(_Staff value, $Res Function(_Staff) _then) =
      __$StaffCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String documentId,
      String email,
      String name,
      List<String> spotIdList,
      String position,
      String hp,
      @DateTimeConverter() DateTime createDate,
      bool isApproved});
}

/// @nodoc
class __$StaffCopyWithImpl<$Res> implements _$StaffCopyWith<$Res> {
  __$StaffCopyWithImpl(this._self, this._then);

  final _Staff _self;
  final $Res Function(_Staff) _then;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? documentId = null,
    Object? email = null,
    Object? name = null,
    Object? spotIdList = null,
    Object? position = null,
    Object? hp = null,
    Object? createDate = null,
    Object? isApproved = null,
  }) {
    return _then(_Staff(
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      spotIdList: null == spotIdList
          ? _self._spotIdList
          : spotIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      hp: null == hp
          ? _self.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isApproved: null == isApproved
          ? _self.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
