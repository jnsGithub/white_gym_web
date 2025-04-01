import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:white_gym_web/util/spotItemManagement.dart';
import 'package:white_gym_web/view/findAddress.dart';
import 'package:white_gym_web/view/mainPage/mainPage.dart';
import 'package:white_gym_web/view/membershipManagement/membershipManagementController.dart';
import 'package:white_gym_web/view/sign/findPassword/findPasswordView.dart';
import 'package:white_gym_web/view/sign/signIn/signInController.dart';
import 'package:white_gym_web/view/sign/signIn/signInView.dart';
import 'package:white_gym_web/view/sign/signUp/singUpView.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:white_gym_web/view/spotManagement/spotManagementController.dart';
import 'package:white_gym_web/view/staff/staffManagementController.dart';
import 'package:white_gym_web/view/user/userManagementController.dart';
import 'package:white_gym_web/view/visitRecordManagement/visitRecordController.dart';
import 'firebase_options.dart';
import 'global.dart';
import 'view/mainPage/mainController.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setUrlStrategy(PathUrlStrategy());
  await initializeDateFormatting('ko_KR', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? user = await FirebaseAuth.instance.authStateChanges().first;
  if (user != null) {
    await getMyInfo(user.uid);
    isLogin = true;
  } else {
    isLogin = false;
  }
  // if(FirebaseAuth.instance.currentUser != null){
  //   await getMyInfo(FirebaseAuth.instance.currentUser!.uid);
  //   isLogin = true;
  // }
  // else{
  //   isLogin = false;
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController(), fenix: true);
        Get.lazyPut(() => MainController(), fenix: true);
        Get.lazyPut(() => SpotManagementController(), fenix: true);
        Get.lazyPut(() => VisitRecordController(), fenix: true);
        Get.lazyPut(() => UserManagementController(), fenix: true);
        // Get.putAsync<VisitRecordController>(() async => VisitRecordController().init());
        // Get.put(() => UserManagementController());
        Get.lazyPut(() => MembershipManagementController(), fenix: true);
        Get.lazyPut(() => StaffManagementController(), fenix: true);
      }),
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
      initialRoute: isLogin ? '/mainPage' : '/signIn',
      getPages: [
        GetPage(name: '/signIn', page: () => const Login()),
        GetPage(name: '/mainPage', page: () => const MainPage(),
            // bindings: [
            //   BindingsBuilder(() =>
            //   [
            //     Get.putAsync(() async => UserManagementController()),
            //   ]),
            // ]
        ),
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