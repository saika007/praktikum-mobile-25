import 'package:hive/hive.dart';
import 'cart_item.dart';

part 'purchase_history.g.dart';

@HiveType(typeId: 2)
class PurchaseHistory {
  @HiveField(0)
  final List<CartItem> items;

  @HiveField(1)
  final double total;

  @HiveField(2)
  final DateTime date;

  PurchaseHistory({
    required this.items,
    required this.total,
    required this.date,
  });
}
