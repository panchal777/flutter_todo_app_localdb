import 'package:flutter_todo_app_localdb/core/drift_database/app_database.dart';

enum SuccessEnum { add, edit, delete, fetch }

abstract class UserState {
  const UserState();
}

class StateInitial extends UserState {}

class StateLoading extends UserState {}

class SuccessState extends UserState {
  final String msg;
  final List<UserModelData> userList;
  final SuccessEnum type;

  const SuccessState({
    required this.msg,
    required this.userList,
    required this.type,
  });
}
