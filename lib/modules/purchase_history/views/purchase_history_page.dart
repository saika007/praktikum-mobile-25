import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/purchase_history_controller.dart';

class PurchaseHistoryPage extends StatelessWidget {
  final controller = Get.put(PurchaseHistoryController());

  @override
  Widget build(BuildContext context) {
    controller.loadHistory();

    return Scaffold(
      appBar: AppBar(title: const Text("Purchase History")),
      body: Obx(() {
        if (controller.history.isEmpty) {
          return const Center(child: Text("No purchase history yet."));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: controller.history.map((purchase) {
            return Card(
              child: ListTile(
                title: Text("Total: \$${purchase.total.toStringAsFixed(2)}"),
                subtitle: Text(
                  purchase.items
                      .map((e) => "${e.name} x${e.quantity}")
                      .join(", "),
                ),
                trailing: Text(
                  "${purchase.date.day}/${purchase.date.month}/${purchase.date.year}",
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
