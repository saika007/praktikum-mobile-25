import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  /// The bottom sheet UI that used to be in MenuPage
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
      appBar: AppBar(title: const Text("Home")),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Get.toNamed('/menu'),
            child: const Text("Go to Menu"),
          ),
          const SizedBox(height: 20),

          // 🔥 Added location button here
          ElevatedButton.icon(
            onPressed: showLocationDialog,
            icon: const Icon(Icons.location_on),
            label: const Text("Dimana saya?"),
          ),
        ],
      ),
    );
  }
}
