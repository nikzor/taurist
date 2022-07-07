import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorSnackbar {
  static void errorSnackbar(String message) {
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
}
