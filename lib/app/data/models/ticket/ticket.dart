import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../util/converter.dart';
import '../spot_item/spot_item.dart';

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
    @DateTimeConverter()
    required  DateTime endDate,
    @DateTimeConverter()
    required  final DateTime createDate,
    required SpotItem spotItem,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
  factory Ticket.empty() => Ticket(
        documentId: '',
        userDocumentId: '',
        spotDocumentId: '',
        paymentBranch: '',
        admission: 0,
        lockerNum: 0,
        pause: 0,
        locker: false,
        sportswear: false,
        status: false,
        subscribe: false,
        passTicket: false,
        pauseStartDate: [],
        pauseEndDate: [],
        endDate: DateTime.now(),
        createDate: DateTime.now(),
        spotItem: SpotItem.empty(),
      );
}