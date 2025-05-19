import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/todo_list_component.dart';
import '../cubit/todo_cubit.dart';

class TodoHivePage extends StatelessWidget {
  const TodoHivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoListComponent(
      title: 'CRUD (HIVE)',
      addItem: (todoModel) {
        context.read<TodoCubit>().addItemToList(todoModel);
      },
      editItem: (todoModel, index) {
        context.read<TodoCubit>().editItemToList(index, todoModel);
      },
      deleteItem: (index,id) {
        context.read<TodoCubit>().deleteItemToList(id);
      },
    );
  }
}
