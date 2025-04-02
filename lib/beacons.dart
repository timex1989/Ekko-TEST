import 'dart:developer';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void addBeaconModel(MapboxMap mapboxMap) async {
  final modelUri = "asset://assets/models/street_beacon.glb"; // Path to your beacon model
  
  // Load the 3D model on the map
  await mapboxMap.addModel(
    modelUri: modelUri, // Path to your GLB model file
    modelPosition: Point(coordinates: Position(-96.7970, 32.7767)), // Example latitude/longitude (Dallas, TX)
    modelScale: [2.0, 2.0, 2.0], // Scale the model (optional)
    modelRotation: [0.0, 0.0, 0.0], // Rotation angles (optional)
  );
}

class BeaconManager {
  final MapboxMap mapboxMap;

  BeaconManager(this.mapboxMap);

  void addBeacon() {
    // Add the beacon model to the map when the map is created
    addBeaconModel(mapboxMap);
  }
}
