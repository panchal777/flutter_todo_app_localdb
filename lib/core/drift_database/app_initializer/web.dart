import 'package:drift/web.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_todo_app_localdb/core/drift_database/app_database.dart';

AppDatabase constructDb({bool logStatements = false}) {
  debugPrint("initialize db");
  return AppDatabase(WebDatabase('db', logStatements: logStatements));
}
