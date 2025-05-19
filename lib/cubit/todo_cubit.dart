import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_localdb/repository/todo_repository_impl.dart';

import '../model/todo_model.dart';
import '../repository/todo_repository.dart';
import 'todo_states.dart';

class TodoCubit extends Cubit<TodoCubitState> {
  List<TodoModel> todoList = [];

  final String successMsg = 'List fetched successfully';
  final String addSuccessMsg = 'Item added successfully';
  final String editSuccessMsg = 'Item edited successfully';
  final String deleteSuccessMsg = 'Item deleted successfully';

  TodoRepository todoRepository = TodoRepositoryImpl();

  TodoCubit() : super(StateInitial());

  getTodoList({bool isDrift = false}) async {
    todoList = await todoRepository.getTodoList(isDrift: isDrift);
    emit(
      SuccessState(
        msg: successMsg,
        todoList: todoList,
        type: SuccessEnum.fetch,
      ),
    );
  }

  addItemToList(TodoModel todoModel, {bool isDrift = false}) async {
    todoList = await todoRepository.addItem(todoModel, isDrift: isDrift);
    emit(
      SuccessState(
        msg: addSuccessMsg,
        todoList: todoList,
        type: SuccessEnum.add,
      ),
    );
  }

  editItemToList(int index, TodoModel todoModel, {bool isDrift = false}) async {
    todoList = await todoRepository.editItem(todoModel, isDrift: isDrift);
    emit(
      SuccessState(
        msg: editSuccessMsg,
        todoList: todoList,
        type: SuccessEnum.edit,
      ),
    );
  }

  deleteItemToList(String id, {bool isDrift = false}) async {
    todoList = await todoRepository.deleteItem(id, isDrift: isDrift);
    emit(
      SuccessState(
        msg: deleteSuccessMsg,
        todoList: todoList,
        type: SuccessEnum.delete,
      ),
    );
  }
}
