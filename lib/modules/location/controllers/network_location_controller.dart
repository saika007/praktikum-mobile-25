import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../data/services/network_location_services.dart';

class NetworkLocationController extends GetxController {
  final service = NetworkService();

  Rxn<Position> position = Rxn<Position>();
  RxBool loading = false.obs;
  RxString status = "".obs;

  final mapController = MapController();

  Future<void> refreshNetworkLocation() async {
    loading.value = true;
    status.value = "";

    if (!await service.ensurePermission()) {
      status.value = "Permission not granted";
      loading.value = false;
      return;
    }

    try {
      position.value = await service.getNetworkPosition();
      _moveToMarker();
      status.value = "Network Location Found";
    } catch (e) {
      status.value = "Error: $e";
    }

    loading.value = false;
  }

  void _moveToMarker() {
    if (position.value != null) {
      mapController.move(
        LatLng(position.value!.latitude, position.value!.longitude),
        15,
      );
    }
  }
}
