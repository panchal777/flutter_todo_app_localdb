import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../model/todo_model.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() => _instance;

  HiveService._internal();

  static const String _boxName = "todoBox";

  /// Initialize Hive and open commonly used boxes
  init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter();
    await registerAllAdapters();
  }

  registerAllAdapters() {
    Hive.registerAdapter(TodoModelAdapter());
  }

  /// Open a box (you can make this generic by passing a type)
  Future<Box<T>> openBox<T>() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<T>(_boxName);
    }
    return Hive.box<T>(_boxName);
  }

  // /// Write data
  // add<T>({required String key, required T value}) async {
  //   final box = await openBox<T>();
  //   await box.add(value);
  // }

  /// Write data
  update<T>({required String key, required T value}) async {
    final box = await openBox<T>();
    await box.put(key, value);
  }

  /// Read data
  read<T>({required String key}) async {
    final box = await openBox<T>();
    return box.get(key);
  }

  /// Delete data
  delete<T>({required String key}) async {
    final box = await openBox<T>();
    return box.delete(key);
  }

  /// Clear entire box
  clearBox<T>() async {
    final box = await openBox<T>();
    await box.clear();
  }

  /// Close all boxes
  closeAllBoxed() async {
    await Hive.close();
  }

  Future<List<T>> getList<T>(String key, T Function(dynamic) fromJson) async {
    final box = await openBox();
    final rawList = box.get(key);

    if (rawList is List) {
      return rawList.map<T>((item) => fromJson(item)).toList();
    }

    return <T>[];
  }
}

class HiveKeys {
  static String todoItemKey = "todoItem";
}
