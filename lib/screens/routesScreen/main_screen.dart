import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/profile_controller.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:taurist/data/route_model.dart';
import 'package:taurist/routes.dart';
import 'package:taurist/sharedWidgets/model_card.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoutesPageState();
}

class RoutesPageState extends State<RoutesPage> {
  final routesController = Get.put(RoutesController());
  final profile = Get.put(ProfileController());
  final CollectionReference routesDB =
      FirebaseFirestore.instance.collection('routes');

  @override
  Widget build(BuildContext context) {
    bool flag = Get.isDarkMode;
    setState(() {
      flag = Get.isDarkMode;
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              title: Text(
                'Taurist',
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: flag
                        ? Colors.white
                        : const Color.fromRGBO(44, 83, 72, 1),
                    fontSize: 45,
                    fontWeight: FontWeight.w800),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent /*Colors.red*/,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 2, top: 5),
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.profilePage),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(44, 83, 72, 1),
                      shape: const CircleBorder(),
                    ),
                    child: Obx(
                      () => CircleAvatar(
                        backgroundColor: Colors.black12,
                        backgroundImage: NetworkImage(profile.userPhoto.value),
                        radius: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Actual routes",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: flag
                            ? Colors.white
                            : const Color.fromRGBO(44, 83, 72, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.newRouteScreen),
                    child: Row(
                      children: [
                        Text("Add new route",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: flag
                                    ? Colors.white
                                    : const Color.fromRGBO(44, 83, 72, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.add,
                          color: flag
                              ? Colors.white
                              : const Color.fromRGBO(44, 83, 72, 1),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.black,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: routesController.list(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot<Map<String, dynamic>> doc =
                                  snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () => Get.toNamed(Routes.routeDescPage,
                                    arguments: [doc.id]),
                                child: getModelCardWidget(
                                  RouteModel.fromJson(
                                    doc.data()!,
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
