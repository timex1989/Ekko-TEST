import 'dart:developer';
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
  // 🔴 We use the class-level lightPreset here
  String lightPreset = 'day'; 
  MapboxMap? mapboxMap;

  @override
  void _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.style;

    // Existing code follows
    var tapInteractionPOI = TapInteraction(StandardPOIs(), (feature, _) {
      mapboxMap.setFeatureStateForFeaturesetFeature(feature, StandardPOIsState(hide: true));
      log("POI feature name: ${feature.name}");
    }, radius: 10, stopPropagation: false);
    mapboxMap.addInteraction(tapInteractionPOI, interactionID: "tap_interaction_poi");

    var tapInteractionBuildings = TapInteraction(StandardBuildings(), (feature, _) {
      mapboxMap.setFeatureStateForFeaturesetFeature(feature, StandardBuildingsState(highlight: true));
      log("Building group: ${feature.group}");
    });
    mapboxMap.addInteraction(tapInteractionBuildings);

    var tapInteractionPlaceLabel = TapInteraction(StandardPlaceLabels(), (feature, _) {
      mapboxMap.setFeatureStateForFeaturesetFeature(feature, StandardPlaceLabelsState(select: true));
      log("Place label: ${feature.name}");
    });
    mapboxMap.addInteraction(tapInteractionPlaceLabel);

    var longTapInteraction = LongTapInteraction.onMap((context) {
      log("Long tap at: ${context.touchPosition.x}, ${context.touchPosition.y}");
      mapboxMap.resetFeatureStatesForFeatureset(StandardPOIs());
      mapboxMap.resetFeatureStatesForFeatureset(StandardBuildings());
      mapboxMap.resetFeatureStatesForFeatureset(StandardPlaceLabels());
    });
    mapboxMap.addInteraction(longTapInteraction);
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
          onMapCreated: _onMapCreated, // The method when map is created
        ),
      ]),
    );
  }
}
