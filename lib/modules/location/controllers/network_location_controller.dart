import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';

class NetworkLocationController extends GetxController {
  var position = Rx<Position?>(null);
  var isTracking = false.obs;
  var accuracyMode = "Network (Coarse)".obs;

  final mapController = MapController();
  StreamSubscription<Position>? _sub;

  Future<bool> ensurePermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;

    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied) return false;
    }
    if (perm == LocationPermission.deniedForever) return false;
    return true;
  }

  @override
  Future<void> refresh() async {
    if (!await ensurePermission()) return;

    final p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    accuracyMode.value = "Network (Coarse)";
    position.value = p;
  }

  Future<void> startTracking() async {
    if (!await ensurePermission()) return;
    isTracking.value = true;
    accuracyMode.value = "Network Live";

    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 10,
      ),
    ).listen((p) => position.value = p);
  }

  void stopTracking() {
    isTracking.value = false;
    _sub?.cancel();
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
