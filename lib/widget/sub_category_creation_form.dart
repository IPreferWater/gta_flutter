import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/sub_category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/sub_category.dart';

class SubCategoryFormDialog extends StatefulWidget{

  final SubCategory subCategoryToUpdate;
  final Category category;

  SubCategoryFormDialog({
    @required this.category,
    this.subCategoryToUpdate,
  });

  _SubCategoryFormDialogState createState() => _SubCategoryFormDialogState();

}
class _SubCategoryFormDialogState extends State<SubCategoryFormDialog> {

  SubCategoryBloc _subCategoryBloc;
  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();

  @override
  void initState(){
    super.initState();

    _subCategoryBloc = BlocProvider.of<SubCategoryBloc>(context);
    _subCategoryBloc.category = widget.category;

    if(this.widget.subCategoryToUpdate!=null){
      label.text =this.widget.subCategoryToUpdate.label;

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

                        final subCategoryValidated = SubCategory(label: label.text, categoryId: widget.category.id);
                        if(widget.subCategoryToUpdate!=null){

                          subCategoryValidated.id = widget.subCategoryToUpdate.id;
                          subCategoryValidated.categoryId = widget.category.id;
                          subCategoryValidated.items = widget.subCategoryToUpdate.items;

                          _subCategoryBloc.add(UpdateSubCategoryEvent(subCategoryValidated));
                        }else{
                         var item = Item(label: "mock", parameters: null);
                         subCategoryValidated.items =  new List.filled(1, item);

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