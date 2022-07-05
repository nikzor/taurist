import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:taurist/data/route_model.dart';
import 'package:uuid/uuid.dart';

class NewRouteScreen extends StatefulWidget {
  const NewRouteScreen({super.key});

  @override
  State<NewRouteScreen> createState() => _NewRouteScreenState();
}

class _NewRouteScreenState extends State<NewRouteScreen> {
  final routesController = Get.put(RoutesController());
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final durationController = TextEditingController();
  final uuid = const Uuid();
  File? uploadFile;

  void addXmlFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      uploadFile = File(result.files.first.path!);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New route creation'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, left: 10),
                width: Get.width,
                child: const Text(
                  "Route title",
                  style: TextStyle(
                    fontSize: 26.0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                width: Get.width,
                child: TextField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(189, 189, 189, 1), fontSize: 16),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(44, 83, 72, 1))),
                    suffixIcon: IconButton(
                      onPressed: titleController.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Color.fromRGBO(189, 189, 189, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 10),
                width: Get.width,
                child: const Text(
                  "Route description",
                  style: TextStyle(
                    fontSize: 26.0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                width: Get.width,
                child: TextField(
                  controller: descriptionController,
                  textInputAction: TextInputAction.next,
                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(189, 189, 189, 1), fontSize: 16),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(44, 83, 72, 1))),
                    suffixIcon: IconButton(
                      onPressed: descriptionController.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Color.fromRGBO(189, 189, 189, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 10),
                width: Get.width,
                child: const Text(
                  "Route duration",
                  style: TextStyle(
                    fontSize: 26.0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                width: Get.width,
                child: TextField(
                  controller: durationController,
                  textInputAction: TextInputAction.next,
                  minLines: 1,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "In minutes",
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(189, 189, 189, 1), fontSize: 16),
                    border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color.fromRGBO(44, 83, 72, 1))),
                    suffixIcon: IconButton(
                      onPressed: durationController.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Color.fromRGBO(189, 189, 189, 1),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: addXmlFile,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(44, 83, 72, 1),
                  onPrimary: Colors.white,
                ),
                child: const SizedBox(width: 170,child: Center(child: Text("Pick .gpx file"),),),
              ),
              ElevatedButton(
                onPressed: () async {
                  String? uploadFileId = await routesController.addXml(uploadFile);
                  routesController.addOrUpdate(
                    RouteModel(
                        uuid.v4(),
                        FirebaseAuth.instance.currentUser!.uid,
                        titleController.text,
                        descriptionController.text,
                        0.0,
                        durationController.text.trim().isNotEmpty
                            ? int.parse(durationController.text.trim())
                            : 0,
                        {},
                        uploadFileId ?? "someRandomId"),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(44, 83, 72, 1),
                  onPrimary: Colors.white,
                ),
                child: const SizedBox(width: 170,child: Center(child: Text("Upload data to the server"),),),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
      //   foregroundColor: Colors.white,
      //   onPressed: () async {
      //     String? uploadFileId = await routesController.addXml(uploadFile);
      //     routesController.addOrUpdate(
      //       RouteModel(
      //           uuid.v4(),
      //           FirebaseAuth.instance.currentUser!.uid,
      //           titleController.text,
      //           descriptionController.text,
      //           0.0,
      //           0,
      //           {},
      //           uploadFileId ?? "someRandomId"),
      //     );
      //   },
      //   tooltip: 'Upload data to the server',
      //   child: const Icon(Icons.upload),
      // ),
    );
  }
}
