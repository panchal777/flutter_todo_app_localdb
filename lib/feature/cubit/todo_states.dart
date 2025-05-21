import '../model/todo_model.dart';

enum SuccessEnum { add, edit, delete, fetch }

abstract class TodoCubitState {
  const TodoCubitState();
}

class StateInitial extends TodoCubitState {}

class StateLoading extends TodoCubitState {}

class SuccessState extends TodoCubitState {
  final String msg;
  final List<TodoModel> todoList;
  final SuccessEnum type;

  const SuccessState({
    required this.msg,
    required this.todoList,
    required this.type,
  });
}
