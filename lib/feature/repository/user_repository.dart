import '../../core/drift_database/app_database.dart';

abstract class UserRepository {
  /*Drift database operations */
  Future<List<UserModelData>> getUserList();

  Future<List<UserModelData>> addItemToUser(UserModelData userModel);

  Future<List<UserModelData>> editItemToUser(UserModelData userModel);

  Future<List<UserModelData>> deleteItemFromUser(int id);
}
