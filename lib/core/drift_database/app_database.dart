import 'package:drift/drift.dart';

import 'dao/user_dao.dart';
import 'models/user.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [UserModel], daos: [UserDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor!);

  @override
  int get schemaVersion => 1;
}
