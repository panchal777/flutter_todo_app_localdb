import 'package:drift/web.dart';
import 'package:flutter/cupertino.dart';

import '../app_database.dart';

AppDatabase constructDb({bool logStatements = false}) {
  debugPrint("initialize db");
  return AppDatabase(WebDatabase('db', logStatements: logStatements));
}
