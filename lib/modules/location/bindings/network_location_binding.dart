import 'package:get/get.dart';
import '../controllers/network_location_controller.dart';
import '../../../data/services/location_services.dart';

class NetworkLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<NetworkLocationController>(() => NetworkLocationController());
  }
}
