import 'package:get/get.dart';
import '../../../data/models/coffee.dart';
import '../../../data/repositories/local_coffee_repository.dart';

class CoffeeDetailsController extends GetxController {
  final String coffeeId;

  CoffeeDetailsController(this.coffeeId);

  var description = "".obs;
  var isLoading = true.obs;
  var error = "".obs;

  final LocalCoffeeRepository repo = LocalCoffeeRepository();

  @override
  void onInit() {
    super.onInit();
    loadFromHive();
  }

  void loadFromHive() {
    try {
      isLoading.value = true;

      Coffee? coffee = repo.getCoffeeById(coffeeId);

      if (coffee == null) {
        error.value = "Coffee not found";
        return;
      }

      description.value = coffee.description;
    } catch (e) {
      error.value = "Hive read error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
