import 'package:hive_flutter/hive_flutter.dart';

import '../models/coffee.dart';
import '../models/cart_item.dart';
import '../models/purchase_history.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // --- Register ALL adapters ---
    Hive.registerAdapter(CoffeeAdapter());
    Hive.registerAdapter(CartItemAdapter());
    Hive.registerAdapter(PurchaseHistoryAdapter());

    // --- Open ALL boxes ---
    await Hive.openBox<Coffee>('coffees');
    await Hive.openBox<CartItem>('cart');
    await Hive.openBox<PurchaseHistory>('purchase_history');
  }
}