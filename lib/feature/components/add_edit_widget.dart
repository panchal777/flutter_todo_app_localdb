import 'package:flutter/material.dart';

class AddEditWidget extends StatefulWidget {
  final bool isEdit;
  final Function() submit;
  final Widget content;
  final GlobalKey<FormState> formKey;

  const AddEditWidget({
    super.key,
    required this.isEdit,
    required this.submit,
    required this.content,
    required this.formKey,
  });

  @override
  _UserFormDialogState createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<AddEditWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${widget.isEdit ? 'Edit' : 'Add'} User Details',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: Form(key: widget.formKey, child: widget.content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pop(); // Close dialog
              widget.submit();
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
