import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_app_localdb/core/drift_database/app_database.dart';
import 'package:flutter_todo_app_localdb/core/utils/utils.dart';
import 'package:flutter_todo_app_localdb/feature/cubit/user_cubit.dart';
import 'package:flutter_todo_app_localdb/feature/cubit/user_state.dart';

import 'add_edit_widget.dart';

class UserListComponent extends StatefulWidget {
  final Color? appBarColor;
  final String title;
  final Function(UserModelData todoModel) addItem;
  final Function(UserModelData todoModel, int index) editItem;
  final Function(int index, int id) deleteItem;

  const UserListComponent({
    super.key,
    this.appBarColor,
    this.title = 'CRUD Operations',
    required this.addItem,
    required this.editItem,
    required this.deleteItem,
  });

  @override
  State<UserListComponent> createState() => _UserListComponentState();
}

class _UserListComponentState extends State<UserListComponent> {
  List<UserModelData> userList = [];

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
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is SuccessState) {
              if (state.type != SuccessEnum.fetch) {
                Utils.showToast(msg: state.msg);
              }
            }
          },
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is SuccessState) {
                userList = state.userList;
              }

              return state is StateLoading
                  ? Center(child: CircularProgressIndicator())
                  : userList.isEmpty
                  ? Center(child: Text("No Records Found"))
                  : ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      var data = userList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Slidable(
                          enabled: true,
                          key: Key("value$index${data.id}"),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                onPressed: (context) {
                                  _showInputDialog(
                                    isEdit: true,
                                    index: index,
                                    userModel: data,
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
                                  widget.deleteItem(index, data.id);
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
                                    Text("First Name : ${data.firstName}"),
                                    Text("Last Name : ${data.lastName}"),
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
    UserModelData? userModel,
  }) {
    TextEditingController firstNameController = TextEditingController(
      text: isEdit ? userModel?.firstName : '',
    );
    TextEditingController lastNameController = TextEditingController(
      text: isEdit ? userModel?.lastName.toString() : '',
    );

    final formKey = GlobalKey<FormState>();

    var content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: firstNameController,
          decoration: InputDecoration(labelText: 'Firstname'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter first name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: lastNameController,
          decoration: InputDecoration(labelText: 'Lastname'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter last name';
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
            var model = UserModelData(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              id: userModel?.id ?? -1,
            );

            isEdit ? widget.editItem(model, index) : widget.addItem(model);
          },
        );
      },
    );
  }
}
