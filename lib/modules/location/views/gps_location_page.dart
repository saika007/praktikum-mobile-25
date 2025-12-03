import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

import '../controllers/gps_location_controller.dart';

class GpsLocationPage extends StatelessWidget {
  GpsLocationPage({super.key});
  final ctrl = Get.put(GpsLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GPS Location")),
      body: Column(
        children: [
          // ================= MAP =================
          Expanded(
            child: Obx(() {
              final pos = ctrl.position.value;
              final center = pos == null
                  ? LatLng(-6.2, 106.8)
                  : LatLng(pos.latitude, pos.longitude);

              return FlutterMap(
                mapController: ctrl.mapController,
                options: MapOptions(center: center, zoom: 14),
                children: [
                  TileLayer(
                    // OpenStreetMap official tile server
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",

                    // REQUIRED BY POLICY
                    userAgentPackageName: 'com.example.cafedelicia',
                  ),

                  if (pos != null)
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

          // ============= ATTRIBUTION (MANDATORY) ============
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              "© OpenStreetMap contributors",
              style: TextStyle(fontSize: 12),
            ),
          ),

          // ================= INFO PANEL =================
          Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(() {
              final p = ctrl.position.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: p == null
                          ? const Text("No GPS yet")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Provider: GPS"),
                                Text(
                                  "Latitude:  ${p.latitude.toStringAsFixed(6)}",
                                ),
                                Text(
                                  "Longitude: ${p.longitude.toStringAsFixed(6)}",
                                ),
                                Text("Accuracy: ${p.accuracy} m"),
                                Text("Altitude: ${p.altitude} m"),
                                Text("Speed: ${p.speed} m/s"),
                                Text(
                                  "Timestamp: ${DateFormat('yMd Hms').format(p.timestamp)}",
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: ctrl.refreshLocation,
                        icon: const Icon(Icons.refresh),
                        label: const Text("Refresh"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          ctrl.tracking.value
                              ? ctrl.stopTracking()
                              : ctrl.startTracking();
                        },
                        icon: Icon(
                          ctrl.tracking.value ? Icons.stop : Icons.play_arrow,
                        ),
                        label: Text(
                          ctrl.tracking.value ? "Stop Live" : "Live GPS",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ctrl.tracking.value
                              ? Colors.red
                              : null,
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
