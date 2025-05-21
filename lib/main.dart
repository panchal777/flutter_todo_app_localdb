import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_localdb/feature/cubit/user_cubit.dart';

import 'core/routes/route_name.dart';
import 'core/services/hive_service.dart';
import 'feature/cubit/todo_cubit.dart';
import 'feature/pages/dashboard_page.dart';
import 'feature/pages/todo_drift_page.dart';
import 'feature/pages/todo_hive_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  runApp(const MyApp());
}

Route<dynamic>? _getRoute(RouteSettings settings) {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: _getRoute,
    );
  }
}
