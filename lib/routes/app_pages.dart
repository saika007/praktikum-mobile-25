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

// COFFEE DETAILS MODULE
import '../modules/coffee_details/views/coffee_details_page.dart';
import '../modules/coffee_details/bindings/coffee_details_binding.dart';

// GPS LOCATION MODULE
import '../modules/location/views/gps_location_page.dart';
import '../modules/location/bindings/gps_location_binding.dart';

// NETWORK LOCATION MODULE
import '../modules/location/views/network_location_page.dart';
import '../modules/location/bindings/network_location_binding.dart';

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
    GetPage(name: Routes.menu, page: () => MenuPage(), binding: MenuBinding()),

    // COFFEE DETAILS
    GetPage(
      name: Routes.coffeeDetails,
      page: () => CoffeeDetailsPage(),
      binding: CoffeeDetailsBinding(),
    ),

    GetPage(
      name: Routes.gpsLocation,
      page: () => const GpsLocationPage(),
      binding: GpsLocationBinding(),
    ),

    GetPage(
      name: Routes.networkLocation,
      page: () => const NetworkLocationPage(),
      binding: NetworkLocationBinding(),
    ),
  ];
}
