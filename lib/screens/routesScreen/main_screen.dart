import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Taurist', style: TextStyle(fontFamily: 'Inter', color: Color.fromRGBO(44, 83, 72, 1), fontSize: 45, fontWeight: FontWeight.w800),),
          centerTitle: true,

          backgroundColor: Colors.transparent /*Colors.red*/,
          elevation: 0,
          actions: [
              Padding(
                padding: EdgeInsets.only(right: 2, top: 5),
                child: ElevatedButton(onPressed: () => Get.toNamed(Routes.profilePage),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: CircleBorder(),

                  ),
                child: CircleAvatar(
                  backgroundColor: Colors.black12,
                  backgroundImage: NetworkImage(
                      'https://c.tenor.com/n_iyW_O2YOUAAAAM/popcat-cat.gif'),
                  radius: 25,
                ),
                ),
              ),
          ],
        ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Actual routes", style: TextStyle(fontFamily: 'Inter', color: Color.fromRGBO(44, 83, 72, 1), fontSize: 25, fontWeight: FontWeight.w800),),
                SizedBox(width: 15,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [TextButton( onPressed: () {  }, child: Row(children: [Text("Add new route", style: TextStyle(fontFamily: 'Inter', color: Color.fromRGBO(44, 83, 72, 1), fontSize: 12, fontWeight: FontWeight.w800)), SizedBox(width: 3,),Icon(Icons.add, color: Color.fromRGBO(44, 83, 72, 1) ,)],) ,),
                  SizedBox(width: 15,),
                ],
              ),
              Container(height: 1,
                  width: double.infinity,
                color: Colors.black,
              ),
              Expanded(child:Container(
                height: double.infinity,
                width: double.infinity,
                child: (
                    SingleChildScrollView(
                      controller: ScrollController(
                      ),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(width: 70, height: 200, color: Colors.red,),
                          SizedBox(height: 15,),
                          Container(width: 70, height: 200, color: Colors.red,),
                          SizedBox(height: 15,),
                          Container(width: 70, height: 200,color: Colors.red,),
                          SizedBox(height: 15,),
                        ],
                      ),
                    )
                ),

              ) )

            ],
          ),

        )/* CustomScrollView(
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
                      *//*ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.profilePage),
                        child: Text('Profile'),
                      ),*//*
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
        )*/,
      ),
    );
  }
}
