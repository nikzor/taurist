import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/controllers/profile_controller.dart';
import 'package:taurist/data/route_model.dart';

import '../../sharedWidgets/model_card.dart';
import 'app_bar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final user = AuthorizationController.instance.auth.currentUser;
  final storeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      listCardWidget(RouteModel("id", "owner", "title", "description", 5.6123, 125, {'ya': 5})),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
