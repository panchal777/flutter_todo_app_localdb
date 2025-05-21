import 'package:drift/drift.dart';
import 'package:flutter_todo_app_localdb/core/drift_database/models/user.dart';

import '../app_database.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UserModel])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  final AppDatabase db;

  UserDao(this.db) : super(db);

  // Create
  Future<int> insertUser(UserModelCompanion user) {
    return into(userModel).insert(user);
  }

  // Read
  Future<List<UserModelData>> getAllUsers() {
    return select(userModel).get();
  }

  // Update
  Future<bool> updateUser(UserModelData user) {
    return update(userModel).replace(user);
  }

  // Delete
  Future<int> deleteUser(int id) {
    return (delete(userModel)..where((t) => t.id.equals(id))).go();
  }
}
