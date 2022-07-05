import 'package:flutter/material.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/controllers/profile_controller.dart';
import 'package:get/get.dart';

import 'app_bar.dart';
import 'list_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = AuthorizationController.instance.auth.currentUser;
  final profile = Get.put(ProfileController());

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
                      Obx(
                        () => Text(
                          profile.userName.value ?? 'Default name',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 34),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Obx(
                          () => Text(
                            profile.userEmail.value ?? 'Default email',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
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
                      listCardWidget(),
                      listCardWidget(),
                      listCardWidget(),
                      listCardWidget(),
                      listCardWidget(),
                      listCardWidget(),
                      listCardWidget(),
                      listCardWidget(),
                      listCardWidget(),
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
