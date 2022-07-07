import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by 'flutter_map.dart'
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart'; // Recommended for most use-cases
import 'package:taurist/helpers/gpx_file_handler.dart';

class LiveLocationPage extends StatefulWidget {
  final RouteModel model;

  const LiveLocationPage(this.model, {Key? key}) : super(key: key);

  @override
  LiveLocationPageState createState() => LiveLocationPageState();
}

class LiveLocationPageState extends State<LiveLocationPage> {
  LocationData? _currentLocation;
  late final MapController _mapController;

  bool _permission = false;

  var interActiveFlags = InteractiveFlag.all;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        var permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged.listen(
            (LocationData result) async {
              if (mounted) {
                setState(
                  () {
                    _currentLocation = result;
                    _mapController.move(
                        LatLng(_currentLocation!.latitude!,
                            _currentLocation!.longitude!),
                        _mapController.zoom);
                  },
                );
              }
            },
          );
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final routesController = Get.put(RoutesController());

    LatLng currentLatLng;

    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
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
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    // worse performance, but better maps
                    // retinaMode: true,
                    // maxZoom: 22,
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
                // nonRotatedChildren: [
                //   AttributionWidget.defaultWidget(
                //     source: 'OpenStreetMap contributors',
                //     onSourceTapped: null,
                //   ),
                // ],
              );
      },
    );
  }
}