
import 'package:white_gym_web/app/data/models/receipt.dart';

class PaymentItem {
  final String documentId;
  final String userDocumentId;
  final String userPhone;
  final String userName;
  final String spotDocumentId;
  final String paymentBranch;
  final bool subscribe;
  int sportswear;
  int locker;
  final int ticketPrice;
  final DateTime crateDate;
  final Receipt receipt;

  PaymentItem({
    required this.documentId,
    required this.userDocumentId,
    required this.userPhone,
    required this.userName,
    required this.spotDocumentId,
    required this.paymentBranch,
    required this.subscribe,
    required this.sportswear,
    required this.locker,
    required this.ticketPrice,
    required this.crateDate,
    required this.receipt,
  });

  factory PaymentItem.fromJson(Map<String, dynamic> json) {
    return PaymentItem(
      documentId: json['documentId'] as String,
      userDocumentId: json['userDocumentId'] as String,
      userPhone: json['userPhone'] as String,
      userName: json['userName'] as String,
      spotDocumentId: json['spotDocumentId'] as String,
      paymentBranch: json['paymentBranch'] as String,
      subscribe: json['subscribe'] as bool,
      sportswear: json['sportswear'] as int,
      locker: json['locker'] as int,
      ticketPrice: json['ticketPrice'] as int,
      crateDate: json['crateDate'].toDate(),
      receipt: Receipt.fromJson(json['receipt'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'userDocumentId': userDocumentId,
      'userPhone': userPhone,
      'userName': userName,
      'spotDocumentId': spotDocumentId,
      'paymentBranch': paymentBranch,
      'subscribe': subscribe,
      'sportswear': sportswear,
      'locker': locker,
      'ticketPrice': ticketPrice,
      'crateDate': crateDate,
      'receipt': receipt.toJson(),
    };
  }

  factory PaymentItem.empty() {
    return PaymentItem(
      documentId: '',
      userDocumentId: '',
      userPhone: '',
      userName: '',
      spotDocumentId: '',
      paymentBranch: '',
      subscribe: false,
      sportswear: 0,
      locker: 0,
      ticketPrice: 0,
      crateDate: DateTime.now(),
      receipt: Receipt.empty(),
    );
  }

}
