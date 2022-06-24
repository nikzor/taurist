import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/screens/start/main_screen.dart';
import 'package:taurist/screens/signIn/main_screen.dart';
import 'package:taurist/screens/mainScreen/main_screen.dart';

class AuthorizationController extends GetxController {
  static AuthorizationController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, (callback) => _initScreen);
  }

  _initScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const StartPage());
    } else {
      Get.offAll(() => const RoutesPage());
    }
  }

  void errorSnackbar(String message) {
    Get.snackbar(
      "Title",
      "Message",
      backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
      snackPosition: SnackPosition.BOTTOM,
      titleText: const Text(
        "An error occurred",
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  void signUp(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _initScreen(auth.currentUser);
    } catch (e) {
      errorSnackbar(e.toString());
    }
  }

  void signIn(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      _initScreen(auth.currentUser);
    } catch (e) {
      errorSnackbar(e.toString());
    }
  }

  void resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Title",
        "Message",
        backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Success!",
          style: TextStyle(color: Colors.white),
        ),
        messageText: const Text(
          "Email has been sent",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
      Get.offAll(() => const SignInPage());;
    } catch (e) {
      errorSnackbar(e.toString());
    }
  }
}
