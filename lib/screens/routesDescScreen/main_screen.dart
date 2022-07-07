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
                ? const Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Loading...',
                      color: Color.fromRGBO(44, 83, 72, 1),
                    ),
                  )
                : LiveLocationPage(snapshot.data!);
            var titleText =
                !snapshot.hasData ? "Loading..." : snapshot.data!.title;
            var descriptionText =
                !snapshot.hasData ? "Loading..." : snapshot.data!.description;
            var durationText =
                !snapshot.hasData ? "Loading..." : snapshot.data!.durationAsTimeString();
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
                  // Container(
                  //   padding: const EdgeInsets.only(top: 20, left: 10),
                  //   width: Get.width,
                  //   child: const Text(
                  //     "Route description",
                  //     style: TextStyle(
                  //       fontSize: 26.0,
                  //     ),
                  //     textAlign: TextAlign.start,
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  //   width: Get.width,
                  //   child: TextField(
                  //     controller: descriptionController,
                  //     textInputAction: TextInputAction.next,
                  //     minLines: 5,
                  //     maxLines: 5,
                  //     decoration: InputDecoration(
                  //       hintText: "Description",
                  //       hintStyle: const TextStyle(
                  //           color: Color.fromRGBO(189, 189, 189, 1),
                  //           fontSize: 16),
                  //       border: const OutlineInputBorder(
                  //           borderSide:
                  //           BorderSide(color: Color.fromRGBO(44, 83, 72, 1))),
                  //       suffixIcon: IconButton(
                  //         onPressed: descriptionController.clear,
                  //         icon: const Icon(
                  //           Icons.clear,
                  //           color: Color.fromRGBO(189, 189, 189, 1),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 20, left: 10),
                  //   width: Get.width,
                  //   child: const Text(
                  //     "Route duration",
                  //     style: TextStyle(
                  //       fontSize: 26.0,
                  //     ),
                  //     textAlign: TextAlign.start,
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //       top: 20, left: 10, right: 10, bottom: 20),
                  //   width: Get.width,
                  //   child: TextField(
                  //     controller: durationController,
                  //     textInputAction: TextInputAction.next,
                  //     minLines: 1,
                  //     maxLines: 1,
                  //     decoration: InputDecoration(
                  //       hintText: "In minutes",
                  //       hintStyle: const TextStyle(
                  //           color: Color.fromRGBO(189, 189, 189, 1),
                  //           fontSize: 16),
                  //       border: const OutlineInputBorder(
                  //           borderSide:
                  //           BorderSide(color: Color.fromRGBO(44, 83, 72, 1))),
                  //       suffixIcon: IconButton(
                  //         onPressed: durationController.clear,
                  //         icon: const Icon(
                  //           Icons.clear,
                  //           color: Color.fromRGBO(189, 189, 189, 1),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 20, left: 10),
                  //   width: Get.width,
                  //   child: const Text(
                  //     "Route distance",
                  //     style: TextStyle(
                  //       fontSize: 26.0,
                  //     ),
                  //     textAlign: TextAlign.start,
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //       top: 20, left: 10, right: 10, bottom: 20),
                  //   width: Get.width,
                  //   child: TextField(
                  //     controller: distanceController,
                  //     enabled: false,
                  //     textInputAction: TextInputAction.next,
                  //     minLines: 1,
                  //     maxLines: 1,
                  //     decoration: InputDecoration(
                  //       hintText: "In kilometers",
                  //       hintStyle: const TextStyle(
                  //           color: Color.fromRGBO(189, 189, 189, 1),
                  //           fontSize: 16),
                  //       border: const OutlineInputBorder(
                  //           borderSide:
                  //           BorderSide(color: Color.fromRGBO(44, 83, 72, 1))),
                  //       suffixIcon: IconButton(
                  //         onPressed: distanceController.clear,
                  //         icon: const Icon(
                  //           Icons.clear,
                  //           color: Color.fromRGBO(189, 189, 189, 1),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    child: mapWidget,
                    height: 300,
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
