import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
        child: flag
            ? const Icon(
                Icons.nights_stay,
                color: Colors.white,
              )
            : const Icon(Icons.sunny),
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
            SliverList(
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
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: routesController.list(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        RouteModel doc = RouteModel.fromJson(
                            snapshot.data!.docs[index].data());
                        if (doc.ownerId !=
                            FirebaseAuth.instance.currentUser!.uid) {
                          return Container();
                        }
                        return GestureDetector(
                          onTap: () => Get.toNamed(Routes.routeDescPage,
                              arguments: [doc.id]),
                          child: getModelCardWidget(
                            doc,
                            removable: true,
                            controller: routesController,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
