import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';

class CategoryFormDialog extends StatefulWidget{

  final Category categoryToUpdate;

  CategoryFormDialog({
    this.categoryToUpdate
  });

  _CategoryFormDialogState createState() => _CategoryFormDialogState();

}
class _CategoryFormDialogState extends State<CategoryFormDialog> {

  CategoryBloc _categoryBloc;

  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();

  int categoryId;
  List<String> parameters ;

  @override
  void initState(){
    super.initState();

    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(LoadCategoriesEvent());

    if(this.widget.categoryToUpdate!=null){
      final Category creationToUpdate = widget.categoryToUpdate;
      categoryId = creationToUpdate.id;

      label.text = creationToUpdate.label;
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
                        final categoryValided = Category(
                          label: label.text
                        );

                        //TODO: make this code correct
                        if(widget.categoryToUpdate!=null){
                          categoryValided.id = widget.categoryToUpdate.id;
                          _categoryBloc.add(UpdateCategoryEvent(categoryValided));
                        }else{
                          _categoryBloc.add(UpdateCategoryEvent(categoryValided));
                        }

                        //in this form we put the state to load only free qrCode, we want to retrieve the other
                        _categoryBloc.add(LoadCategoriesEvent());
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