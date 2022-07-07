import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gpx/gpx.dart';
import 'package:latlong2/latlong.dart';

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

double overallDistance(String xmlFile) {
  var distance = const Distance();
  var xmlGpx = GpxReader().fromString(xmlFile);
  List<LatLng> waypoints = [];
  for (var trk in xmlGpx.trks) {
    for (var trkseg in trk.trksegs) {
      for (var wpt in trkseg.trkpts) {
        waypoints.add(LatLng(wpt.lat ?? 0, wpt.lon ?? 0));
      }
    }
  }

  double result = 0;
  for (int i = 1; i < waypoints.length; i++) {
    result += distance.as(LengthUnit.Meter, waypoints[i - 1], waypoints[i]);
  }

  return result / 1000;
}

List<Marker> extractMarkers(String xmlFile, BuildContext context) {
  var xmlGpx = GpxReader().fromString(xmlFile);
  List<Marker> markers = [];
  for (var wpt in xmlGpx.wpts) {
    markers.add(
      Marker(
        width: 60.0,
        height: 60.0,
        point: LatLng(wpt.lat ?? 0, wpt.lon ?? 0),
        builder: (ctx) => GestureDetector(
          child: const Icon(Icons.restaurant),
          onTap: () => _displayPointInfo(context, wpt),
        ),
      ),
    );
  }
  return markers;
}

Future<void> _displayPointInfo(BuildContext context, Wpt wpt) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(wpt.name!),
        content: SingleChildScrollView(
          child: Text(wpt.desc!),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
