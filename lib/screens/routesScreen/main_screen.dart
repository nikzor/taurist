import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/profile_controller.dart';
import 'package:taurist/controllers/routes_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taurist',
          style: TextStyle(
              fontFamily: 'Inter',
              color: Color.fromRGBO(44, 83, 72, 1),
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
                    () =>
                    CircleAvatar(
                      backgroundColor: Colors.black12,
                      backgroundImage: NetworkImage(profile.userPhoto.value),
                      radius: 25,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Actual routes",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color.fromRGBO(44, 83, 72, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
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
                      children: const [
                        Text("Add new route",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(44, 83, 72, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w800)),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.add,
                          color: Color.fromRGBO(44, 83, 72, 1),
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
              // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              //     stream: FirebaseFirestore.instance
              //         .collection('routes')
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         List<Widget> widgets = [
              //           const Center(child: CircularProgressIndicator(),),
              //         ];
              //       } else{
              //         List<Widget> widgets = ;
              //       }
              //     }),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: (SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [],
                    ),
                  )),
                ),
              ),
            ],
          ),
        )
        /* CustomScrollView(
          slivers: [
            FutureBuilder(
              future: routesController.list(),
              builder: (context, AsyncSnapshot<List<RouteModel>> snapshot) {
                List<Widget> widgets = !snapshot.hasData
                    ? [
                        const CircularProgressIndicator(
                          semanticsLabel: 'Loading...',
                        )
                      ]
                    : snapshot.data!.map((e) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(Routes.routeDescPage,
                              arguments: [e.id]),
                          child: getModelCardWidget(e),
                        );
                      }).toList();
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      */ /*ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.profilePage),
                        child: Text('Profile'),
                      ),*/ /*
                      ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.newRouteScreen),
                        child: Text('Create new route'),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widgets,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        )*/
        ,
      ),
    );
  }
}
