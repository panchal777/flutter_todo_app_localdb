import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_localdb/core/drift_database/app_database.dart';
import 'package:flutter_todo_app_localdb/feature/cubit/user_state.dart';
import 'package:flutter_todo_app_localdb/feature/repository/user_repository.dart';
import '../repository/user_repository_impl.dart';

class UserCubit extends Cubit<UserState> {
  List<UserModelData> userList = [];

  final String successMsg = 'List fetched successfully';
  final String addSuccessMsg = 'User added successfully';
  final String editSuccessMsg = 'User edited successfully';
  final String deleteSuccessMsg = 'User deleted successfully';

  UserRepository userRepository = UserRepositoryImpl();

  UserCubit() : super(StateInitial());

  getUserList() async {
    emit(StateLoading());
    userList = await userRepository.getUserList();
    emit(
      SuccessState(
        msg: successMsg,
        userList: userList,
        type: SuccessEnum.fetch,
      ),
    );
  }

  addItemToList(UserModelData model) async {
    userList = await userRepository.addItemToUser(model);
    emit(
      SuccessState(
        msg: addSuccessMsg,
        userList: userList,
        type: SuccessEnum.add,
      ),
    );
  }

  editItemToList(int index, UserModelData userModel) async {
    userList = await userRepository.editItemToUser(userModel);
    emit(
      SuccessState(
        msg: editSuccessMsg,
        userList: userList,
        type: SuccessEnum.edit,
      ),
    );
  }

  deleteItemFromList(int id) async {
    userList = await userRepository.deleteItemFromUser(id);
    emit(
      SuccessState(
        msg: deleteSuccessMsg,
        userList: userList,
        type: SuccessEnum.delete,
      ),
    );
  }
}
