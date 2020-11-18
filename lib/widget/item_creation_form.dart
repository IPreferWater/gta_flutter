import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/parameter.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';


class ItemFormDialog extends StatefulWidget{

  final Category category;
  final int subCategoryIndex;
  final int itemIndex;

  ItemFormDialog({
    @required this.category,
    @required this.subCategoryIndex,
    this.itemIndex
  });

  _ItemFormDialogState createState() => _ItemFormDialogState();

}
class _ItemFormDialogState extends State<ItemFormDialog> {

  final _formKey = GlobalKey<FormState>();
  List<TextFormField> _parameters = new List();

  @override
  void initState(){
    super.initState();

    widget.category.parameters.forEach((parameter) => _parameters.add(

      new TextFormField(
      controller: new TextEditingController(),
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Title of the after item',
        labelText: parameter,
      ),
      validator: (String value) {
        return value.isEmpty ? 'must not be empty' : null;
      }
    )
      ));

    if(this.widget.itemIndex!=null){
      print("todo Edit item");
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
        ListView.builder(
          shrinkWrap: true,
          itemCount: _parameters.length,
          key: UniqueKey(),
    itemBuilder: (context, index) {
      return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: _parameters[index]
            )
            ]
      );
    }
        ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                        List<Parameter> listParameters = List();

                        for (var i = 0; i < _parameters.length; i++) {
                          String parameterValue = _parameters[i].controller.text;
                          String parameterKey =  widget.category.parameters[i];
                          Parameter newParameter = new Parameter(key: parameterKey, value: parameterValue);
                          listParameters.add(newParameter);
                        }

                        Item itemValidated = new Item(
                          parameters: listParameters
                        );

                        if(widget.itemIndex!=null){
                          widget.category.subCategories[widget.subCategoryIndex].items[widget.subCategoryIndex] = itemValidated ;
                        }else {
                          widget.category.subCategories[widget.subCategoryIndex].items.add(itemValidated);
                        }

                        Navigator.pop(context, widget.category);

                      }
                    },
                    child: Text('Submit'),
                  )),
            ]
        )
    );
  }
}