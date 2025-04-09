import 'dart:developer';
import 'dart:convert'; // 🔴 ADDED FOR MODEL SUPPORT
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'lighting_helper.dart';  // 🔴 Ensure lighting_helper.dart is imported
import 'red_beacon.dart'; // 🔴 new import
import 'package:geolocator/geolocator.dart' as geo; // 🔴 FIX: add alias to avoid conflict

class StandardStyleInteractionsExample extends StatefulWidget {
  @override
  final Widget leading = const Icon(Icons.touch_app);
  @override
  final String title = 'Standard Style Interactions';
  @override
  final String? subtitle = 'Showcase of Standard Style interactions';

  const StandardStyleInteractionsExample({super.key});

  @override
  State<StatefulWidget> createState() => StandardStyleInteractionsState();
}

class StandardStyleInteractionsState extends State<StandardStyleInteractionsExample> {
  String lightPreset = 'day'; 
  MapboxMap? mapboxMap;

  final modelPosition = Position(-96.7970, 32.7767); // 🔴 Dallas test coordinate

  @override
  void _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    addRedBeaconModel(mapboxMap); // 🔴 Model now handled externally
    _moveCameraToUserLocation(); // 🔴 Move camera to actual device location

    mapboxMap.location.updateSettings(LocationComponentSettings( // 🔴 ENABLE LOCATION PUCK
      enabled: true,
      pulsingEnabled: true,
      layerAbove: 'road-label',
    ));
  }

  Future<void> _moveCameraToUserLocation() async { // 🔴 NEW METHOD
    bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled(); // 🔴 use geo prefix
    if (!serviceEnabled) {
      await geo.Geolocator.openLocationSettings(); // 🔴 use geo prefix
      return;
    }

    geo.LocationPermission permission = await geo.Geolocator.checkPermission(); // 🔴 use geo prefix
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission(); // 🔴 use geo prefix
      if (permission == geo.LocationPermission.deniedForever || permission == geo.LocationPermission.denied) {
        return;
      }
    }

    geo.Position position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high); // 🔴 use geo.Position

    await mapboxMap?.flyTo(
      CameraOptions(
        center: Point(coordinates: Position(position.longitude, position.latitude)),
        zoom: 16.5,         // 🔴 Zoom in closer for 3D
        pitch: 45.0,        // 🔴 Tilt camera to reveal 3D buildings
        bearing: 0.0,       // 🔴 Optional: top-down facing north
      ),
      MapAnimationOptions(duration: 3000), // 🔴 Smooth cinematic zoom-in
    );
  } // 🔴 ADDED: close the method properly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        MapWidget(
          key: ValueKey("mapWidget"),
          cameraOptions: CameraOptions(
            center: Point(coordinates: Position(-96.7970, 32.7767)), // 🔴 THIS IS OVERRIDDEN BY _moveCameraToUserLocation()
            bearing: 0.0,   // 🔴 Start facing north
            zoom: 5.0,      // 🔴 Start zoomed way out
            pitch: 0.0),    // 🔴 Start flat before tilting in
          styleUri: LightingHelper.getStyleUri(),
          textureView: true,
          onMapCreated: _onMapCreated,
        ),
      ]),
    );
  }
}
