import 'package:get/get.dart';
import 'package:to_do_list_app/bindings/auth_binding.dart';
import 'package:to_do_list_app/bindings/dashboard_binding.dart';
import 'package:to_do_list_app/bindings/splash_binding.dart';
import 'package:to_do_list_app/pages/add_page.dart';
import 'package:to_do_list_app/pages/dashboard_page.dart';
import 'package:to_do_list_app/pages/login_page.dart';
import 'package:to_do_list_app/pages/profile_page.dart';
import 'package:to_do_list_app/pages/splashscreen_page.dart';
import 'package:to_do_list_app/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoute.loginPage,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoute.dashboardPage,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoute.addPage,
      page: () => AddPage(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: AppRoute.splashPage,
      page: () => SplashscreenPage(),
      binding: SplashBinding()
    ),
    GetPage(name: AppRoute.profilePage, page: () => ProfilePage()),
  ];
}
