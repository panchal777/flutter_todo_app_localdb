import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_localdb/feature/cubit/hive/todo_states.dart';
import '../../model/todo_model.dart';
import '../../repository/todo_repository.dart';
import '../../repository/todo_repository_impl.dart';

class TodoCubit extends Cubit<TodoCubitState> {
  List<TodoModel> todoList = [];

  final String successMsg = 'List fetched successfully';
  final String addSuccessMsg = 'Item added successfully';
  final String editSuccessMsg = 'Item edited successfully';
  final String deleteSuccessMsg = 'Item deleted successfully';

  TodoRepository todoRepository = TodoRepositoryImpl();

  TodoCubit() : super(StateInitial());

  getTodoList() async {
    emit(StateLoading());
    todoList = await todoRepository.getTodoList();
    emit(
      SuccessState(
        msg: successMsg,
        todoList: todoList,
        type: SuccessEnum.fetch,
      ),
    );
  }

  addItemToList(TodoModel todoModel) async {
    todoList = await todoRepository.addItem(todoModel);
    emit(
      SuccessState(
        msg: addSuccessMsg,
        todoList: todoList,
        type: SuccessEnum.add,
      ),
    );
  }

  editItemToList(int index, TodoModel todoModel) async {
    todoList = await todoRepository.editItem(todoModel);
    emit(
      SuccessState(
        msg: editSuccessMsg,
        todoList: todoList,
        type: SuccessEnum.edit,
      ),
    );
  }

  deleteItemFromList(String id) async {
    todoList = await todoRepository.deleteItem(id);
    emit(
      SuccessState(
        msg: deleteSuccessMsg,
        todoList: todoList,
        type: SuccessEnum.delete,
      ),
    );
  }
}
