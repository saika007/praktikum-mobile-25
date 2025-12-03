import 'package:hive/hive.dart';

part 'coffee.g.dart';

@HiveType(typeId: 0)
class Coffee {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  Coffee({
    required this.id,
    required this.name,
    required this.price,
  });
}
