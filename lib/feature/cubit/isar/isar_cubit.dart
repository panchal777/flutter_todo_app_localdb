import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_localdb/core/drift_database/app_database.dart';
import 'package:flutter_todo_app_localdb/feature/cubit/isar/isar_states.dart';

class IsarCubit extends Cubit<IsarStates> {
  final String successMsg = 'List fetched successfully';
  final String addSuccessMsg = 'User added successfully';
  final String editSuccessMsg = 'User edited successfully';
  final String deleteSuccessMsg = 'User deleted successfully';

  IsarCubit() : super(StateInitial());

  getUserList() async {
    emit(StateLoading());
    var userList = [];
    emit(
      SuccessState(
        msg: successMsg,
        userList: userList,
        type: SuccessEnum.fetch,
      ),
    );
  }

  addItemToList(UserModelData model) async {}

  editItemToList(int index, UserModelData userModel) async {}

  deleteItemFromList(int id) async {}
}
