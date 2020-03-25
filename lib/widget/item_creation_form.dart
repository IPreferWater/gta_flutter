import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/item_bloc/bloc.dart';
import 'package:gta_flutter/bloc/sub_category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/parameter.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:sembast/utils/value_utils.dart';

class ItemFormDialog extends StatefulWidget{

  final SubCategory subCategory;
  final Category category;
  final Item itemToUpdate;

  ItemFormDialog({
    @required this.category,
    @required this.subCategory,
    this.itemToUpdate
  });

  _ItemFormDialogState createState() => _ItemFormDialogState();

}
class _ItemFormDialogState extends State<ItemFormDialog> {

  ItemBloc _itemBloc;
  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();
  List<TextFormField> _parameters = new List();

  @override
  void initState(){
    super.initState();

    _itemBloc = BlocProvider.of<ItemBloc>(context);
    _itemBloc.subCategory = widget.subCategory;

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

    if(this.widget.itemToUpdate!=null){
      //label.text =this.widget.subCategoryToUpdate.label;
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
                controller: label,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Title of the before item',
                  labelText: 'Title',
                ),
                validator: (String value) {
                  return value.isEmpty ? 'must not be empty' : null;
                },
              ),
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

                        //LinkedHashMap hashMapProperties = new LinkedHashMap<String, String>();
                        List<Parameter> listParameters = List();

                        for (var i = 0; i < _parameters.length; i++) {
                          String parameterValue = _parameters[i].controller.text;
                          String parameterKey =  widget.category.parameters[i];
                          Parameter newParameter = new Parameter(key: parameterKey, value: parameterValue);
                          listParameters.add(newParameter);
                        }

                        var subCategoryToUpdate = widget.subCategory;

                        Item itemValidated = new Item(
                          label: label.text,
                          parameters: listParameters
                        );

                        if(widget.itemToUpdate!=null){
                          //_subCategoryBloc.add(UpdateSubCategoryEvent(subCategoryValidated));
                        }else{
                          _itemBloc.add(InsertItem(itemValidated));
                        }

                        //_subCategoryBloc.close();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  )),
            ]
        )
    );
  }
}