import 'package:hive/hive.dart';
import '../models/cart_item.dart';

class CartRepository {
  final Box<CartItem> box = Hive.box<CartItem>('cart');

  List<CartItem> loadCart() {
    return box.values.toList();
  }

  Future<void> saveCart(List<CartItem> items) async {
    await box.clear();
    await box.addAll(items);
  }

  Future<void> clearCart() async {
    await box.clear();
  }
}
