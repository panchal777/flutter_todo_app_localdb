import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_todo_app_localdb/core/drift_database/app_database.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

AppDatabase constructDb({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid) {
    final executor = LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbFilePath =
          Platform.isIOS
              ? "${dbFolder.path}/Backups"
              : dbFolder.path.replaceAll("app_flutter", "databases");
      final dbFileName = Platform.isIOS ? "todo.db" : "todo.db";
      final file = File(p.join(dbFilePath, dbFileName));
      return NativeDatabase(file, logStatements: true);
    });
    // final executor = LazyDatabase(() async {
    //   final dbFolder = await getApplicationDocumentsDirectory();
    //   final file = File(p.join(dbFolder.path, 'app.db'));
    //   return NativeDatabase(file);
    // });
    return AppDatabase(executor);
  }

  if (Platform.isMacOS || Platform.isLinux) {
    final file = File('todo.sqlite');
    return AppDatabase(NativeDatabase(file, logStatements: true));
  }

  return AppDatabase(NativeDatabase.memory(logStatements: true));
}
