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
  _NewRouteScreenState createState() => _NewRouteScreenState();
}

class _NewRouteScreenState extends State<NewRouteScreen> {
  final routesController = Get.put(RoutesController());
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final uuid = const Uuid();
  File? uploadFile;
  void addXmlFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      uploadFile = File(result.files.first.path!);
    } else {
      print("You have not picked the file!");
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
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Title",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: titleController,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Description",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: descriptionController,
            ),
          ),
          ElevatedButton(onPressed: addXmlFile, child: Text("Pick gpx file"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? uploadFileId = await routesController.addXml(uploadFile);
          routesController.addOrUpdate(RouteModel(uuid.v4(), FirebaseAuth.instance.currentUser!.uid, titleController.text, descriptionController.text, 0.0, 0,
              {}, uploadFileId ?? "someRandomId"));
        },
        tooltip: 'Upload data to the server',
        child: const Icon(Icons.upload),
      ),
    );
  }
}
