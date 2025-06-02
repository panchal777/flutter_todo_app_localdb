import 'package:flutter/material.dart';
import '../components/isar_list_component.dart';

class TodoIsarPage extends StatelessWidget {
  final Color? appBarColor;

  const TodoIsarPage({super.key, this.appBarColor});

  @override
  Widget build(BuildContext context) {
    return IsarListComponent(
      appBarColor: appBarColor,
      title: 'CRUD (ISAR)',
      addItem: (todoModel) {},
      editItem: (todoModel, index) {},
      deleteItem: (index, id) {},
    );
  }
}
