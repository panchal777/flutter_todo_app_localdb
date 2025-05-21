import 'package:flutter_todo_app_localdb/core/drift_database/app_database.dart';

import 'app_initializer/shared.dart';

class DBManager {
  static AppDatabase? _database;

  DBManager._privateConstructor();

  static final DBManager instance = DBManager._privateConstructor();

  AppDatabase getDbInstance() {
    if (_database == null) {
      _database = constructDb();
      return _database!;
    } else {
      return _database!;
    }
  }
}
