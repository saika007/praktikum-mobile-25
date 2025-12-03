import 'package:get/get.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/coffee.dart';
import '../../../data/repositories/cart_repository.dart';

class CartController extends GetxController {
  final cartRepo = CartRepository();

  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    cartItems.value = cartRepo.loadCart();
    super.onInit();
  }

  // ADD ITEM
  void addToCart(Coffee coffee) {
    final index = cartItems.indexWhere((item) => item.coffee.id == coffee.id);

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(coffee: coffee, quantity: 1));
    }
    cartRepo.saveCart(cartItems);
  }

  // DECREASE QTY
  void decreaseQty(String coffeeId) {
    final index = cartItems.indexWhere((item) => item.id == coffeeId);

    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
      cartRepo.saveCart(cartItems);
    }
  }

  // REMOVE ITEM COMPLETELY
  void removeFromCart(String coffeeId) {
    cartItems.removeWhere((item) => item.id == coffeeId);
    cartRepo.saveCart(cartItems);
  }

  // CLEAR CART
  void clearCart() {
    cartItems.clear();
    cartRepo.clearCart();
  }

  // TOTAL price
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
}
