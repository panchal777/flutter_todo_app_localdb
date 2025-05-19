import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/todo_list_component.dart';
import '../cubit/todo_cubit.dart';

class TodoDriftPage extends StatelessWidget {
  const TodoDriftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoListComponent(
      title: 'CRUD (DRIFT)',
      addItem: (todoModel) {
        context.read<TodoCubit>().addItemToList(todoModel, isDrift: true);
      },
      editItem: (todoModel, index) {
        context.read<TodoCubit>().editItemToList(
          index,
          todoModel,
          isDrift: true,
        );
      },
      deleteItem: (index,id) {
        context.read<TodoCubit>().deleteItemToList(id, isDrift: true);
      },
    );
  }
}
