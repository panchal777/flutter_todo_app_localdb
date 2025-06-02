import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/user_list_component.dart';
import '../cubit/drift/user_cubit.dart';

class TodoDriftPage extends StatelessWidget {
  final Color? appBarColor;

  const TodoDriftPage({super.key, this.appBarColor});

  @override
  Widget build(BuildContext context) {
    return DriftUserListComponent(
      appBarColor: appBarColor,
      title: 'CRUD (DRIFT)',
      addItem: (userModel) {
        context.read<UserCubit>().addItemToList(userModel);
      },
      editItem: (userModel, index) {
        context.read<UserCubit>().editItemToList(index, userModel);
      },
      deleteItem: (index, id) {
        context.read<UserCubit>().deleteItemFromList(id);
      },
    );
  }
}
