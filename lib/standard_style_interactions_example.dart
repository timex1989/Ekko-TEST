import 'dart:developer';
import 'dart:convert'; // 🔴 ADDED FOR MODEL SUPPORT
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'lighting_helper.dart';  // 🔴 Ensure lighting_helper.dart is imported

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
  }

  void _onStyleLoaded(StyleLoadedEventData data) async {
    if (mapboxMap == null) return;

    final point = Point(coordinates: modelPosition);

    const modelId = "model-buggy";
    const modelUri = "https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/Buggy/glTF-Binary/Buggy.glb";

    await mapboxMap!.style.addStyleModel(modelId, modelUri);

    await mapboxMap!.style.addSource(
      GeoJsonSource(id: "model-source", data: json.encode(point)),
    );

    final modelLayer = ModelLayer(id: "model-layer", sourceId: "model-source");
    modelLayer.modelId = modelId;
    modelLayer.modelScale = [0.15, 0.15, 0.15];
    modelLayer.modelRotation = [0, 0, 0];
    modelLayer.modelType = ModelType.COMMON_3D;

    await mapboxMap!.style.addLayer(modelLayer);
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
          onStyleLoadedListener: _onStyleLoaded, // 🔴 ADDED FOR MODEL SUPPORT
        ),
      ]),
    );
  }
}
