import 'package:drift/drift.dart';
import 'package:flutter_todo_app_localdb/core/drift_database/app_database.dart';
import 'package:flutter_todo_app_localdb/core/drift_database/db_manager.dart';
import 'package:flutter_todo_app_localdb/feature/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  AppDatabase database = DBManager.instance.getDbInstance();

  @override
  Future<List<UserModelData>> addItemToUser(UserModelData userModel) async {
    await database.userDao.insertUser(
      UserModelCompanion(
        firstName: Value(userModel.firstName),
        lastName: Value(userModel.lastName),
      ),
    );

    var list = await getUserList();
    return list;
  }

  @override
  Future<List<UserModelData>> deleteItemFromUser(int id) async {
    await database.userDao.deleteUser(id);
    var list = await getUserList();
    return list;
  }

  @override
  Future<List<UserModelData>> editItemToUser(UserModelData userModel) async {
    await database.userDao.updateUser(userModel);
    var list = await getUserList();
    return list;
  }

  @override
  Future<List<UserModelData>> getUserList() async {
    var list = await database.userDao.getAllUsers();
    return list;
  }
}
