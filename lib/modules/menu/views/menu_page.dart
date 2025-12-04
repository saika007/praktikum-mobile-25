import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/menupage_controller.dart';
import '../animations/menu_animations.dart';
import 'widgets/coffee_tile.dart';
import '../../cart/views/cart_page.dart';
import '../../purchase_history/views/purchase_history_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(MenuPageController());
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = MenuAnimations.createController(this);
    animController.forward();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  void showLocationDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.gps_fixed),
              title: const Text("GPS (Akurasi Tinggi)"),
              onTap: () {
                Get.back();
                Get.toNamed('/gps-location');
              },
            ),
            ListTile(
              leading: const Icon(Icons.wifi),
              title: const Text("Network (Akurasi Rendah)"),
              onTap: () {
                Get.back();
                Get.toNamed('/network-location');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coffee Menu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Get.to(() => PurchaseHistoryPage()),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.to(() => CartPage()),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.coffees.isEmpty) {
          return const Center(child: Text("No coffees found"));
        }

        return FadeTransition(
          opacity: MenuAnimations.fade(animController),
          child: SlideTransition(
            position: MenuAnimations.slide(animController),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.coffees.length,
              itemBuilder: (_, i) => CoffeeTile(coffee: controller.coffees[i]),
            ),
          ),
        );
      }),
    );
  }
}
