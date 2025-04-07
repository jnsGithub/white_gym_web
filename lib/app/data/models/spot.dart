import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Spot{
  final String documentId;
  String name;
  String address;
  String addressDetail;
  String descriptions;
  RxList<String> imageUrlList;
  double lat;
  double lon;
  final DateTime createDate;
  List<String> devSnList = [];

  Spot({
    required this.documentId,
    required this.name,
    required this.address,
    required this.addressDetail,
    required this.descriptions,
    required this.imageUrlList,
    required this.lat,
    required this.lon,
    required this.createDate,
    required this.devSnList
  });

  factory Spot.fromMap(Map<String, dynamic> data){

    return Spot(
      documentId: data['documentId'],
      name: data['name'],
      address: data['address'],
      addressDetail: data['addressDetail'],
      descriptions: data['descriptions'],
      imageUrlList: RxList<String>.from(data['imageUrlList']),
      lat: data['lat'],
      lon: data['lon'],
      createDate: (data['createDate'] as Timestamp).toDate(),
      devSnList: data['devSnList']??[],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'address': address,
      'addressDetail': addressDetail,
      'descriptions': descriptions,
      'imageUrlList': imageUrlList.value,
      'lat': lat,
      'lon': lon,
      'createDate': createDate,
      'devSnList': devSnList,
    };
  }

  Spot copyWith({
    String? documentId,
    String? name,
    String? address,
    String? addressDetail,
    String? descriptions,
    List<String>? imageUrlList,
    double? lat,
    double? lon,
    DateTime? createDate,
    List<String>? devSnList
  }) {
    return Spot(
      documentId: documentId ?? this.documentId,
      name: name ?? this.name,
      address: address ?? this.address,
      addressDetail: addressDetail ?? this.addressDetail,
      descriptions: descriptions ?? this.descriptions,
      imageUrlList: RxList<String>.from(imageUrlList ?? this.imageUrlList),
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      createDate: createDate ?? this.createDate,
      devSnList: devSnList ?? this.devSnList,
    );
  }

  factory Spot.empty() {
    return Spot(
      documentId: '',
      name: '전체',
      address: '',
      addressDetail: '',
      descriptions: '',
      imageUrlList: <String>[].obs,
      lat: 0,
      lon: 0,
      createDate: DateTime.now(),
      devSnList: [],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Spot{documentId: $documentId, name: $name, address: $address, addressDetail: $addressDetail, descriptions: $descriptions, imageUrlList: $imageUrlList, lat: $lat, lon: $lon, createDate: $createDate}';
  }
}