import '../../core/services/hive_service.dart';
import '../../core/utils.dart';
import '../model/todo_model.dart';
import 'todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final HiveService _hiveService = HiveService();

  final _todoKey = HiveKeys.todoItemKey;

  @override
  Future<List<TodoModel>> addItem(
    TodoModel todoModel, {
    bool isDrift = false,
  }) async {
    final box = await _hiveService.openBox();
    var currentList = await getTodoList();
    var id = Utils().generateRandomId();
    TodoModel model = todoModel.copyWith(id: id);
    currentList.add(model);
    await box.put(_todoKey, currentList);
    return currentList;
  }

  @override
  Future<List<TodoModel>> editItem(
    TodoModel updatedModel, {
    bool isDrift = false,
  }) async {
    final box = await _hiveService.openBox();
    var currentList = await getTodoList();
    final index = currentList.indexWhere((item) => item.id == updatedModel.id);

    if (index != -1) {
      currentList[index] = updatedModel;
      await box.put(_todoKey, currentList);
    }

    return currentList;
  }

  @override
  Future<List<TodoModel>> deleteItem(String id, {bool isDrift = false}) async {
    final box = await _hiveService.openBox();
    var currentList = await getTodoList();
    currentList.removeWhere((element) => element.id == id);
    await box.put(_todoKey, currentList);
    return currentList;
  }

  @override
  Future<List<TodoModel>> getTodoList({bool isDrift = false}) async {
    final todos = await _hiveService.getList<TodoModel>(
      HiveKeys.todoItemKey,
      (item) => item as TodoModel,
    );
    return todos;
  }
}
