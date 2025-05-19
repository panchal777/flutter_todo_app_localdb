import 'package:flutter_todo_app_localdb/model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> addItem(TodoModel todoModel, {bool isDrift = false});

  Future<List<TodoModel>> editItem(TodoModel todoModel, {bool isDrift = false});

  Future<List<TodoModel>> deleteItem(String id, {bool isDrift = false});

  Future<List<TodoModel>> getTodoList({bool isDrift = false});
}
