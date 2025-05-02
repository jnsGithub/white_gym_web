import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/data/util/converter.dart';

part 'staff.freezed.dart';
part 'staff.g.dart';

@freezed
abstract class Staff with _$Staff {
  const factory Staff({
    required final String documentId,
    required final String email,
    required final String name,
    required final List<String> spotIdList,
    required final String position,
    required final String hp,
    @DateTimeConverter()
    required final DateTime createDate,
    required bool isApproved,
  }) = _Staff;

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);
}