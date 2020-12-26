import 'package:flutter/material.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/widget/dynamic_list.dart';

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
                  icon: Icon(Icons.label),
                  hintText: 'title of the category',
                  labelText : 'category title',
                ),
                validator: (String value) {
                  return value.isEmpty ? 'must not be empty' : null;
                },
              ),

        DynamicList(parameters: _parameters),

              Container(
                height: 50.0,
                margin: const EdgeInsets.only(top: 20.0),               // width: MediaQuery.of(context).size.width * 0.5,
                child: FittedBox(
                  child: FloatingActionButton.extended(
                    icon: Icon(Icons.add),
                    label: Text('add parameter'),
                    onPressed: () {
                      TextFormField newTextFormField = buildTextFormField("");
                      this.setState((){
                        _parameters.add(newTextFormField);
                      });
                    },
                  ),
                ),
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
                          categoryValidated.subCategories = widget.categoryToUpdate.subCategories;
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
        hintText: 'new paramater name',
        labelText: 'parameter name',
      ),
      validator: (String value) {
        return value.isEmpty ? 'must not be empty' : null;
      },
    );
  }

}


