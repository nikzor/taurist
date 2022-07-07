import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';

import '../../sharedWidgets/model_desc_card.dart';

class RoutesDescPage extends StatelessWidget {
  final routesController = Get.put(RoutesController());

  RoutesDescPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: routesController.get(Get.arguments[0]),
          builder: (context, AsyncSnapshot<RouteModel?> snapshot) {
            Widget mapWidget = !snapshot.hasData
                ? const Center(child: CircularProgressIndicator(
              semanticsLabel: 'Loading...',
              color: Color.fromRGBO(44, 83, 72, 1),
            ),)
                : LiveLocationPage(snapshot.data!);
            return Center(child: mapWidget);
          },
        ),
      ),
    );
  }
}
