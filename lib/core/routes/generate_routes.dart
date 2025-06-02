import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:flutter_todo_app_localdb/core/routes/route_name.dart'
    show RouteName;
import '../../feature/cubit/hive/todo_cubit.dart' show TodoCubit;
import '../../feature/cubit/drift/user_cubit.dart' show UserCubit;
import '../../feature/pages/dashboard_page.dart' show DashboardPage;
import '../../feature/pages/todo_drift_page.dart' show TodoDriftPage;
import '../../feature/pages/todo_hive_page.dart' show TodoHivePage;

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == RouteName.dashboard) {
    return _buildRoute(settings, DashboardPage());
  } else if (settings.name == RouteName.hive) {
    var arguments = settings.arguments as Map<String, dynamic>;
    var appBarColor = arguments['appBarColor'];

    return _buildRoute(
      settings,
      BlocProvider(
        create: (_) => TodoCubit()..getTodoList(),
        child: TodoHivePage(appBarColor: appBarColor),
      ),
    );
  } else if (settings.name == RouteName.drift) {
    var arguments = settings.arguments as Map<String, dynamic>;
    var appBarColor = arguments['appBarColor'];

    return _buildRoute(
      settings,
      BlocProvider(
        create: (_) => UserCubit()..getUserList(),
        child: TodoDriftPage(appBarColor: appBarColor),
      ),
    );
  }
  return null;
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(settings: settings, builder: (ctx) => builder);
}
