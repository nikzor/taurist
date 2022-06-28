import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';
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
    RouteModel test = RouteModel(
      "id",
      FirebaseAuth.instance.currentUser!.uid,
      "title",
      "description",
      5.6123,
      125,
      {
        'Test1': 5,
        'Test2': 3,
      },
    );
    RouteModel test2 = RouteModel(
      "id2",
      "owner2",
      "title2",
      "description2",
      15.6,
      1251,
      {
        'Test1': 5,
        'Test2': 3,
      },
    );
    routesController.addOrUpdate(test);
    routesController.addOrUpdate(test2);

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
                      : snapshot.data!
                          .map((e) => getModelCardWidget(e))
                          .toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        ElevatedButton(
                          onPressed: () => Get.toNamed('/profilePage'),
                          child: Text('Profile'),
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
                })
          ],
        ),
      ),
    );
  }
}
