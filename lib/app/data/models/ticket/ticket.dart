import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:white_gym_web/app/data/models/spot_item/spot_item.dart';

import '../../util/converter.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
abstract class Ticket with _$Ticket {
  const factory Ticket({
    required  final String documentId,
    required  String userDocumentId,
    required String spotDocumentId,
    required String paymentBranch,
    required  int admission,
    required  int lockerNum,
    required  int pause,
    required  bool locker,
    required  bool sportswear,
    required  bool status,
    required  bool subscribe,
    required bool passTicket,
    @DateListConverter()
    required  List<DateTime> pauseStartDate,
    @DateListConverter()
    required  List<DateTime> pauseEndDate,
    required  DateTime endDate,
    required  final DateTime createDate,
    required SpotItem spotItem,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}