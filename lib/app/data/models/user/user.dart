import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:white_gym_web/app/data/models/ticket/ticket.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User{
  const factory User({
    required final String documentId,
    required String name,
    required String phone,
    required final String birth,
    required String storeDocumentId,
    required String paymentCard,
    required String fcmToken,
    required int gender,
    required final bool pushAlarm,
    required bool smsAlarm,
    required Ticket ticket,
    @TimestampConverter() required final Timestamp createDate,
}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

class TimestampConverter implements JsonConverter<Timestamp, dynamic> {
  const TimestampConverter();

  @override
  Timestamp fromJson(dynamic json) {
    if (json is Timestamp) return json;
    if (json is Map<String, dynamic> && json.containsKey('_seconds')) {
      // Edge case for manually crafted JSON
      return Timestamp(json['_seconds'], json['_nanoseconds'] ?? 0);
    }
    if (json is String) {
      return Timestamp.fromDate(DateTime.parse(json));
    }
    throw ArgumentError('Invalid Timestamp format: $json');
  }

  @override
  dynamic toJson(Timestamp timestamp) => timestamp;
}