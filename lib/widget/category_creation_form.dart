import 'package:flutter/material.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/widget/dynamic_list.dart';

import 'category_parameter_text_form_field.dart';

class CategoryFormDialog extends StatefulWidget{

  final Category categoryToUpdate;

  CategoryFormDialog({
    this.categoryToUpdate
  });

  _CategoryFormDialogState createState() => _CategoryFormDialogState();

}
class _CategoryFormDialogState extends State<CategoryFormDialog> {

  FocusNode myFocusNode;

  final _formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();
  List<TextFormField> _parameters =  List();

  @override
  void initState(){
    super.initState();

    if(widget.categoryToUpdate!=null){
      labelController.text = widget.categoryToUpdate.label;
      widget.categoryToUpdate.parameters.forEach((parameter) {
        _parameters.add(
            buildTextFormField(parameter)
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Dialog(
        elevation: 0.0,
        child: dialogContent(context),
      );
  }

  dialogContent(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              TextFormField(
                controller: labelController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Title of the before item',
                  labelText: 'Title',
                ),
                validator: (String value) {
                  return value.isEmpty ? 'must not be empty' : null;
                },
              ),

        DynamicList(parameters: _parameters),

              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  TextFormField newTextFormField = buildTextFormField("");
                  this.setState((){
                    _parameters.add(newTextFormField);
                  });
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: _parameters.isEmpty ? null : () {
                      if (_formKey.currentState.validate()) {
                        List<String> listParameters = _parameters.map((parameter) => parameter.controller.text).toList();
                        final categoryValidated = Category(
                          label: labelController.text,
                          parameters : listParameters
                        );

                        if(widget.categoryToUpdate!=null){
                          categoryValidated.id = widget.categoryToUpdate.id;
                        }
                        Navigator.pop(context, categoryValidated);
                      }
                    },
                    child: Text('Submit'),
                  )),
            ]
        )
    );
  }
  TextFormField buildTextFormField(String parameter){
    return TextFormField(
      controller:  TextEditingController(text: parameter),
      autofocus: true,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Title of the after item',
        labelText: 'Title',
      ),
      validator: (String value) {
        return value.isEmpty ? 'must not be empty' : null;
      },
    );
  }

}


