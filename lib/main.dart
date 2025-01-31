import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:white_gym_web/view/findAddress.dart';
import 'package:white_gym_web/view/mainPage/mainPage.dart';
import 'package:white_gym_web/view/sign/findPassword/findPasswordView.dart';
import 'package:white_gym_web/view/sign/signIn/signInView.dart';
import 'package:white_gym_web/view/sign/signUp/singUpView.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementController.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(SpotManagementController());
  Get.put(SpotManagementController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      locale: const Locale('ko', 'KR'),
      color: Colors.white,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: false,
          fontFamily: 'Pretendard',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ), elevation: 0
          )
      ),
      initialRoute:'/signIn',
      getPages: [
        GetPage(name: '/signIn', page: () => const Login()),
        GetPage(name: '/mainPage', page: () => const MainPage()),
        GetPage(name: '/signUp', page: () => const SignUpView()),
        GetPage(name: '/findPassword', page: () => const FindPasswordView()),
        GetPage(name: '/test', page: () => const MyWebAddressPage()),
      ],

    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}