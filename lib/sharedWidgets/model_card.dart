import 'package:flutter/material.dart';
import 'package:taurist/data/route_model.dart';

Widget getModelCardWidget(RouteModel model) {
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
            child: Icon(
              color: Color.fromRGBO(44, 83, 72, 1),
              Icons.bike_scooter,
              size: 36,
            ),
          ),
          Flexible(
            flex: 2,
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
            flex: 0,
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
        ],
      ),
    ),
  );
}
