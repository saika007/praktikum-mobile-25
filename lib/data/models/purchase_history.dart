import 'package:hive/hive.dart';
import 'cart_item.dart';
import 'coffee.dart';

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

  // ---- Firebase Serialization ----
  Map<String, dynamic> toJson() => {
        "items": items.map((e) => {
              "id": e.id,
              "name": e.name,
              "price": e.price,
              "quantity": e.quantity,
            }).toList(),
        "total": total,
        "date": date.toIso8601String(),
      };

  factory PurchaseHistory.fromJson(Map<String, dynamic> json) {
    return PurchaseHistory(
      items: (json["items"] as List).map((e) {
        return CartItem(
          coffee: Coffee(
            id: e["id"],
            name: e["name"],
            price: e["price"].toDouble(),
            description: e["description"],
            imagePath: e["imagePath"],
          ),
          quantity: e["quantity"],
        );
      }).toList(),
      total: json["total"].toDouble(),
      date: DateTime.parse(json["date"]),
    );
  }
}
