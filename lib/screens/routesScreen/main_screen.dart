import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';
import 'package:taurist/routes.dart';
import 'package:taurist/sharedWidgets/model_card.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoutesPageState();
}

class RoutesPageState extends State<RoutesPage> {
  final routesController = Get.put(RoutesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            FutureBuilder(
              future: routesController.list(),
              builder: (context, AsyncSnapshot<List<RouteModel>> snapshot) {
                List<Widget> widgets = !snapshot.hasData
                    ? [
                        const CircularProgressIndicator(
                          semanticsLabel: 'Loading...',
                        )
                      ]
                    : snapshot.data!.map((e) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(Routes.routeDescPage,
                              arguments: [e.id]),
                          child: getModelCardWidget(e),
                        );
                      }).toList();
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.profilePage),
                        child: Text('Profile'),
                      ),
                      ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.newRouteScreen),
                        child: Text('Create new route'),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widgets,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
