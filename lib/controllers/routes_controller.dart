import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taurist/data/route_model.dart';
import 'package:taurist/helpers/error_snackbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:taurist/helpers/typedef.dart';

class RoutesController extends GetxController {
  static RoutesController instance = Get.find();

  final routesDB = FirebaseFirestore.instance;

  // Add or update route
  void addOrUpdate(RouteModel route) async {
    try {
      await routesDB.collection("routes").doc(route.id).set(route.toJson());
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }

  Future<List<RouteModel>> list([Predicate<RouteModel>? predicate]) async {
    List<RouteModel> result = [];
    var collection = await routesDB.collection("routes").get();
    for (var snap in collection.docs) {
      RouteModel model = RouteModel.fromJson(snap.data());
      if (predicate == null || predicate(model)) {
        result.add(model);
      }
    }
    return result;
  }

  // Remove route by it's instance
  void remove(RouteModel route) async {
    removeById(route.id);
  }

  // Remove route by it's ID
  void removeById(String routeId) async {
    try {
      await routesDB.collection("routes").doc(routeId).delete();
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }
}
