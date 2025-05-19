import 'package:flutter/material.dart';
import 'package:flutter_todo_app_localdb/model/dashboard_model.dart';

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
              title: Text(data.label),
              onTap: () {
                navigateToNextPage(data.routName, context);
              },
            ),
          );
        },
      ),
    );
  }

  navigateToNextPage(String routName, BuildContext context) {
    Navigator.pushNamed(context, routName);
  }
}
