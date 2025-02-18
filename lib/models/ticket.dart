import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_gym_web/models/spotItem.dart';

class Ticket {
  final String documentId;
  String userDocumentId;
  String spotDocumentId;
  String paymentBranch;
  int admission;
  int lockerNum;
  int pause;
  bool locker;
  bool sportswear;
  bool status;
  final bool subscribe;
  bool passTicket;
  List<DateTime> pauseStartDate;
  List<DateTime> pauseEndDate;
  DateTime endDate;
  final DateTime createDate;
  SpotItem spotItem;

  Ticket({
    required this.documentId,
    required this.userDocumentId,
    required this.spotDocumentId, // 지점 아이디
    required this.spotItem, //지점 아이템 아이디
    required this.paymentBranch, // 지점명
    required this.admission, // 입장 제한 수
    required this.lockerNum, // 사물함 번호
    required this.pause, // 일시정지
    required this.locker,
    required this.sportswear,
    required this.status,
    required this.subscribe,
    required this.passTicket,
    required this.pauseStartDate,
    required this.pauseEndDate,
    required this.createDate,
    required this.endDate,
  });


  factory Ticket.fromJson(Map<String, dynamic> data) {
    // spotItem 처리 등은 기존과 동일하게 처리
    final spotItemData = data['spotItem'];
    try{
      return Ticket(
        documentId: data['documentId'] as String,
        userDocumentId: data['userDocumentId'] as String,
        spotDocumentId: data['spotDocumentId'] as String,
        spotItem: spotItemData == null
            ? SpotItem.empty()
            : SpotItem.fromMap(spotItemData as Map<String, dynamic>),
        paymentBranch: data['paymentBranch'] as String,
        admission: data['admission'] as int,
        lockerNum: data['lockerNum'] as int,
        pause: data['pause'] as int,
        locker: data['locker'] as bool,
        sportswear: data['sportswear'] as bool,
        status: data['status'] as bool,
        subscribe: data['subscribe'] as bool,
        passTicket: data['passTicket'] as bool,
        // pauseDate와 pauseEndDate가 없으면 빈 리스트([])를 기본값으로 사용
        pauseStartDate: data['pauseStartDate'] != null
            ? (data['pauseStartDate'] as List<dynamic>)
            .map((e) => (e as Timestamp).toDate())
            .toList()
            : [],
        pauseEndDate: data['pauseEndDate'] != null
            ? (data['pauseEndDate'] as List<dynamic>)
            .map((e) => (e as Timestamp).toDate())
            .toList()
            : [],
        endDate: (data['endDate'] as Timestamp).toDate(),
        createDate: (data['createDate'] as Timestamp).toDate(),
      );
    } catch(e){
      print(123);
      return Ticket(
        documentId: data['documentId'] as String,
        userDocumentId: data['userDocumentId'] as String,
        spotDocumentId: data['spotDocumentId'] as String,
        spotItem: spotItemData == null
            ? SpotItem.empty()
            : SpotItem.fromMap(spotItemData as Map<String, dynamic>),
        paymentBranch: data['paymentBranch'] as String,
        admission: data['admission'] as int,
        lockerNum: data['lockerNum'] as int,
        pause: data['pause'] as int,
        locker: data['locker'] as bool,
        sportswear: data['sportswear'] as bool,
        status: data['status'] as bool,
        subscribe: data['subscribe'] as bool,
        passTicket: data['passTicket'] as bool,
        // pauseDate와 pauseEndDate가 없으면 빈 리스트([])를 기본값으로 사용
        pauseStartDate: data['pauseStartDate'] != null
            ? (data['pauseStartDate'] as List<dynamic>)
            .map((e) => (e as Timestamp).toDate())
            .toList()
            : [],
        pauseEndDate: data['pauseEndDate'] != null
            ? (data['pauseEndDate'] as List<dynamic>)
            .map((e) => (e as Timestamp).toDate())
            .toList()
            : [],
        endDate: (data['endDate'] as Timestamp).toDate(),
        createDate: (data['createDate'] as Timestamp).toDate(),
      );
    }

  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'userDocumentId': userDocumentId,
      'spotDocumentId': spotDocumentId,
      'spotItem': spotItem.toMap(),
      'paymentBranch': paymentBranch,
      'admission': admission,
      'lockerNum': lockerNum,
      'pause': pause,
      'locker': locker,
      'sportswear': sportswear,
      'status': status,
      'subscribe': subscribe,
      'passTicket': passTicket,
      'endDate': endDate,
      'pauseStartDate': pauseStartDate,
      'pauseEndDate': pauseEndDate,
      'createDate': createDate,
    };
  }
  factory Ticket.empty() {
    return Ticket(
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
      endDate: DateTime(1990, 12, 31),
      pauseEndDate: [],
      createDate: DateTime.now(),
      spotItem: SpotItem.empty(),
    );
  }

  @override
  String toString() {
    return 'Ticket{documentId: $documentId, userDocumentId: $userDocumentId, spotDocumentId: $spotDocumentId, paymentBranch: $paymentBranch, admission: $admission, lockerNum: $lockerNum, pause: $pause, locker: $locker, sportswear: $sportswear, status: $status, subscribe: $subscribe, passTicket: $passTicket, pauseStartDate: $pauseStartDate, pauseEndDate: $pauseEndDate, endDate: $endDate, createDate: $createDate, spotItem: $spotItem}';
  }
}