import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'data/services/hive_services.dart';
import 'data/repositories/coffee_repository.dart';
import 'data/repositories/cart_repository.dart';
import 'modules/cart/controllers/cart_controller.dart';
import 'routes/app_pages.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();
  await Firebase.initializeApp();

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
