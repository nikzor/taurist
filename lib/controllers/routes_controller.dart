import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:taurist/data/route_model.dart';
import 'package:taurist/helpers/error_snackbar.dart';
import 'package:taurist/helpers/typedef.dart';

class RoutesController extends GetxController {
  static RoutesController instance = Get.find();
  static const uuid = Uuid();
  final routesDB = FirebaseFirestore.instance;
  final xmlStorage = FirebaseStorage.instance;
  File? uploadFile;

  Future<RouteModel?> get(String id) async {
    try {
      var snap = await routesDB.collection("routes").doc(id).get();
      if (snap.data() == null) return null;
      return RouteModel.fromJson(snap.data()!);
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
      return null;
    }
  }

  Future<String?> addXml(File? uploadFile) async {
    String? xmlFileId;

    try {
      xmlFileId = uuid.v4();
      await xmlStorage.ref().child("gpx_files/$xmlFileId").putFile(uploadFile!);
    } catch (e) {
      xmlFileId = null;
      ErrorSnackbar.errorSnackbar(e.toString());
    }
    return xmlFileId;
  }

  Future<String> getGpxMap (String mapId) async {
    var data = await xmlStorage.ref().child("gpx_files/$mapId").getData();
    return String.fromCharCodes(data!);
  }

  // Add or update route
  void addOrUpdate(RouteModel route) async {
    try {
      await routesDB.collection("routes").doc(route.id).set(route.toJson());
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> list([Predicate<RouteModel>? predicate]) {
    return routesDB.collection("routes").snapshots();
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
