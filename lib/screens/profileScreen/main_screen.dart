import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/controllers/profile_controller.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';
import 'package:taurist/routes.dart';
import 'package:taurist/sharedWidgets/model_card.dart';

import 'app_bar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final user = AuthorizationController.instance.auth.currentUser;
  final storeController = Get.put(ProfileController());
  final routesController = Get.put(RoutesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("123"),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverAppBar(expandedHeight: 200.0),
            ),
            FutureBuilder(
                future: routesController.list(
                  (m) => m.ownerId == FirebaseAuth.instance.currentUser!.uid,
                ),
                builder: (context, AsyncSnapshot<List<RouteModel>> snapshot) {
                  List<Widget> widgets = !snapshot.hasData
                      ? [
                          const CircularProgressIndicator(
                            semanticsLabel: 'Loading...',
                          )
                        ]
                      : snapshot.data!.map((e) {
                          return GestureDetector(
                            onTap: () =>
                                Get.toNamed(Routes.routeDescPage, arguments: [e.id]),
                            child: getModelCardWidget(e),
                          );
                        }).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(
                          height: 120,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              storeController.getUserName(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 34,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                user?.email ?? "-",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              indent: 50,
                              endIndent: 50,
                              thickness: 3,
                              height: 25,
                            ),
                            ...widgets
                          ],
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
