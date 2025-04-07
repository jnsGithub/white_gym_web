import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:white_gym_web/app/modules/sign/sign_in/bindings/sign_in_binding.dart';
import 'package:white_gym_web/app/modules/visit_record/bindings/visit_record_binding.dart';
import 'package:white_gym_web/app/routes/app_pages.dart';
import 'package:white_gym_web/app/routes/app_routes.dart';
import 'package:white_gym_web/app/theme/app_theme.dart';
import 'global/global.dart';
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
  }
  else {
    isLogin = false;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: isLogin ? VisitRecordBinding() : SignInBinding(),
      scrollBehavior: MyCustomScrollBehavior(),
      locale: const Locale('ko', 'KR'),
      color: Colors.white,
      theme: appTheme,
      initialRoute: isLogin ? Routes.MAIN_HOME_PAGE : Routes.SIGN_IN_PAGE,
      getPages: AppPages.routes
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