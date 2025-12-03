import 'package:get/get.dart';
import '../controllers/gps_location_controller.dart';
import '../../../data/services/location_services.dart';

class GpsLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<GpsLocationController>(() => GpsLocationController());
  }
}
