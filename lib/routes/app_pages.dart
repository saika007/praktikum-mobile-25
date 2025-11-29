import 'package:get/get.dart';

// AUTH MODULE
import '../modules/auth/views/auth_page.dart';
import '../modules/auth/bindings/auth_binding.dart';

// HOME MODULE
import '../modules/home/views/home_page.dart';
import '../modules/home/bindings/home_binding.dart';

// MENU MODULE
import '../modules/menu/views/menu_page.dart';
import '../modules/menu/bindings/menu_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [

    // LOGIN
    GetPage(
      name: Routes.login,
      page: () => const AuthPage(),
      binding: AuthBinding(),
    ),

    // HOME
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

    // MENU
    GetPage(
      name: Routes.menu,
      page: () => MenuPage(),
      binding: MenuBinding(),
    ),
  ];
}
