import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/coffee_details_controller.dart';

class CoffeeDetailsPage extends GetView<CoffeeDetailsController> {
  const CoffeeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Coffee Details")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(controller.description.value),
        );
      }),
    );
  }
}
