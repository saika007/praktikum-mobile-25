import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  /// Ensure location permission is granted (foreground).
  Future<bool> ensurePermission() async {
    // First check permission via permission_handler
    var status = await Permission.location.status;
    if (status.isGranted) return true;

    // request
    final result = await Permission.location.request();
    if (result.isGranted) return true;

    // If permanently denied, return false (UI can show openAppSettings)
    return false;
  }

  Future<Position?> getCurrentPosition({bool useGps = false}) async {
    final ok = await ensurePermission();
    if (!ok) return null;

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: useGps ? LocationAccuracy.high : LocationAccuracy.low,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      // fallback to last known
      try {
        return await Geolocator.getLastKnownPosition();
      } catch (_) {
        return null;
      }
    }
  }

  Stream<Position> getPositionStream({bool useGps = false, int distanceFilter = 5}) {
    final settings = LocationSettings(
      accuracy: useGps ? LocationAccuracy.high : LocationAccuracy.low,
      distanceFilter: distanceFilter,
    );
    return Geolocator.getPositionStream(locationSettings: settings);
  }

  Future<Position?> getLastKnownPosition() => Geolocator.getLastKnownPosition();
}
