import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/menupage_controller.dart';

class MenuPage extends StatelessWidget {
  final controller = Get.put(MenuPageController());

  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Coffee Menu")),
      body: Obx(() {
        if (controller.coffees.isEmpty) {
          return Center(child: Text("No coffees found"));
        }

        return ListView.builder(
          itemCount: controller.coffees.length,
          itemBuilder: (context, index) {
            final coffee = controller.coffees[index];
            return ListTile(
              title: Text(coffee.name),
              trailing: Text("\$${coffee.price.toStringAsFixed(2)}"),
            );
          },
        );
      }),
    );
  }
}
