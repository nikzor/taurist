import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';
import 'package:taurist/sharedWidgets/model_desc_card.dart';

class RoutesDescPage extends StatelessWidget {
  final routesController = Get.put(RoutesController());

  RoutesDescPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your route"),
        backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: routesController.get(Get.arguments[0]),
          builder: (context, AsyncSnapshot<RouteModel?> snapshot) {
            Widget mapWidget = !snapshot.hasData
                ? const SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Loading...',
                        color: Color.fromRGBO(44, 83, 72, 1),
                      ),
                    ),
                  )
                : LiveLocationPage(snapshot.data!);
            var titleText =
                !snapshot.hasData ? "Loading..." : snapshot.data!.title;
            var descriptionText =
                !snapshot.hasData ? "Loading..." : snapshot.data!.description;
            var durationText = !snapshot.hasData
                ? "Loading..."
                : snapshot.data!.durationAsTimeString();
            var distanceText =
                !snapshot.hasData ? "Loading..." : snapshot.data!.distance;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    width: Get.width,
                    child: Text(
                      "$titleText ($durationText - $distanceText km)",
                      style: const TextStyle(
                        fontSize: 26.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    width: Get.width,
                    child: Text(
                      descriptionText,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: SizedBox(
                        width: Get.width,
                        height: Get.width,
                        child: mapWidget,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
