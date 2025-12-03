import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/network_location_controller.dart';

class NetworkLocationPage extends StatelessWidget {
  NetworkLocationPage({super.key});

  final ctrl = Get.put(NetworkLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Network Location")),
      body: Column(
        children: [
          // ================= MAP =================
          Expanded(
            child: Obx(() {
              final pos = ctrl.position.value;
              final center = pos == null
                  ? LatLng(-6.2, 106.8) // fallback Jakarta
                  : LatLng(pos.latitude, pos.longitude);

              return FlutterMap(
                mapController: ctrl.mapController,
                options: MapOptions(
                  center: center,
                  zoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "com.example.cafedelicia",
                  ),
                  if (pos != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: center,
                          width: 50,
                          height: 50,
                          builder: (_) => const Icon(
                            Icons.location_on,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              "© OpenStreetMap contributors",
              style: TextStyle(fontSize: 12),
            ),
          ),

          // ================= INFO =================
          Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(() {
              final p = ctrl.position.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: ctrl.refreshNetworkLocation,
                    icon: const Icon(Icons.wifi_tethering),
                    label: const Text("Locate via Network"),
                  ),
                  const SizedBox(height: 10),

                  if (ctrl.loading.value)
                    const Center(child: CircularProgressIndicator()),

                  if (ctrl.status.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(ctrl.status.value),
                    ),

                  if (p != null)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Approx. Network Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text("Latitude:  ${p.latitude.toStringAsFixed(6)}"),
                            Text("Longitude: ${p.longitude.toStringAsFixed(6)}"),
                            Text("Accuracy:  ${p.accuracy} meters"),
                            Text("Timestamp: ${p.timestamp}"),
                            const SizedBox(height: 6),
                            const Text(
                              "Source: WiFi / Cellular / IP-based",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
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
