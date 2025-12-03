import 'package:hive/hive.dart';
import '../models/coffee.dart';


class CoffeeRepository {
  final Box<Coffee> box = Hive.box<Coffee>('coffees');

  List<Coffee> getAllCoffees() => box.values.toList();

  Coffee? getCoffeeById(String id) {
  try {
    return box.values.firstWhere((c) => c.id == id);
  } catch (e) {
    return null;
  }
}
}
