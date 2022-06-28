import 'package:flutter/material.dart';
import 'package:taurist/data/route_model.dart';
import 'package:taurist/sharedWidgets/model_card.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoutesPageState();
}

class RoutesPageState extends State<RoutesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 120,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      listCardWidget(RouteModel("id", "owner", "title",
                          "description", 5.6123, 125, {'ya': 5})),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}