import 'package:flutter/material.dart';

import '../../core/routes/route_name.dart';

class DashboardModel {
  String label;
  String routName;
  Color? color;

  DashboardModel({this.label = '', this.routName = '', this.color});

  List<DashboardModel> getDashboardList() {
    return [
      DashboardModel(
        label: "Hive",
        routName: RouteName.hive,
        color: Colors.brown.shade100,
      ),
      DashboardModel(
        label: "Drift",
        routName: RouteName.drift,
        color: Colors.blueGrey.shade100,
      ),
      DashboardModel(
        label: "Isar",
        routName: RouteName.isar,
        color: Colors.deepPurple.shade100,
      ),
    ];
  }
}
