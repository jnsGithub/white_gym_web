import 'dart:typed_data';
import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/data/service/spot_management.dart';
import 'package:white_gym_web/global/global.dart';
import 'package:white_gym_web/app/data/models/spot.dart';

import 'dart:convert';
import 'dart:js' as js;
import 'package:http/http.dart' as http;


class SpotManagementController extends GetxController {
  RxBool isDetailView = false.obs;
  bool isUpdate = false;

  RxList<Spot> spotList = <Spot>[].obs;
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

  RxString selectedRoadAddress = ''.obs;
  RxString selectedJibunAddress = ''.obs;
  RxString selectedZonecode = ''.obs;

  TextEditingController selectedNameController = TextEditingController();
  TextEditingController selectedAddressController = TextEditingController();
  TextEditingController selectedAddressDetailController = TextEditingController();
  TextEditingController selectedDescriptionController = TextEditingController();


  RxList<TextEditingController> devSnControllerList = <TextEditingController>[].obs;
  RxList<Widget> devSnWidgetList = <Widget>[].obs;

  @override
  void onInit() {
    super.onInit();
    init();

    js.context["onJusoSelected"] = (String jsonStr) {
      Map data = jsonDecode(jsonStr);

      // print(jsonStr);
      selectedRoadAddress.value = data['roadAddress'] ?? '';
      selectedSpot.value.address = selectedRoadAddress.value;
      selectedAddressController.text = selectedRoadAddress.value;
      selectedJibunAddress.value = data['jibunAddress'] ?? '';
      selectedZonecode.value = data['zoneCode'] ?? '';
      getLocation();
    };
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    await getSpotList();
  }

  Future<void> addSpot() async {
    List<String> imageUrlList = await uploadImage();
    selectedSpot.value.name = selectedNameController.text;
    selectedSpot.value.address = selectedAddressController.text;
    selectedSpot.value.addressDetail = selectedAddressDetailController.text;
    selectedSpot.value.descriptions = selectedDescriptionController.text;
    selectedSpot.value.imageUrlList = imageUrlList.obs;
    selectedSpot.value.devSnList = devSnControllerList.map((e) => e.text).toList();
    await SpotManagement().addSpot(selectedSpot.value);
    await getSpotList();
  }

  Future<void> getSpotList() async {
    final List<Spot> fetchedList = await SpotManagement().getSpotList(); // 데이터 가져오기
    List<Spot> temp = [];

    if (myInfo.value.position != '마스터') {
      temp.addAll(
          fetchedList.where((element) => myInfo.value.spotIdList.contains(element.documentId))
      );
    } else {
      temp = fetchedList;
    }

    // 한 번만 업데이트하여 불필요한 상태 변경 방지
    spotList.value = temp;
  }


  Future<void> updateSpot() async {
    selectedSpot.value.name = selectedNameController.text;
    selectedSpot.value.address = selectedAddressController.text;
    selectedSpot.value.addressDetail = selectedAddressDetailController.text;
    selectedSpot.value.descriptions = selectedDescriptionController.text;
    selectedSpot.value.devSnList = devSnControllerList.map((e) => e.text).toList();
    await SpotManagement().updateSpot(selectedSpot.value, image, selectedSpot.value.imageUrlList.isEmpty);
    await getSpotList();
  }

  Future<List<String>> uploadImage() async {
    return await SpotManagement().uploadSpotImage(image);
  }

  RxList<Uint8List?> image = <Uint8List?>[].obs;

  void pickImage() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files?.isNotEmpty ?? false) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files![0]);
        reader.onLoadEnd.listen((e) {
          image.add(reader.result as Uint8List?);
        });
      }
    });
  }

  void getLocation() async {
    if (selectedRoadAddress.value.isEmpty) return;

    String url =
        'https://dapi.kakao.com/v2/local/search/address.JSON?query=${selectedRoadAddress.value}';

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'KakaoAK 508e65d4591c22ae072a16fa9ddf99a6',
        },
      );

      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.body);
        print(dataJson);
        selectedSpot.value.lat = double.parse(dataJson['documents'][0]['y']);
        selectedSpot.value.lon = double.parse(dataJson['documents'][0]['x']);
        update();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void openDaumPostcode() async {
    // index.html에 정의된 openDaumPostcode 함수를 호출
    js.context.callMethod('openDaumPostcode', ['onJusoSelected']);
  }

  void setSelecedSpot(Spot spot) {
    selectedSpot.value = spot.copyWith();
    selectedNameController.text = selectedSpot.value.name;
    selectedAddressController.text = selectedSpot.value.address;
    selectedAddressDetailController.text = selectedSpot.value.addressDetail;
    selectedDescriptionController.text = selectedSpot.value.descriptions;
    selectedRoadAddress.value = selectedSpot.value.address;
    devSnControllerList.value = selectedSpot.value.devSnList.map((e) => TextEditingController(text: e)).toList();
    selectedJibunAddress.value = '';
    selectedZonecode.value = '';
  }

  void clearSelectedSpot() {
    selectedSpot.value = Spot(
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
    );
    selectedNameController.clear();
    selectedAddressController.clear();
    selectedAddressDetailController.clear();
    selectedDescriptionController.clear();
    selectedRoadAddress.value = '';
    selectedJibunAddress.value = '';
    selectedZonecode.value = '';
    devSnControllerList.clear();
    devSnWidgetList.clear();
    image.clear();
  }

  Widget textField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bg
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: '장비 SN',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}