import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/util/spotManagement.dart';
import 'package:meta/meta.dart';
import 'dart:async';

class VisitRecordController extends GetxController {
  RxInt selectedPage = 1.obs;
  RxInt currentIndex = 0.obs;

  SpotManagement spot = SpotManagement();
  RxList<Spot> spotList = <Spot>[Spot.empty()].obs;
  Rx<Spot> selectedSpot = Spot.empty().obs;

  RxList test = <List>[].obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    // selectedSpot = Spot.empty().obs;
    List<Spot> temp = await SpotManagement().getSpotList();
    List<Spot> temp2 = [];
    if(myInfo.value.position != '마스터'){
      for(var i in myInfo.value.spotIdList){
        temp2 = temp2 + temp.where((element) => element.documentId == i).toList();
      }
    }
    else{
      temp2 = temp;
    }
    spotList.value = temp2;
    if(myInfo.value.position == '마스터' || (myInfo.value.position == '지점장' && myInfo.value.spotIdList.length > 1)){
      spotList.insert(0, Spot.empty());
    }
    else{
      selectedSpot.value = spotList[0];
    }
    // print('길이 : ${spotList.length}');
  }
}