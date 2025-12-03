import 'package:hive/hive.dart';
import '../models/coffee.dart';

class LocalCoffeeRepository {
  final Box<Coffee> box = Hive.box<Coffee>('coffees');

  List<Coffee> getCoffees() {
    return box.values.toList();
  }

  Coffee? getCoffeeById(String id) {
    try {
      return box.values.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addCoffee(Coffee coffee) async {
    await box.put(coffee.id, coffee);
  }

  Future<void> deleteCoffee(String id) async {
    await box.delete(id);
  }

  Future<void> clearCoffee() async {
    await box.clear();
  }

  Future<void> seedInitialData() async {
  if (box.isNotEmpty) return;

  await addCoffee(Coffee(id: '1', name: 'Espresso', price: 3.00));
  await addCoffee(Coffee(id: '2', name: 'Latte', price: 4.50));
  await addCoffee(Coffee(id: '3', name: 'Cappuccino', price: 4.00));
  }

}
