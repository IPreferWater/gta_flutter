import 'package:flutter/material.dart';

Row widgetRowParameters(String parameter, List<String> parameters, int index){
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(parameter),
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {

        },
      ),
      IconButton(
        icon: Icon(Icons.delete_outline),
        onPressed: () {
          parameters.removeAt(index);
        },
      ),
    ],
  );
}