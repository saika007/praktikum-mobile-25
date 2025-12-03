import 'package:get/get.dart';
import '../controllers/coffee_details_controller.dart';

class CoffeeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final coffeeId = Get.arguments; // get passed ID
    Get.put(CoffeeDetailsController(coffeeId));
  }
}
