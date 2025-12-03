import 'package:get/get.dart';
import 'package:dio/dio.dart';

class CoffeeDetailsController extends GetxController {
  final String coffeeId;

  CoffeeDetailsController(this.coffeeId);

  var description = "".obs;
  var isLoading = true.obs;
  var error = "".obs;

  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchDescription();
  }

  Future<void> fetchDescription() async {
    try {
      isLoading.value = true;

      final response = await dio.get(
        "https://firestore.googleapis.com/v1/projects/coffee-delicia-2bb22/databases/(default)/documents/menu/beverages/coffees/$coffeeId",
      );

      description.value = response.data["fields"]["description"]["stringValue"] ?? "No description.";
    } catch (e) {
      error.value = "Failed to load description: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
