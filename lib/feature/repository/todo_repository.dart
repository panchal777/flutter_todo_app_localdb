
import '../model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> addItem(TodoModel todoModel);

  Future<List<TodoModel>> editItem(TodoModel todoModel);

  Future<List<TodoModel>> deleteItem(String id);

  Future<List<TodoModel>> getTodoList();
}
