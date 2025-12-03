import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import '../controllers/gps_location_controller.dart';

class GpsLocationPage extends StatelessWidget {
  const GpsLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GpsLocationController>();

    return Scaffold(
      appBar: AppBar(title: const Text('GPS Location')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final p = ctrl.position.value;
              final center = p == null
                  ? LatLng(-6.2, 106.8)
                  : LatLng(p.latitude, p.longitude);

              return FlutterMap(
                mapController: ctrl.mapController,
                options: MapOptions(center: center, zoom: 15),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  if (p != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: center,
                          width: 48,
                          height: 48,
                          builder: (_) => const Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }),
          ),

          const Text(
            "© OpenStreetMap contributors",
            style: TextStyle(fontSize: 11),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(() {
              final p = ctrl.position.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: p == null
                          ? const Text("No GPS data yet.")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Provider: GPS"),
                                Text("Accuracy Mode: ${ctrl.accuracyMode.value}"),
                                Text("Latitude: ${p.latitude.toStringAsFixed(6)}"),
                                Text("Longitude: ${p.longitude.toStringAsFixed(6)}"),
                                Text("Altitude: ${p.altitude} m"),
                                Text("Speed: ${p.speed} m/s"),
                                Text("Accuracy: ${p.accuracy} m"),
                                Text("Timestamp: ${DateFormat.yMd().add_jms().format(p.timestamp)}"),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: ctrl.refresh,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh'),
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => ElevatedButton.icon(
                          onPressed: ctrl.isTracking.value
                              ? ctrl.stopTracking
                              : ctrl.startTracking,
                          icon: Icon(
                            ctrl.isTracking.value ? Icons.stop : Icons.play_arrow,
                          ),
                          label: Text(ctrl.isTracking.value ? 'Stop' : 'Live'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
