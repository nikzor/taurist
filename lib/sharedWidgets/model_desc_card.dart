import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by 'flutter_map.dart'
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:taurist/data/route_model.dart'; // Recommended for most use-cases
import 'package:gpx/gpx.dart';

import 'package:taurist/controllers/routes_controller.dart';

List<LatLng> extractWaypoints(String xmlFile) {
  var xmlGpx = GpxReader().fromString(xmlFile);
  List<LatLng> waypoints = [];
  for (var trk in xmlGpx.trks) {
    for (var trkseg in trk.trksegs) {
      for (var wpt in trkseg.trkpts) {
        waypoints.add(LatLng(wpt.lat ?? 0, wpt.lon ?? 0));
      }
    }
  }
  return waypoints;
}

Widget getModelDescCardWidget(RouteModel model) {
  final routesController = Get.put(RoutesController());

  return FutureBuilder(
    future: routesController.getGpxMap(model.xmlFileId),
    builder: (context, AsyncSnapshot<String>snapshot) {
      return !snapshot.hasData ? const CircularProgressIndicator(
        semanticsLabel: 'Loading...',
      ) : FlutterMap(
        options: MapOptions(
          center: extractWaypoints(snapshot.data!).first,
          zoom: 17.0,
          minZoom: 1.5,
          maxZoom: 18.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayerOptions(
            polylines: [
              Polyline(
                points: extractWaypoints(snapshot.data!),
                //     <LatLng>[
                //   LatLng(0, -0),
                //   LatLng(53.3498, -6.2603),
                //   LatLng(48.8566, 2.3522),
                // ],
                strokeWidth: 4.0,
                color: Colors.purple,
              ),
            ],
          ),
        ],
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
      );
    },
  );
}
