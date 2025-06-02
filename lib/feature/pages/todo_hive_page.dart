import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/todo_list_component.dart';
import '../cubit/hive/todo_cubit.dart';

class TodoHivePage extends StatelessWidget {
  final Color? appBarColor;

  const TodoHivePage({super.key, this.appBarColor});

  @override
  Widget build(BuildContext context) {
    return HiveTodoListComponent(
      appBarColor: appBarColor,
      title: 'CRUD (HIVE)',
      addItem: (todoModel) {
        context.read<TodoCubit>().addItemToList(todoModel);
      },
      editItem: (todoModel, index) {
        context.read<TodoCubit>().editItemToList(index, todoModel);
      },
      deleteItem: (index, id) {
        context.read<TodoCubit>().deleteItemFromList(id);
      },
    );
  }
}
