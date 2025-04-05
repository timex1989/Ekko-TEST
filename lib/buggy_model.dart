import 'dart:convert';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

Future<void> addBuggyModel(MapboxMap mapboxMap) async {
  final modelPosition = Position(-96.7970, 32.7767); // Dallas coordinates
  final point = Point(coordinates: modelPosition);

  const modelId = "red-beacon-id";
  const modelUri = "https://github.com/timex1989/Ekko-TEST/raw/1f8f3cf3ac9fc05517d6788ae13a332647f2530e/assets/models/red_beacon/red_beacon.gltf";


  await mapboxMap.style.addStyleModel(modelId, modelUri);

  await mapboxMap.style.addSource(
    GeoJsonSource(id: "buggy-source", data: json.encode(point)),
  );

  final modelLayer = ModelLayer(id: "buggy-layer", sourceId: "buggy-source");
  modelLayer.modelId = modelId;
  modelLayer.modelScale = [50, 50, 50];
  modelLayer.modelRotation = [0, 0, 0];
  modelLayer.modelType = ModelType.COMMON_3D;

  await mapboxMap.style.addLayer(modelLayer);
}
