import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/controllers/profile_controller.dart';
import 'package:get/get.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String userName =
      AuthorizationController.instance.auth.currentUser?.displayName ??
          "User name not defined";
  final profile = Get.put(ProfileController());

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(44, 83, 72, 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed('/profileSettings');
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: expandedHeight / 4 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              children: [
                const Text(
                  "Taurist",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SizedBox(
                    height: expandedHeight,
                    width: MediaQuery.of(context).size.width / 2,
                    child: CircularProfileAvatar(
                      profile.getUserPhoto(),
                      radius: 100,
                      backgroundColor: Colors.transparent,
                      borderWidth: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}