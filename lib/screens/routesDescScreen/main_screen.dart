import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';

import '../../sharedWidgets/model_desc_card.dart';

class RoutesDescPage extends StatefulWidget {
  const RoutesDescPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoutesDescPageState();
}

class RoutesDescPageState extends State<RoutesDescPage> {
  final routesController = Get.put(RoutesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: routesController.get(Get.arguments[0]),
          builder: (context, AsyncSnapshot<RouteModel?> snapshot) {
            Widget mapWidget = !snapshot.hasData
                ? const CircularProgressIndicator(
                    semanticsLabel: 'Loading...',
                  )
                : LiveLocationPage(snapshot.data!);
            return mapWidget;
          },
        ),
      ),
    );
  }
}
