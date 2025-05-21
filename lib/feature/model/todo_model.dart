import 'package:hive_flutter/adapters.dart';

part 'todo_model.g.dart';


//flutter packages pub run build_runner build

@HiveType(typeId: 0)
/*
  * @HiveType will tell the information above the data model table
    which contains an argument typeId.
  * */
class TodoModel extends HiveObject {
  /*The @HiveField tells the data to pass for each property.*/
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? item;
  @HiveField(2)
  int? quantity;

  TodoModel({this.item, this.quantity, this.id});

  TodoModel copyWith({String? id, String? item, int? quantity}) {
    return TodoModel(
      id: id ?? this.id,
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }
}
