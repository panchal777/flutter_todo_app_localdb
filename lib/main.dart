import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_localdb/pages/dashboard_page.dart';
import 'package:flutter_todo_app_localdb/pages/todo_hive_page.dart';
import 'package:flutter_todo_app_localdb/routes/route_name.dart';

import 'cubit/todo_cubit.dart';
import 'services/hive_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  runApp(const MyApp());
}

Route<dynamic>? _getRoute(RouteSettings settings) {
  if (settings.name == RouteName.dashboard) {
    return _buildRoute(settings, DashboardPage());
  } else if (settings.name == RouteName.hive) {
    return _buildRoute(
      settings,
      BlocProvider(
        create: (_) => TodoCubit()..getTodoList(),
        child: TodoHivePage(),
      ),
    );
  } else if (settings.name == RouteName.drift) {
    return _buildRoute(
      settings,
      BlocProvider(
        create: (_) => TodoCubit()..getTodoList(),
        child: Scaffold(body: Center(child: Text("Coming Soon"))),
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
