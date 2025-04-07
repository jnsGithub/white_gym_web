import 'package:get/get.dart';
import 'package:white_gym_web/app/modules/main/views/main_page.dart';
import 'package:white_gym_web/app/modules/membership/bindings/membership_binding.dart';
import 'package:white_gym_web/app/modules/membership/views/membership_management_page.dart';
import 'package:white_gym_web/app/modules/sign/find_password/bindings/find_password_binding.dart';
import 'package:white_gym_web/app/modules/sign/find_password/views/find_password_page.dart';
import 'package:white_gym_web/app/modules/sign/sign_in/bindings/sign_in_binding.dart';
import 'package:white_gym_web/app/modules/sign/sign_in/views/sign_in_page.dart';
import 'package:white_gym_web/app/modules/sign/sign_up/bindings/sign_up_binding.dart';
import 'package:white_gym_web/app/modules/sign/sign_up/views/sing_up_page.dart';
import 'package:white_gym_web/app/modules/spot/bindings/spot_binding.dart';
import 'package:white_gym_web/app/modules/spot/views/spot_management_page.dart';
import 'package:white_gym_web/app/modules/staff/bindings/staff_binding.dart';
import 'package:white_gym_web/app/modules/staff/views/staff_management_page.dart';
import 'package:white_gym_web/app/modules/user/bindings/user_binding.dart';
import 'package:white_gym_web/app/modules/user/views/user_management_page.dart';
import 'package:white_gym_web/app/modules/visit_record/bindings/visit_record_binding.dart';
import 'package:white_gym_web/app/modules/visit_record/views/visit_record_page.dart';
import 'package:white_gym_web/app/routes/app_routes.dart';

final Transition transition = Transition.noTransition;

class AppPages{
  static final routes = [
    GetPage(
      name: Routes.SIGN_IN_PAGE,
      page: () => const SignInPage(),
      binding: SignInBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.SIGN_UP_PAGE,
      page:()=> const SignUpPage(),
      binding: SignUpBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.FIND_PW_PAGE,
      page: () => const FindPasswordPage(),
      binding: FindPasswordBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.MAIN_HOME_PAGE,
      page: () => const MainPage(child: VisitRecordPage()),
      binding: VisitRecordBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.STAFF_PAGE,
      page: () =>  const MainPage(child: StaffManagementPage()),
      binding: StaffBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.USER_PAGE,
      page:  () => const MainPage(child: UserManagementPage()),
      binding: UserBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.SPOT_PAGE,
      page:  () => const MainPage(child: SpotManagementPage()),
      binding: SpotBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.MEMBERSHIP_PAGE,
      page: () => const MainPage(child: MembershipManagementPage()),
      binding: MembershipBinding(),
      transition: transition,
    ),
  ];
}