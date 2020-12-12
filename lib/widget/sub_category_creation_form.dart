import 'package:flutter/material.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/sub_category.dart';

class SubCategoryFormDialog extends StatefulWidget{

  final int subCategoryIndexToUpdate;
  final Category category;

  SubCategoryFormDialog({
    @required this.category,
    this.subCategoryIndexToUpdate,
  });

  _SubCategoryFormDialogState createState() => _SubCategoryFormDialogState();

}
class _SubCategoryFormDialogState extends State<SubCategoryFormDialog> {

  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();

  @override
  void initState(){
    super.initState();

    if(this.widget.subCategoryIndexToUpdate!=null){
      final subCategoryToUpdate = widget.category.subCategories[this.widget.subCategoryIndexToUpdate];
      label.text =   subCategoryToUpdate.label;
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
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        final subCategoryValidated = SubCategory(label: label.text);
                        if(widget.subCategoryIndexToUpdate!=null){
                          subCategoryValidated.items = widget.category.subCategories[widget.subCategoryIndexToUpdate].items;
                          widget.category.subCategories[widget.subCategoryIndexToUpdate]= subCategoryValidated;
                        }else{
                          widget.category.subCategories.add(subCategoryValidated);
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