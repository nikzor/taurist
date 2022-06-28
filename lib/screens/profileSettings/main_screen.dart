import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/controllers/profile_controller.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final user = AuthorizationController.instance.auth.currentUser;
  final profile = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
        centerTitle: true,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () => profile.logout(),
          ),
        ],
      ),
    );
  }
}
