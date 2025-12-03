import 'package:hive/hive.dart';
import 'coffee.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  final Coffee coffee;

  @HiveField(1)
  int quantity;

  CartItem({
    required this.coffee,
    required this.quantity,
  });

  String get id => coffee.id;
  String get name => coffee.name;
  double get price => coffee.price;
}
