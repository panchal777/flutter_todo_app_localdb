enum SuccessEnum { add, edit, delete, fetch }

abstract class IsarStates {
  const IsarStates();
}

class StateInitial extends IsarStates {}

class StateLoading extends IsarStates {}

class SuccessState extends IsarStates {
  final String msg;
  final List<dynamic> userList;
  final SuccessEnum type;

  const SuccessState({
    required this.msg,
    required this.userList,
    required this.type,
  });
}
