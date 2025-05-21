import 'package:drift/drift.dart';

class UserModel extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get firstName => text().nullable()();

  TextColumn get lastName => text().nullable()();
}

// import 'package:drift/drift.dart';
//
// class TodoDriftModel extends Table {
//   IntColumn get id => integer().autoIncrement()();
//
//   TextColumn get title => text().withLength(min: 6, max: 32)();
//
//   TextColumn get content => text().named('body')();
//
//   DateTimeColumn get createdAt => dateTime().nullable()();
// }
