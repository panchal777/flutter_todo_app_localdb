import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_localdb/feature/components/user_list_component.dart';
import 'package:flutter_todo_app_localdb/feature/cubit/user_cubit.dart';

class TodoDriftPage extends StatelessWidget {
  final Color? appBarColor;

  const TodoDriftPage({super.key, this.appBarColor});

  @override
  Widget build(BuildContext context) {
    return UserListComponent(
      appBarColor: appBarColor,
      title: 'CRUD (DRIFT)',
      addItem: (todoModel) {
        context.read<UserCubit>().addItemToList(todoModel);
      },
      editItem: (todoModel, index) {
        context.read<UserCubit>().editItemToList(index, todoModel);
      },
      deleteItem: (index, id) {
        context.read<UserCubit>().deleteItemFromList(id);
      },
    );
  }
}
