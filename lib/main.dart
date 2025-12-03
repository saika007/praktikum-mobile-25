import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'data/models/coffee.dart';
import 'data/models/cart_item.dart';
import 'data/repositories/coffee_repository.dart';
import 'data/repositories/cart_repository.dart';
import 'modules/cart/controllers/cart_controller.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(CoffeeAdapter());
  Hive.registerAdapter(CartItemAdapter());

  await Hive.openBox<Coffee>('coffees');
  await Hive.openBox<CartItem>('cart');

  Get.put(CoffeeRepository());
  Get.put(CartRepository());

  // Controllers
  Get.put(CartController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
