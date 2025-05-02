import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../util/converter.dart';

part 'pt_info.freezed.dart';
part 'pt_info.g.dart';

@freezed
abstract class PtInfo with _$PtInfo {
  const factory PtInfo({
    required final String documentId,
    required final String userDocumentId,
    required final String spotDocumentId,
    required final String spotName,
    required final String userName,
    required final String userPhone,
    required final int ptCount,
    @DateTimeConverter() required final DateTime createDate,
  }) = _PtInfo;

  factory PtInfo.fromJson(Map<String, dynamic> json) => _$PtInfoFromJson(json);
}