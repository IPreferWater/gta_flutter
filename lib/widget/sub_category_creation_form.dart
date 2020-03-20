import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';
import 'package:gta_flutter/bloc/sub_category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/sub_category.dart';

class SubCategoryFormDialog extends StatefulWidget{

  final SubCategory subCategoryToUpdate;

  SubCategoryFormDialog({
    this.subCategoryToUpdate
  });

  _SubCategoryFormDialogState createState() => _SubCategoryFormDialogState();

}
class _SubCategoryFormDialogState extends State<SubCategoryFormDialog> {

  SubCategoryBloc _subCategoryBloc;

  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();

  SubCategory subCategory;

  @override
  void initState(){
    super.initState();

    _subCategoryBloc = BlocProvider.of<SubCategoryBloc>(context);

    if(this.widget.subCategoryToUpdate!=null){
      subCategory = this.widget.subCategoryToUpdate;
      label.text = subCategory.label;
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

                        final subCategoryValidated = SubCategory(label: label.text, categoryId: 1);
                        if(widget.subCategoryToUpdate!=null){

                          subCategoryValidated.id = widget.subCategoryToUpdate.id;
                          _subCategoryBloc.add(UpdateSubCategoryEvent(subCategoryValidated));
                        }else{
                          _subCategoryBloc.add(CreateSubCategoryEvent(subCategoryValidated));
                        }

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