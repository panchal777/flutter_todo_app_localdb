import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_app_localdb/core/utils/utils.dart';
import 'package:flutter_todo_app_localdb/feature/components/add_edit_widget.dart';
import 'package:flutter_todo_app_localdb/feature/cubit/hive/todo_cubit.dart' show TodoCubit;
import 'package:flutter_todo_app_localdb/feature/cubit/hive/todo_states.dart' show StateLoading, SuccessEnum, SuccessState, TodoCubitState;
import 'package:flutter_todo_app_localdb/feature/model/todo_model.dart';

class HiveTodoListComponent extends StatefulWidget {
  final Color? appBarColor;
  final String title;
  final Function(TodoModel todoModel) addItem;
  final Function(TodoModel todoModel, int index) editItem;
  final Function(int index, String id) deleteItem;

  const HiveTodoListComponent({
    super.key,
    this.appBarColor,
    this.title = 'CRUD Operations',
    required this.addItem,
    required this.editItem,
    required this.deleteItem,
  });

  @override
  State<HiveTodoListComponent> createState() => _HiveTodoListComponentState();
}

class _HiveTodoListComponentState extends State<HiveTodoListComponent> {
  List<TodoModel> todoList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.appBarColor,
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
        body: BlocListener<TodoCubit, TodoCubitState>(
          listener: (context, state) {
            if (state is SuccessState) {
              if (state.type != SuccessEnum.fetch) {
                Utils.showToast(msg: state.msg);
              }
            }
          },
          child: BlocBuilder<TodoCubit, TodoCubitState>(
            builder: (context, state) {
              if (state is SuccessState) {
                todoList = state.todoList;
              }

              return state is StateLoading
                  ? Center(child: CircularProgressIndicator())
                  : todoList.isEmpty
                  ? Center(child: Text("No Records Found"))
                  : ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      var data = todoList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Slidable(
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
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
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
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              color: Colors.grey.shade300,
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
                        ),
                      );
                    },
                  );
            },
          ),
        ),
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
    final formKey = GlobalKey<FormState>();

    var content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Name'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter first name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: valueController,
          decoration: InputDecoration(labelText: 'Value'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter value';
            }
            return null;
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (childContext) {
        return AddEditWidget(
          isEdit: isEdit,
          content: content,
          formKey: formKey,
          submit: () {
            var model = todoModel?.copyWith(
              item: nameController.text,
              quantity: int.parse(valueController.text),
            );

            isEdit
                ? widget.editItem(model!, index)
                : widget.addItem(
                  TodoModel(
                    item: nameController.text,
                    quantity: int.parse(valueController.text),
                  ),
                );
          },
        );
      },
    );
  }
}
