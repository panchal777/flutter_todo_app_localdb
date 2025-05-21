import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../cubit/todo_cubit.dart';
import '../cubit/todo_states.dart';
import '../model/todo_model.dart';

class TodoListComponent extends StatefulWidget {
  final String title;
  final Function(TodoModel todoModel) addItem;
  final Function(TodoModel todoModel, int index) editItem;
  final Function(int index, String id) deleteItem;

  const TodoListComponent({
    super.key,
    this.title = 'CRUD Operations',
    required this.addItem,
    required this.editItem,
    required this.deleteItem,
  });

  @override
  State<TodoListComponent> createState() => _TodoListComponentState();
}

class _TodoListComponentState extends State<TodoListComponent> {
  List<TodoModel> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              _showInputDialog();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoCubitState>(
        builder: (context, state) {
          if (state is SuccessState) {
            todoList = state.todoList;
          }

          return todoList.isEmpty
              ? Center(child: Text("No Records Found"))
              : ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  var data = todoList[index];
                  return Slidable(
                    enabled: true,
                    key: Key("value$index${data.item}"),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          flex: 1,
                          onPressed: (context) {
                            _showInputDialog(
                              isEdit: true,
                              index: index,
                              todoModel: data,
                            );
                          },
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.save,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 1,
                          onPressed: (context) {
                            widget.deleteItem(index, data.id ?? '');
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${data.item}"),
                              Text("Value: ${data.quantity.toString()}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
        },
      ),
    );
  }

  void _showInputDialog({
    bool isEdit = false,
    int index = 0,
    TodoModel? todoModel,
  }) {
    TextEditingController nameController = TextEditingController(
      text: isEdit ? todoModel?.item : '',
    );
    TextEditingController valueController = TextEditingController(
      text: isEdit ? todoModel?.quantity.toString() : '',
    );

    showDialog(
      context: context,
      builder: (childContext) {
        return AlertDialog(
          title: Text('Enter Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: valueController,
                decoration: InputDecoration(labelText: 'Value'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(childContext).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(childContext).pop(); // Close dialog

                var todoModel = TodoModel(
                  item: nameController.text,
                  quantity: int.parse(valueController.text),
                );
                isEdit
                    ? widget.editItem(todoModel, index)
                    : widget.addItem(todoModel);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
