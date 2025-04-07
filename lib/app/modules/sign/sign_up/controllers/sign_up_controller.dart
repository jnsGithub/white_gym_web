import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:white_gym_web/app/data/models/spot.dart';
import 'package:white_gym_web/app/data/service/sign.dart';
import 'package:white_gym_web/app/data/service/spot.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController hpController = TextEditingController();

  List<String> positionList = ['트레이너', '인포', '매니저', '지점장'].obs;
  RxInt selectedType = 0.obs;
  RxString selectedItem = '소속지점'.obs;
  RxString selectedItems = '소속지점'.obs;
  List<String> selectedSpotIdList = [];

  RxList<Spot> items = <Spot>[].obs;

  Sign sign = Sign();

  @override
  void onInit() {
    super.onInit();
    init();
  }
  @override
  void onClose(){
    super.onClose();
  }

  init() {
    getSpotList();
  }

  getSpotList() async {
    items.value = await SpotManagement().getSpotList();
  }

}