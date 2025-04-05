import 'dart:developer';
import 'dart:convert'; // 🔴 ADDED FOR MODEL SUPPORT
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'lighting_helper.dart';  // 🔴 Ensure lighting_helper.dart is imported
import 'red_beacon.dart'; // 🔴 new import

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        MapWidget(
          key: ValueKey("mapWidget"),
          cameraOptions: CameraOptions(
            center: Point(coordinates: Position(-96.7970, 32.7767)),
            bearing: 49.92,
            zoom: 16.35,
            pitch: 40),
          styleUri: LightingHelper.getStyleUri(),
          textureView: true,
          onMapCreated: _onMapCreated,
        ),
      ]),
    );
  }
}
