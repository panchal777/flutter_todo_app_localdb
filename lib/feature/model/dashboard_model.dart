
import '../../core/routes/route_name.dart';

class DashboardModel {
  String label;
  String routName;

  DashboardModel({this.label = '', this.routName = ''});

  List<DashboardModel> getDashboardList() {
    return [
      DashboardModel(label: "Hive", routName: RouteName.hive),
      DashboardModel(label: "Drift", routName: RouteName.drift),
    ];
  }
}
