import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {

  final StatefulWidget formDialog;

  AddButton({@required this.formDialog});

  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => formDialog,
          );
        });
  }
}