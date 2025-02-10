import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/models/spot.dart';

class SpotItem {
  final String documentId;
  String name;              // 멤버쉽 이름
  String descriptions1;     // 설명1
  String descriptions2;     // 설명2
  int price;                // 가격
  RxBool discountCheck;       // 할인 여부
  int beforeDiscount;       // 할인 전 가격 (할인 여부가 False일 경우 0)
  int admission;            // 일일 입장횟수
  int index;                // 순서
  RxBool isSubscribe;         // 구독 여부
  int? pause;                // 일시정지 가능 횟수 (구독 여부가 True일 경우 0)
  int locker;               // 사물함 가격
  int? monthly;              // 개월 수
  RxBool passTicket;          // 전지점 이용 가능 여부
  int sportswear;           // 운동복 가격
  String spotDocumentId;    // spotDocumentId
  final DateTime createDate;      // 생성일

  SpotItem({
    required this.documentId,
    required this.admission,
    required this.beforeDiscount,
    required this.createDate,
    required this.descriptions1,
    required this.descriptions2,
    required this.discountCheck,
    required this.index,
    required this.isSubscribe,
    required this.locker,
    required this.monthly,
    required this.name,
    required this.passTicket,
    required this.pause,
    required this.price,
    required this.sportswear,
    required this.spotDocumentId,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory SpotItem.fromMap(Map<String, dynamic> map) {
    try {
      return SpotItem(
        documentId: map['documentId'],
        admission: map['admission'],
        beforeDiscount: map['beforeDiscount'],
        createDate: (map['createDate'] as Timestamp).toDate(),
        descriptions1: map['descriptions1'],
        descriptions2: map['descriptions2'],
        discountCheck: (map['discountCheck'] as bool).obs,
        index: map['index'],
        isSubscribe: (map['isSubscribe'] as bool).obs,
        locker: map['locker'],
        monthly: map['monthly'],
        name: map['name'],
        passTicket: (map['passTicket'] as bool).obs,
        pause: map['pause'],
        price: map['price'],
        sportswear: map['sportswear'],
        spotDocumentId: map['spotDocumentId'],
      );
    } catch (e) {
      return SpotItem(
        documentId: map['documentId'],
        admission: map['admission'],
        beforeDiscount: map['beforeDiscount'],
        createDate: (map['createDate'] as Timestamp).toDate(),
        descriptions1: map['descriptions1'],
        descriptions2: map['descriptions2'],
        discountCheck: (map['discountCheck'] as bool).obs,
        index: map['index'],
        isSubscribe: (map['isSubscribe'] as bool).obs,
        locker: map['locker'],
        monthly: map['monthly'],
        name: map['name'],
        passTicket: (map['passTicket'] as bool).obs,
        pause: map['pause'],
        price: map['price'],
        sportswear: map['sportswear'],
        spotDocumentId: map['spotDocumentId'],
      );
    }

  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'admission': admission,
      'beforeDiscount': beforeDiscount,
      'createDate': createDate,
      'descriptions1': descriptions1,
      'descriptions2': descriptions2,
      'discountCheck': discountCheck.value,
      'index': index,
      'isSubscribe': isSubscribe.value,
      'locker': locker,
      'monthly': monthly,
      'name': name,
      'passTicket': passTicket.value,
      'pause': pause,
      'price': price,
      'sportswear': sportswear,
      'spotDocumentId': spotDocumentId,
    };
  }

  factory SpotItem.empty() {
    return SpotItem(
      documentId: '',
      name: '',
      descriptions1: '',
      descriptions2: '',
      spotDocumentId: '',
      isSubscribe: false.obs,
      passTicket: false.obs,
      discountCheck: false.obs,
      index: 0,
      admission: 0,
      locker: 0,
      monthly: 0,
      pause: 0,
      beforeDiscount: 0,
      price: 0,
      sportswear: 0,
      createDate: DateTime.now(),
    );
  }

  SpotItem copyWith({
    String? documentId,
    int? admission,
    int? beforeDiscount,
    DateTime? createDate,
    String? descriptions1,
    String? descriptions2,
    RxBool? discountCheck,
    int? index,
    RxBool? isSubscribe,
    int? locker,
    int? monthly,
    String? name,
    RxBool? passTicket,
    int? pause,
    int? price,
    int? sportswear,
    String? spotDocumentId,
  }) {
    return SpotItem(
      documentId: documentId ?? this.documentId,
      admission: admission ?? this.admission,
      beforeDiscount: beforeDiscount ?? this.beforeDiscount,
      createDate: createDate ?? this.createDate,
      descriptions1: descriptions1 ?? this.descriptions1,
      descriptions2: descriptions2 ?? this.descriptions2,
      discountCheck: discountCheck ?? this.discountCheck,
      index: index ?? this.index,
      isSubscribe: isSubscribe ?? this.isSubscribe,
      locker: locker ?? this.locker,
      monthly: monthly ?? this.monthly,
      name: name ?? this.name,
      passTicket: passTicket ?? this.passTicket,
      pause: pause ?? this.pause,
      price: price ?? this.price,
      sportswear: sportswear ?? this.sportswear,
      spotDocumentId: spotDocumentId ?? this.spotDocumentId,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'SpotItem{documentId: $documentId, name: $name, descriptions1: $descriptions1, descriptions2: $descriptions2, price: $price, discountCheck: $discountCheck, beforeDiscount: $beforeDiscount, admission: $admission, index: $index, isSubscribe: $isSubscribe, pause: $pause, locker: $locker, monthly: $monthly, passTicket: $passTicket, sportswear: $sportswear, spotDocumentId: $spotDocumentId, createDate: $createDate}';
  }
}
