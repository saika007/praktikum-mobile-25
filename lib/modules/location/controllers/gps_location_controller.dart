import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../data/services/gps_location_services.dart';

class GpsLocationController extends GetxController {
  final service = LocationService();

  Rxn<Position> position = Rxn<Position>();
  RxBool tracking = false.obs;

  final mapController = MapController();
  StreamSubscription<Position>? sub;

  Future<void> refreshLocation() async {
    if (await service.ensurePermission()) {
      position.value = await service.getCurrent();
      _moveToMarker();
    }
  }

  void startTracking() async {
    if (await service.ensurePermission()) {
      tracking.value = true;
      sub = service.stream().listen((p) {
        position.value = p;
        _moveToMarker();
      });
    }
  }

  void stopTracking() {
    tracking.value = false;
    sub?.cancel();
  }

  void _moveToMarker() {
    if (position.value != null) {
      mapController.move(
        LatLng(position.value!.latitude, position.value!.longitude),
        16,
      );
    }
  }

  @override
  void onClose() {
    sub?.cancel();
    super.onClose();
  }
}
