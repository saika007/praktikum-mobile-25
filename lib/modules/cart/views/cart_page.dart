import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../../../data/services/purchase_history_service.dart';


class CartPage extends StatelessWidget {
  CartPage({super.key});
  final cart = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Obx(() {
        if (cart.cartItems.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...cart.cartItems.map((item) => Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      "Qty: ${item.quantity} | \$${(item.price * item.quantity).toStringAsFixed(2)}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cart.decreaseQty(item.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => cart.removeFromCart(item.id),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            Text(
              "Total: \$${cart.totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final historyService = PurchaseHistoryService();
                const userId = "demoUser"; // Replace with FirebaseAuth

                await historyService.savePurchase(
                  cart.cartItems,
                  cart.totalPrice,
                  userId,
                );

                Get.snackbar("Success", "Purchase saved!");
                cart.clearCart();
              },
              child: const Text("Checkout"),
            ),
          ],
        );
      }),
    );
  }
}
