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

  @HiveField(3)
  final String imagePath;

  @HiveField(4)
  final String description;

  Coffee({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
  });
}
