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

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = AuthorizationController.instance.auth.currentUser;
  final profile = Get.put(ProfileController());
  final routesController = Get.put(RoutesController());
  bool flag = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(44, 83, 72, 1),
        child: flag
            ? Icon(
                Icons.nights_stay,
                color: Colors.white,
              )
            : Icon(Icons.sunny),
        onPressed: () {
          Get.isDarkMode
              ? Get.changeTheme(ThemeData.light())
              : Get.changeTheme(ThemeData.dark());
          setState(() {
            flag = !flag;
          });
        },
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
                            onTap: () => Get.toNamed(Routes.routeDescPage,
                                arguments: [e.id]),
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
                            Obx(
                              () => Text(
                                profile.userName.value ?? 'Default name',
                                style: const TextStyle(
                                  fontSize: 34,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Obx(
                                () => Text(
                                  profile.userEmail.value ?? 'Default email',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
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
