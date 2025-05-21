import 'package:flutter/material.dart';
import '../model/dashboard_model.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dashboardList = DashboardModel().getDashboardList();

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: dashboardList.length,
        itemBuilder: (context, index) {
          var data = dashboardList[index];
          return Card(
            margin: EdgeInsets.only(bottom: 8),
            child: ListTile(
              tileColor: data.color,
              title: Text(
                data.label,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                navigateToNextPage(data.routName, context, data);
              },
            ),
          );
        },
      ),
    );
  }

  navigateToNextPage(
    String routName,
    BuildContext context,
    DashboardModel data,
  ) {
    Navigator.pushNamed(
      context,
      routName,
      arguments: {"appBarColor": data.color},
    );
  }
}
