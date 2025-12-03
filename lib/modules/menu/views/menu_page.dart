import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/menupage_controller.dart';
import '../animations/menu_animations.dart';
import 'widgets/coffee_tile.dart';
import '../../cart/views/cart_page.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coffee Menu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.to(() => CartPage()),
          ),
        ],
      ),

      /// Main Section For Coffee Items
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
              itemBuilder: (_, i) =>
                  CoffeeTile(coffee: controller.coffees[i]),
            ),
          ),
        );
      }),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.showLocationDialog,
        icon: const Icon(Icons.location_on),
        label: const Text("Dimana saya?"),
      ),
    );
  }
}
