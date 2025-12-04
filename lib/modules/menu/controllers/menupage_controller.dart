import 'package:get/get.dart';
import '../../../data/models/coffee.dart';
import '../../../data/repositories/local_coffee_repository.dart';
import 'package:flutter/material.dart';


class MenuPageController extends GetxController {
  final LocalCoffeeRepository repo = LocalCoffeeRepository();

  var coffees = <Coffee>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCoffees();
  }

  Future<void> loadCoffees() async {
    await repo.seedInitialData();
    coffees.value = repo.getCoffees();
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
}
