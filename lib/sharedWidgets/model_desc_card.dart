import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';
import 'package:taurist/helpers/gpx_file_handler.dart';

class LiveLocationPage extends StatefulWidget {
  final RouteModel model;

  const LiveLocationPage(this.model, {Key? key}) : super(key: key);

  @override
  LiveLocationPageState createState() => LiveLocationPageState();
}

class LiveLocationPageState extends State<LiveLocationPage> {
  final Location _locationService = Location();
  LocationData? _locationData;
  late final MapController _mapController;

  // bool _liveUpdate = false;

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  /// uncomment if better scrollView experience is required
  // var interActiveFlags = InteractiveFlag.all - InteractiveFlag.drag;
  var interActiveFlags = InteractiveFlag.all;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
    LocationData? location;

    _serviceEnabled = await _locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationService.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    location = await _locationService.getLocation();
    _locationData = location;
    _locationService.onLocationChanged.listen(
          (LocationData result) async {
        if (mounted) {
          setState(
                () {
              _locationData = result;
              // if (_liveUpdate) {
              //   _mapController.move(
              //       LatLng(_currentLocation!.latitude!,
              //           _currentLocation!.longitude!),
              //       _mapController.zoom);
              // }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final routesController = Get.put(RoutesController());

    LatLng currentLatLng;

    if (_locationData != null) {
      currentLatLng =
          LatLng(_locationData!.latitude!, _locationData!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    var locationMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: currentLatLng,
      builder: (ctx) => const Icon(
        Icons.circle,
        color: Colors.red,
      ),
    );

    return FutureBuilder(
      future: routesController.getGpxMap(widget.model.xmlFileId),
      builder: (context, AsyncSnapshot<String> snapshot) {
        return !snapshot.hasData
            ? const CircularProgressIndicator(
          semanticsLabel: 'Loading...',
          color: Color.fromRGBO(44, 83, 72, 1),
        )
            : FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: extractWaypoints(snapshot.data!).first,
            zoom: 17.0,
            minZoom: 1.5,
            maxZoom: 18.0,
            interactiveFlags: interActiveFlags,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],

              /// worse performance, but better maps
              /// retinaMode: true,
              /// maxZoom: 22,
              tilesContainerBuilder:
              Get.isDarkMode ? darkModeTilesContainerBuilder : null,
            ),
            PolylineLayerOptions(
              polylines: [
                Polyline(
                  points: extractWaypoints(snapshot.data!),
                  strokeWidth: 3.5,
                  color: Colors.purpleAccent,
                ),
              ],
            ),
            MarkerLayerOptions(
              markers: [
                ...extractMarkers(snapshot.data!, context),
                locationMarker,
              ],
              rotate: true,
            ),
          ],
        );
      },
    );
  }
}
