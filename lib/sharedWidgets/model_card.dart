import 'package:flutter/material.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';

Widget getModelCardWidget(RouteModel model,
    {bool removable = false, RoutesController? controller}) {
  List<Widget> removeButton = [];
  if (removable) {
    removeButton.add(
      Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: GestureDetector(
          onTap: () {
            controller!.removeXml(model.xmlFileId);
            controller.remove(model);
          },
          child: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
  return Card(
    margin: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: const Icon(
              Icons.bike_scooter,
              color: Color.fromRGBO(44, 83, 72, 1),
              size: 36,
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              model.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${model.distance.toStringAsFixed(2)} km",
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  model.durationAsTimeString(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...removeButton,
        ],
      ),
    ),
  );
}
