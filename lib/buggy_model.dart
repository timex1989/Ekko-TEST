import 'dart:convert';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

Future<void> addBuggyModel(MapboxMap mapboxMap) async {
  final modelPosition = Position(-96.7970, 32.7767); // Dallas coordinates
  final point = Point(coordinates: modelPosition);

  const modelId = "model-buggy";
  const modelUri = "https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/Buggy/glTF-Binary/Buggy.glb";

  await mapboxMap.style.addStyleModel(modelId, modelUri);

  await mapboxMap.style.addSource(
    GeoJsonSource(id: "buggy-source", data: json.encode(point)),
  );

  final modelLayer = ModelLayer(id: "buggy-layer", sourceId: "buggy-source");
  modelLayer.modelId = modelId;
  modelLayer.modelScale = [0.2, 0.2, 0.2];
  modelLayer.modelRotation = [0, 0, 0];
  modelLayer.modelType = ModelType.COMMON_3D;

  await mapboxMap.style.addLayer(modelLayer);
}
