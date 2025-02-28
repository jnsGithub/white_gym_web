import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/spot.dart';
import 'package:white_gym_web/models/spotItem.dart';
import 'package:white_gym_web/util/spotItemManagement.dart';
import 'package:white_gym_web/util/spotManagement.dart';

class MembershipManagementController extends GetxController{
  RxBool isDetailView = false.obs;
  bool isUpdate = false;

  RxList<Spot> spotList = <Spot>[].obs;
  RxList<SpotItem> spotItemList = <SpotItem>[].obs;
  Rx<Spot> selectedSpot = Spot(
    documentId: '',
    name: '',
    address: '',
    addressDetail: '',
    descriptions: '',
    imageUrlList: <String>[].obs,
    lat: 0,
    lon: 0,
    createDate: DateTime.now(),
    devSnList: [],
  ).obs;
  RxList<SpotItem> selectedSpotItemList = <SpotItem>[].obs;
  Rx<SpotItem> selectedSpotItem = SpotItem(
    documentId: '',
    admission: 0,
    beforeDiscount: 0,
    createDate: DateTime.now(),
    descriptions1: '',
    descriptions2: '',
    discountCheck: false.obs,
    index: 0,
    isSubscribe: true.obs,
    locker: 0,
    monthly: 0,
    name: '',
    passTicket: true.obs,
    pause: 0,
    price: 0,
    sportswear: 0,
    spotDocumentId: '',
  ).obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptions1Controller = TextEditingController();
  TextEditingController descriptions2Controller = TextEditingController();
  TextEditingController admissionController = TextEditingController();
  TextEditingController lockerController = TextEditingController();
  TextEditingController sportswearController = TextEditingController();
  TextEditingController beforeDiscountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController monthlyController = TextEditingController();
  TextEditingController pauseController = TextEditingController();

  RxInt selectedSpotIndex = 0.obs;


  @override
  void onInit() {
    super.onInit();
    init();
  }
  @override
  void onClose(){
    super.onClose();
  }


  init() async{
    await getSpotItemList();
    await getSpotList();
    searchSpotItem(spotList[selectedSpotIndex.value]);
  }

  clearController(){
    nameController.clear();
    descriptions1Controller.clear();
    descriptions2Controller.clear();
    admissionController.clear();
    lockerController.clear();
    sportswearController.clear();
    beforeDiscountController.clear();
    priceController.clear();
    monthlyController.clear();
    pauseController.clear();
  }

  searchSpotItem(Spot spot){
    selectedSpot.value = spot.copyWith();
    selectedSpotItemList.value = spotItemList.where((element) => element.spotDocumentId == spot.documentId).toList();
  }

  Future<void> getSpotList() async {
    List<Spot> temp = await SpotManagement().getSpotList();
    if(myInfo.value.position != '마스터'){
      for(int i = 0; i < myInfo.value.spotIdList.length; i++){
        spotList.add(temp.where((element) => element.documentId == myInfo.value.spotIdList[i]).first);
      }
    }
    else{
      spotList.value = temp;
    }
    selectedSpotIndex.value = 0;
  }

  Future<void> getSpotItemList() async {
    spotItemList.value = await SpotItemManagement().getSpotItemList();
  }

  Future<void> updateSpotItem() async {
    await SpotItemManagement().updateSpotItem(selectedSpotItem.value);
    clearController();
    selectedSpotItem = SpotItem(
      documentId: '',
      admission: 0,
      beforeDiscount: 0,
      createDate: DateTime.now(),
      descriptions1: '',
      descriptions2: '',
      discountCheck: false.obs,
      index: 0,
      isSubscribe: true.obs,
      locker: 0,
      monthly: 0,
      name: '',
      passTicket: true.obs,
      pause: 0,
      price: 0,
      sportswear: 0,
      spotDocumentId: '',
    ).obs;
  }

  Future<void> updateSpotItemIndex() async {
    await SpotItemManagement().updateIndex(selectedSpotItemList);
  }

  Future<void> addSpotItem() async {
    await SpotItemManagement().addSpotItem(
        SpotItem(
            documentId: '',
            admission: admissionController.text == '' ? 0 : int.parse(admissionController.text),
            beforeDiscount: beforeDiscountController.text == '' ? 0 : int.parse(beforeDiscountController.text),
            createDate: DateTime.now(),
            descriptions1: descriptions1Controller.text,
            descriptions2: descriptions2Controller.text,
            discountCheck: selectedSpotItem.value.discountCheck,
            index: selectedSpotItem.value.index,
            isSubscribe: selectedSpotItem.value.isSubscribe,
            locker: lockerController.text == '' ? 0 : int.parse(lockerController.text),
            monthly: selectedSpotItem.value.isSubscribe.value ? 0 : int.parse(monthlyController.text),
            name: nameController.text,
            passTicket: selectedSpotItem.value.passTicket,
            pause: selectedSpotItem.value.isSubscribe.value ? 0 : int.parse(pauseController.text),
            price: priceController.text == '' ? 0 : int.parse(priceController.text),
            sportswear: sportswearController.text == '' ? 0 : int.parse(sportswearController.text),
            spotDocumentId: selectedSpot.value.documentId
        ));
    init();
    clearController();
    selectedSpotItem = SpotItem(
      documentId: '',
      admission: 0,
      beforeDiscount: 0,
      createDate: DateTime.now(),
      descriptions1: '',
      descriptions2: '',
      discountCheck: false.obs,
      index: 0,
      isSubscribe: true.obs,
      locker: 0,
      monthly: 0,
      name: '',
      passTicket: true.obs,
      pause: 0,
      price: 0,
      sportswear: 0,
      spotDocumentId: '',
    ).obs;
  }

  setController(){
    nameController.text = selectedSpotItem.value.name;
    descriptions1Controller.text = selectedSpotItem.value.descriptions1;
    descriptions2Controller.text = selectedSpotItem.value.descriptions2;
    admissionController.text = selectedSpotItem.value.admission.toString();
    lockerController.text = selectedSpotItem.value.locker.toString();
    sportswearController.text = selectedSpotItem.value.sportswear.toString();
    beforeDiscountController.text = selectedSpotItem.value.beforeDiscount.toString();
    priceController.text = selectedSpotItem.value.price.toString();
    monthlyController.text = selectedSpotItem.value.monthly.toString();
    pauseController.text = selectedSpotItem.value.pause.toString();
  }
}